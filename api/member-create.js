// /api/member-create — coach maakt een lid aan. Genereert een login-code, maakt
// een synthetisch auth-account (e-mail = intern, wachtwoord = de code) en een
// org_members-rij. Geeft de code EENMALIG terug zodat de coach 'm kan doorgeven.
// Alleen aanroepbaar door een geverifieerde coach; het lid komt in de org van de coach.
import crypto from "crypto";
import { rest, genCode, hashCode, adminCreateUser, MEMBER_EMAIL_DOMAIN, userIdFromToken, coachOrgId, readBody } from "./_gym.js";

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).end(); }
  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) return res.status(503).json({ error: "not_configured" });

  const body = readBody(req);
  const authToken = String(body.authToken || "").trim();
  const displayName = String(body.display_name || "").trim().slice(0, 80);

  // Alleen een geverifieerde coach, en het lid komt in ZIJN org.
  const coachId = await userIdFromToken(authToken);
  if (!coachId) return res.status(401).json({ error: "invalid_token" });
  const orgId = await coachOrgId(coachId);
  if (!orgId) return res.status(403).json({ error: "not_a_coach" });

  try {
    const code = genCode(8);
    const email = "m-" + crypto.randomUUID() + "@" + MEMBER_EMAIL_DOMAIN;

    // 1. auth-account (wachtwoord = de code)
    const cr = await adminCreateUser(email, code, { org_id: orgId, role: "member", display_name: displayName });
    if (!cr.ok) { const e = await cr.json().catch(() => ({})); return res.status(502).json({ error: "create_user_failed", detail: e && e.msg }); }
    const user = await cr.json().catch(() => null);
    const uid = user && user.id;
    if (!uid) return res.status(502).json({ error: "create_user_failed" });

    // 2. org_members-rij
    const ins = await rest("org_members", {
      method: "POST",
      headers: { Prefer: "return=representation" },
      body: JSON.stringify({ org_id: orgId, auth_user_id: uid, role: "member", display_name: displayName, code_hash: hashCode(code), active: true }),
    });
    if (!ins.ok) { const e = await ins.text().catch(() => ""); return res.status(502).json({ error: "insert_failed", detail: e.slice(0, 200) }); }
    const rows = await ins.json().catch(() => []);
    const memberId = rows && rows[0] && rows[0].id;

    // code EENMALIG teruggeven (nergens plaintext bewaard)
    return res.status(200).json({ ok: true, member_id: memberId, display_name: displayName, code });
  } catch (err) {
    console.error("member-create error", err);
    return res.status(500).json({ error: "server_error" });
  }
}
