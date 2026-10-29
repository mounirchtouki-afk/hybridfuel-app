// /api/gym — router voor alle sportschool-acties in één serverless-functie
// (Vercel Hobby staat max 12 functies toe, vandaar gebundeld).
// POST { action: "login" | "create" | "reset" | "setup", ... }
//
//   login  (publiek, rate-limited): { orgSlug, code } -> Supabase-sessie
//   create (coach):                 { authToken, display_name } -> { member_id, code }
//   reset  (coach):                 { authToken, member_id } -> { code }
//   setup  (geheim):                { key, slug, name, coachEmail, coachPassword } -> { org_id }
import crypto from "crypto";
import { ipLimited } from "./_ratelimit.js";
import {
  rest, genCode, hashCode, adminCreateUser, adminGetUser, adminSetPassword, adminDeleteUser,
  passwordGrant, userIdFromToken, coachOrgId, ownerOrgId, MEMBER_EMAIL_DOMAIN, readBody,
} from "./_gym.js";

const ALL_MODULES = ["members", "classes", "pt", "plans", "branding", "formula"];

// Platte vorm die de rekenmotor (api/plan.js) direct begrijpt. Alleen deze waarden
// zijn instelbaar; BMR (Mifflin), activiteitsfactoren en de veiligheidsvloer staan vast.
const DEFAULT_CALC = {
  protein_g_per_kg: 2.0,
  fat_g_per_kg: 0.9,
  cut_pct: -18,
  gain_pct: 8,
};

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).end(); }
  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) return res.status(503).json({ error: "not_configured" });
  const body = readBody(req);
  const action = String(body.action || "").trim();

  try {
    if (action === "branding") return await branding(req, res, body);
    if (action === "login")  return await login(req, res, body);
    if (action === "create") return await create(req, res, body);
    if (action === "reset")  return await reset(req, res, body);
    if (action === "remove") return await remove(req, res, body);
    if (action === "addcoach")   return await addcoach(req, res, body);
    if (action === "setperms")   return await setperms(req, res, body);
    if (action === "editcoach")  return await editcoach(req, res, body);
    if (action === "removecoach") return await removecoach(req, res, body);
    if (action === "setup")  return await setup(req, res, body);
    return res.status(400).json({ error: "unknown_action" });
  } catch (err) {
    console.error("gym error", action, err);
    return res.status(500).json({ error: "server_error" });
  }
}

// --- branding: publieke white-label-gegevens voor de join-pagina (vóór login) ---
async function branding(req, res, body) {
  const slug = String(body.slug || "").trim().toLowerCase();
  if (!slug) return res.status(400).json({ error: "bad_request" });
  const or = await rest("orgs?select=id,name&slug=eq." + encodeURIComponent(slug) + "&limit=1");
  const orgs = or.ok ? await or.json().catch(() => []) : [];
  const org = orgs && orgs[0];
  if (!org) return res.status(404).json({ error: "not_found" });
  const cr = await rest("org_config?select=brand_color,logo_url&org_id=eq." + encodeURIComponent(org.id) + "&limit=1");
  const cfg = cr.ok ? (await cr.json().catch(() => []))[0] : null;
  // Thema apart + guarded: de theme-kolom bestaat mogelijk nog niet (vóór migratie).
  let theme = null;
  try {
    const tr = await rest("org_config?select=theme&org_id=eq." + encodeURIComponent(org.id) + "&limit=1");
    if (tr.ok) { const tRows = await tr.json().catch(() => []); theme = (tRows && tRows[0] && tRows[0].theme) || null; }
  } catch (e) {}
  return res.status(200).json({ ok: true, name: org.name, brand_color: (cfg && cfg.brand_color) || "#E11D48", logo_url: (cfg && cfg.logo_url) || null, theme });
}

