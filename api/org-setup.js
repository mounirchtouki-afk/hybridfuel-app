// /api/org-setup — eenmalige bootstrap van een sportschool (org) + coach-account.
// Beveiligd met UNLOCK_SECRET (?key=... of body.key). Voor de pilot; later vervangen
// door self-serve onboarding. Coach logt daarna normaal in met e-mail+wachtwoord;
// leden met een code. Idempotent op de org-slug.
import { rest, adminCreateUser, MEMBER_EMAIL_DOMAIN, readBody } from "./_gym.js";

const DEFAULT_CALC = {
  bmr: "mifflin",
  activity: { sedentary: 1.2, light: 1.375, moderate: 1.55, active: 1.725, very: 1.9 },
  macros: { protein_g_per_kg: 2.0, fat_pct: 25 },
  goal: { cut_pct: -17, maintain: 0, gain_pct: 12 },
};

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).end(); }
  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) return res.status(503).json({ error: "not_configured" });

  const body = readBody(req);
  const key = String((req.query && req.query.key) || body.key || "");
  if (!process.env.UNLOCK_SECRET || key !== process.env.UNLOCK_SECRET) return res.status(401).json({ error: "unauthorized" });

  const slug = String(body.slug || "").trim().toLowerCase().replace(/[^a-z0-9-]/g, "");
  const name = String(body.name || "").trim();
  const coachEmail = String(body.coachEmail || "").trim().toLowerCase();
  const coachPassword = String(body.coachPassword || "");
  if (!slug || !name || !coachEmail || coachPassword.length < 8) return res.status(400).json({ error: "bad_request" });

  try {
    // 1. org (idempotent op slug)
    let orgId;
    const ex = await rest("orgs?select=id&slug=eq." + encodeURIComponent(slug) + "&limit=1");
    const exRows = ex.ok ? await ex.json().catch(() => []) : [];
    if (exRows && exRows[0]) {
      orgId = exRows[0].id;
    } else {
      const cr = await rest("orgs", { method: "POST", headers: { Prefer: "return=representation" }, body: JSON.stringify({ slug, name }) });
      if (!cr.ok) { const e = await cr.text().catch(() => ""); return res.status(502).json({ error: "org_failed", detail: e.slice(0, 200) }); }
      const rows = await cr.json().catch(() => []);
      orgId = rows && rows[0] && rows[0].id;
    }
    if (!orgId) return res.status(502).json({ error: "org_failed" });

    // 2. org_config (defaults) — upsert
    await rest("org_config", {
      method: "POST",
      headers: { Prefer: "resolution=merge-duplicates" },
      body: JSON.stringify({ org_id: orgId, calc_profile: DEFAULT_CALC }),
    });

    // 3. coach auth-account
    const cu = await adminCreateUser(coachEmail, coachPassword, { org_id: orgId, role: "coach" });
    if (!cu.ok) { const e = await cu.json().catch(() => ({})); return res.status(409).json({ error: "coach_exists_or_failed", detail: e && (e.msg || e.error_description) }); }
    const coach = await cu.json().catch(() => null);
    const coachId = coach && coach.id;
    if (!coachId) return res.status(502).json({ error: "coach_failed" });

    // 4. org_members coach-rij
    const im = await rest("org_members", {
      method: "POST",
      body: JSON.stringify({ org_id: orgId, auth_user_id: coachId, role: "coach", display_name: "Coach", active: true }),
    });
    if (!im.ok) { const e = await im.text().catch(() => ""); return res.status(502).json({ error: "coach_link_failed", detail: e.slice(0, 200) }); }

    return res.status(200).json({ ok: true, org_id: orgId, slug, coach_user_id: coachId, join_url: "/join/" + slug });
  } catch (err) {
    console.error("org-setup error", err);
    return res.status(500).json({ error: "server_error" });
  }
}
