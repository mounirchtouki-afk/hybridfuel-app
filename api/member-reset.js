// /api/member-reset — coach genereert een nieuwe login-code voor een lid
// (vervangt de oude; herstel bij vergeten code, want er is geen e-mail).
// Alleen voor een lid binnen de org van de geverifieerde coach.
import { rest, genCode, hashCode, adminSetPassword, userIdFromToken, coachOrgId, readBody } from "./_gym.js";

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).end(); }
  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) return res.status(503).json({ error: "not_configured" });

  const body = readBody(req);
  const authToken = String(body.authToken || "").trim();
  const memberId = String(body.member_id || "").trim();
  if (!memberId) return res.status(400).json({ error: "bad_request" });

  const coachId = await userIdFromToken(authToken);
  if (!coachId) return res.status(401).json({ error: "invalid_token" });
  const orgId = await coachOrgId(coachId);
  if (!orgId) return res.status(403).json({ error: "not_a_coach" });

  try {
    // lid moet in de org van de coach zitten
    const mr = await rest("org_members?select=id,auth_user_id,org_id,role&id=eq." + encodeURIComponent(memberId) + "&limit=1");
    const rows = mr.ok ? await mr.json().catch(() => []) : [];
    const mem = rows && rows[0];
    if (!mem || mem.org_id !== orgId || mem.role !== "member") return res.status(404).json({ error: "not_found" });

    const code = genCode(8);
    const up = await adminSetPassword(mem.auth_user_id, code);
    if (!up.ok) return res.status(502).json({ error: "reset_failed" });

    const uh = await rest("org_members?id=eq." + encodeURIComponent(memberId), {
      method: "PATCH",
      body: JSON.stringify({ code_hash: hashCode(code) }),
    });
    if (!uh.ok) return res.status(502).json({ error: "reset_failed" });

    return res.status(200).json({ ok: true, member_id: memberId, code });
  } catch (err) {
    console.error("member-reset error", err);
    return res.status(500).json({ error: "server_error" });
  }
}