// --- login: code -> sessie (publiek, rate-limited, generieke fouten) ---
async function login(req, res, body) {
  if (await ipLimited(req, "mlogin", 10, 300)) return res.status(429).json({ error: "too_many_attempts" });
  const slug = String(body.orgSlug || "").trim().toLowerCase();
  const code = String(body.code || "").trim().toUpperCase();
  if (!slug || !code) return res.status(400).json({ error: "bad_request" });
  const fail = () => res.status(401).json({ error: "invalid_code" });

  const or = await rest("orgs?select=id&slug=eq." + encodeURIComponent(slug) + "&limit=1");
  const orgs = or.ok ? await or.json().catch(() => []) : [];
  const orgId = orgs && orgs[0] && orgs[0].id;
  if (!orgId) return fail();

  const ch = hashCode(code);
  const mr = await rest("org_members?select=auth_user_id&org_id=eq." + encodeURIComponent(orgId) +
    "&code_hash=eq." + encodeURIComponent(ch) + "&role=eq.member&active=eq.true&limit=1");
  const mem = mr.ok ? await mr.json().catch(() => []) : [];
  const uid = mem && mem[0] && mem[0].auth_user_id;
  if (!uid) return fail();

  const user = await adminGetUser(uid);
  const email = user && user.email;
  if (!email) return fail();

  const gr = await passwordGrant(email, code);
  if (!gr.ok) return fail();
  const sess = await gr.json().catch(() => null);
  if (!sess || !sess.access_token) return fail();

  return res.status(200).json({ ok: true, access_token: sess.access_token, refresh_token: sess.refresh_token, expires_in: sess.expires_in });
}

// --- create: coach maakt lid + code ---
async function create(req, res, body) {
  const coachId = await userIdFromToken(String(body.authToken || "").trim());
  if (!coachId) return res.status(401).json({ error: "invalid_token" });
  const orgId = await coachOrgId(coachId);
  if (!orgId) return res.status(403).json({ error: "not_a_coach" });

  const displayName = String(body.display_name || "").trim().slice(0, 80);
  const tier = ["basis", "pro"].includes(String(body.tier)) ? String(body.tier) : "pro";
  const code = genCode(8);
  const email = "m-" + crypto.randomUUID() + "@" + MEMBER_EMAIL_DOMAIN;

  const cr = await adminCreateUser(email, code, { org_id: orgId, role: "member", display_name: displayName });
  if (!cr.ok) { const e = await cr.json().catch(() => ({})); return res.status(502).json({ error: "create_user_failed", detail: e && e.msg }); }
  const user = await cr.json().catch(() => null);
  const uid = user && user.id;
  if (!uid) return res.status(502).json({ error: "create_user_failed" });

  const ins = await rest("org_members", {
    method: "POST", headers: { Prefer: "return=representation" },
    body: JSON.stringify({ org_id: orgId, auth_user_id: uid, role: "member", display_name: displayName, code_hash: hashCode(code), active: true }),
  });
  if (!ins.ok) { const e = await ins.text().catch(() => ""); return res.status(502).json({ error: "insert_failed", detail: e.slice(0, 200) }); }
  const rows = await ins.json().catch(() => []);
  const memberId = rows && rows[0] && rows[0].id;
  // Tier zetten (guarded; kolom bestaat mogelijk nog niet vóór migratie). Default = pro.
  if (memberId && tier !== "pro") {
    try { await rest("org_members?id=eq." + encodeURIComponent(memberId), { method: "PATCH", body: JSON.stringify({ member_tier: tier }) }); } catch (e) {}
  }
  return res.status(200).json({ ok: true, member_id: memberId, display_name: displayName, code });
}

