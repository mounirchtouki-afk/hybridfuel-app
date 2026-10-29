// /api/member-login — code-login voor sportschool-leden (geen e-mail).
// POST { orgSlug, code } -> verifieert de code, logt het bijbehorende (synthetische)
// account in en geeft een Supabase-sessie terug. Rate-limited tegen brute force.
// Generieke foutmeldingen, zodat je niet kunt aftasten welke code/slug bestaat.
import { ipLimited } from "./_ratelimit.js";
import { rest, hashCode, adminGetUser, passwordGrant, readBody } from "./_gym.js";

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).end(); }
  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) return res.status(503).json({ error: "not_configured" });

  // Brute-force rem: per IP max 10 pogingen / 5 min (faalt open als KV ontbreekt).
  if (await ipLimited(req, "mlogin", 10, 300)) return res.status(429).json({ error: "too_many_attempts" });

  const body = readBody(req);
  const slug = String(body.orgSlug || "").trim().toLowerCase();
  const code = String(body.code || "").trim().toUpperCase();
  if (!slug || !code) return res.status(400).json({ error: "bad_request" });

  const fail = () => res.status(401).json({ error: "invalid_code" }); // altijd generiek

  try {
    // 1. org by slug
    const or = await rest("orgs?select=id&slug=eq." + encodeURIComponent(slug) + "&limit=1");
    const orgs = or.ok ? await or.json().catch(() => []) : [];
    const orgId = orgs && orgs[0] && orgs[0].id;
    if (!orgId) return fail();

    // 2. member by code_hash binnen die org
    const ch = hashCode(code);
    const mr = await rest("org_members?select=auth_user_id&org_id=eq." + encodeURIComponent(orgId) +
      "&code_hash=eq." + encodeURIComponent(ch) + "&role=eq.member&active=eq.true&limit=1");
    const mem = mr.ok ? await mr.json().catch(() => []) : [];
    const uid = mem && mem[0] && mem[0].auth_user_id;
    if (!uid) return fail();

    // 3. e-mail (synthetisch) ophalen en inloggen met de code als wachtwoord
    const user = await adminGetUser(uid);
    const email = user && user.email;
    if (!email) return fail();

    const gr = await passwordGrant(email, code);
    if (!gr.ok) return fail();
    const sess = await gr.json().catch(() => null);
    if (!sess || !sess.access_token) return fail();

    return res.status(200).json({
      ok: true,
      access_token: sess.access_token,
      refresh_token: sess.refresh_token,
      expires_in: sess.expires_in,
    });
  } catch (err) {
    console.error("member-login error", err);
    return res.status(500).json({ error: "server_error" });
  }
}