// --- reset: coach genereert nieuwe code voor een lid ---
async function reset(req, res, body) {
  const coachId = await userIdFromToken(String(body.authToken || "").trim());
  if (!coachId) return res.status(401).json({ error: "invalid_token" });
  const orgId = await coachOrgId(coachId);
  if (!orgId) return res.status(403).json({ error: "not_a_coach" });

  const memberId = String(body.member_id || "").trim();
  if (!memberId) return res.status(400).json({ error: "bad_request" });

  const mr = await rest("org_members?select=id,auth_user_id,org_id,role&id=eq." + encodeURIComponent(memberId) + "&limit=1");
  const rows = mr.ok ? await mr.json().catch(() => []) : [];
  const mem = rows && rows[0];
  if (!mem || mem.org_id !== orgId || mem.role !== "member") return res.status(404).json({ error: "not_found" });

  const code = genCode(8);
  const up = await adminSetPassword(mem.auth_user_id, code);
  if (!up.ok) return res.status(502).json({ error: "reset_failed" });
  const uh = await rest("org_members?id=eq." + encodeURIComponent(memberId), { method: "PATCH", body: JSON.stringify({ code_hash: hashCode(code) }) });
  if (!uh.ok) return res.status(502).json({ error: "reset_failed" });
  return res.status(200).json({ ok: true, member_id: memberId, code });
}

// --- remove: coach verwijdert een lid (org_members-rij + auth-gebruiker) ---
async function remove(req, res, body) {
  const coachId = await userIdFromToken(String(body.authToken || "").trim());
  if (!coachId) return res.status(401).json({ error: "invalid_token" });
  const orgId = await coachOrgId(coachId);
  if (!orgId) return res.status(403).json({ error: "not_a_coach" });

  const memberId = String(body.member_id || "").trim();
  if (!memberId) return res.status(400).json({ error: "bad_request" });

  const mr = await rest("org_members?select=id,auth_user_id,org_id,role&id=eq." + encodeURIComponent(memberId) + "&limit=1");
  const rows = mr.ok ? await mr.json().catch(() => []) : [];
  const mem = rows && rows[0];
  if (!mem || mem.org_id !== orgId || mem.role !== "member") return res.status(404).json({ error: "not_found" });

  // Best-effort: afgeleide data opruimen, dan de lidrij, dan de auth-gebruiker.
  try { await rest("member_progress?user_id=eq." + encodeURIComponent(mem.auth_user_id), { method: "DELETE" }); } catch (e) {}
  try { await rest("org_sessions?member_id=eq." + encodeURIComponent(mem.auth_user_id), { method: "DELETE" }); } catch (e) {}
  const del = await rest("org_members?id=eq." + encodeURIComponent(memberId), { method: "DELETE" });
  if (!del.ok) { const e = await del.text().catch(() => ""); return res.status(502).json({ error: "delete_failed", detail: e.slice(0, 200) }); }
  try { await adminDeleteUser(mem.auth_user_id); } catch (e) {}
  return res.status(200).json({ ok: true, member_id: memberId });
}

// --- addcoach: EIGENAAR maakt een medewerker/coach-account (e-mail+wachtwoord) + rechten ---
async function addcoach(req, res, body) {
  const callerId = await userIdFromToken(String(body.authToken || "").trim());
  if (!callerId) return res.status(401).json({ error: "invalid_token" });
  const orgId = await ownerOrgId(callerId);
  if (!orgId) return res.status(403).json({ error: "not_owner" });

  const email = String(body.email || "").trim().toLowerCase();
  const password = String(body.password || "");
  const displayName = String(body.display_name || "").trim().slice(0, 80) || email;
  const perms = Array.isArray(body.perms) ? body.perms.filter((p) => ALL_MODULES.includes(p)) : [];
  if (!email || password.length < 8) return res.status(400).json({ error: "bad_request" });

  const cu = await adminCreateUser(email, password, { org_id: orgId, role: "coach" });
  if (!cu.ok) { const e = await cu.json().catch(() => ({})); return res.status(409).json({ error: "coach_exists_or_failed", detail: e && (e.msg || e.error_description) }); }
  const coach = await cu.json().catch(() => null);
  const uid = coach && coach.id;
  if (!uid) return res.status(502).json({ error: "coach_failed" });

  const ins = await rest("org_members", { method: "POST", headers: { Prefer: "return=representation" }, body: JSON.stringify({ org_id: orgId, auth_user_id: uid, role: "coach", display_name: displayName, is_owner: false, perms, active: true }) });
  if (!ins.ok) { const e = await ins.text().catch(() => ""); return res.status(502).json({ error: "insert_failed", detail: e.slice(0, 200) }); }
  const rows = await ins.json().catch(() => []);
  return res.status(200).json({ ok: true, coach_id: rows && rows[0] && rows[0].id, email });
}

// --- setperms: EIGENAAR wijzigt de rechten van een coach ---
async function setperms(req, res, body) {
  const callerId = await userIdFromToken(String(body.authToken || "").trim());
  if (!callerId) return res.status(401).json({ error: "invalid_token" });
  const orgId = await ownerOrgId(callerId);
  if (!orgId) return res.status(403).json({ error: "not_owner" });

  const memberId = String(body.member_id || "").trim();
  const perms = Array.isArray(body.perms) ? body.perms.filter((p) => ALL_MODULES.includes(p)) : [];
  if (!memberId) return res.status(400).json({ error: "bad_request" });

  const mr = await rest("org_members?select=id,org_id,role,is_owner&id=eq." + encodeURIComponent(memberId) + "&limit=1");
  const rows = mr.ok ? await mr.json().catch(() => []) : [];
  const mem = rows && rows[0];
  if (!mem || mem.org_id !== orgId || mem.role !== "coach" || mem.is_owner) return res.status(404).json({ error: "not_found" });

  const up = await rest("org_members?id=eq." + encodeURIComponent(memberId), { method: "PATCH", body: JSON.stringify({ perms }) });
  if (!up.ok) return res.status(502).json({ error: "update_failed" });
  return res.status(200).json({ ok: true, member_id: memberId, perms });
}

// --- editcoach: EIGENAAR wijzigt naam en/of wachtwoord van een coach ---
async function editcoach(req, res, body) {
  const callerId = await userIdFromToken(String(body.authToken || "").trim());
  if (!callerId) return res.status(401).json({ error: "invalid_token" });
  const orgId = await ownerOrgId(callerId);
  if (!orgId) return res.status(403).json({ error: "not_owner" });

  const memberId = String(body.member_id || "").trim();
  if (!memberId) return res.status(400).json({ error: "bad_request" });

  const mr = await rest("org_members?select=id,auth_user_id,org_id,role,is_owner&id=eq." + encodeURIComponent(memberId) + "&limit=1");
  const rows = mr.ok ? await mr.json().catch(() => []) : [];
  const mem = rows && rows[0];
  if (!mem || mem.org_id !== orgId || mem.role !== "coach" || mem.is_owner) return res.status(404).json({ error: "not_found" });

  const name = body.display_name != null ? String(body.display_name).trim().slice(0, 80) : null;
  const password = body.password != null ? String(body.password) : null;

  if (name != null) { try { await rest("org_members?id=eq." + encodeURIComponent(memberId), { method: "PATCH", body: JSON.stringify({ display_name: name }) }); } catch (e) {} }
  if (password) {
    if (password.length < 8) return res.status(400).json({ error: "pw_too_short" });
    const up = await adminSetPassword(mem.auth_user_id, password);
    if (!up.ok) return res.status(502).json({ error: "pw_failed" });
  }
  return res.status(200).json({ ok: true, member_id: memberId });
}

// --- removecoach: EIGENAAR verwijdert een coach (niet zichzelf) ---
async function removecoach(req, res, body) {
  const callerId = await userIdFromToken(String(body.authToken || "").trim());
  if (!callerId) return res.status(401).json({ error: "invalid_token" });
  const orgId = await ownerOrgId(callerId);
  if (!orgId) return res.status(403).json({ error: "not_owner" });

  const memberId = String(body.member_id || "").trim();
  if (!memberId) return res.status(400).json({ error: "bad_request" });

  const mr = await rest("org_members?select=id,auth_user_id,org_id,role,is_owner&id=eq." + encodeURIComponent(memberId) + "&limit=1");
  const rows = mr.ok ? await mr.json().catch(() => []) : [];
  const mem = rows && rows[0];
  if (!mem || mem.org_id !== orgId || mem.role !== "coach" || mem.is_owner) return res.status(404).json({ error: "not_found" });

  const del = await rest("org_members?id=eq." + encodeURIComponent(memberId), { method: "DELETE" });
  if (!del.ok) return res.status(502).json({ error: "delete_failed" });
  try { await adminDeleteUser(mem.auth_user_id); } catch (e) {}
  return res.status(200).json({ ok: true, member_id: memberId });
}

// --- setup: bootstrap org + coach (met geheim) ---
async function setup(req, res, body) {
  const key = String((req.query && req.query.key) || body.key || "");
  if (!process.env.UNLOCK_SECRET || key !== process.env.UNLOCK_SECRET) return res.status(401).json({ error: "unauthorized" });

  const slug = String(body.slug || "").trim().toLowerCase().replace(/[^a-z0-9-]/g, "");
  const name = String(body.name || "").trim();
  const coachEmail = String(body.coachEmail || "").trim().toLowerCase();
  const coachPassword = String(body.coachPassword || "");
  if (!slug || !name || !coachEmail || coachPassword.length < 8) return res.status(400).json({ error: "bad_request" });

  let orgId;
  const ex = await rest("orgs?select=id&slug=eq." + encodeURIComponent(slug) + "&limit=1");
  const exRows = ex.ok ? await ex.json().catch(() => []) : [];
  if (exRows && exRows[0]) orgId = exRows[0].id;
  else {
    const cr = await rest("orgs", { method: "POST", headers: { Prefer: "return=representation" }, body: JSON.stringify({ slug, name }) });
    if (!cr.ok) { const e = await cr.text().catch(() => ""); return res.status(502).json({ error: "org_failed", detail: e.slice(0, 200) }); }
    const rows = await cr.json().catch(() => []);
    orgId = rows && rows[0] && rows[0].id;
  }
  if (!orgId) return res.status(502).json({ error: "org_failed" });

  await rest("org_config", { method: "POST", headers: { Prefer: "resolution=merge-duplicates" }, body: JSON.stringify({ org_id: orgId, calc_profile: DEFAULT_CALC }) });

  const cu = await adminCreateUser(coachEmail, coachPassword, { org_id: orgId, role: "coach" });
  if (!cu.ok) { const e = await cu.json().catch(() => ({})); return res.status(409).json({ error: "coach_exists_or_failed", detail: e && (e.msg || e.error_description) }); }
  const coach = await cu.json().catch(() => null);
  const coachId = coach && coach.id;
  if (!coachId) return res.status(502).json({ error: "coach_failed" });

  const im = await rest("org_members", { method: "POST", headers: { Prefer: "return=representation" }, body: JSON.stringify({ org_id: orgId, auth_user_id: coachId, role: "coach", display_name: "Coach", active: true }) });
  if (!im.ok) { const e = await im.text().catch(() => ""); return res.status(502).json({ error: "coach_link_failed", detail: e.slice(0, 200) }); }
  // Eerste account = eigenaar (guarded; kolom bestaat mogelijk nog niet vóór migratie).
  try { const rows = await im.json().catch(() => []); const id = rows && rows[0] && rows[0].id; if (id) await rest("org_members?id=eq." + encodeURIComponent(id), { method: "PATCH", body: JSON.stringify({ is_owner: true }) }); } catch (e) {}

  return res.status(200).json({ ok: true, org_id: orgId, slug, coach_user_id: coachId, join_url: "/join/" + slug });
}
