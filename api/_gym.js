// Gedeelde helpers voor de sportschool-code-login (server-side, service-role).
// NB: alleen op de server gebruiken — nooit de service-role key naar de client.
import crypto from "crypto";

export function supaUrl() {
  return (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
}
export function svcKey() { return process.env.SUPABASE_SERVICE_ROLE_KEY; }
export function anonKey() {
  return process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
}

// Synthetische e-mail per lid: nooit verstuurd, alleen een interne auth-identifier.
export const MEMBER_EMAIL_DOMAIN = "members.hybridfuelco.app";

// Leesbare code zonder verwarrende tekens (geen 0/O/1/I). ~40 bits bij 8 tekens.
export function genCode(len = 8) {
  const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
  const bytes = crypto.randomBytes(len);
  let out = "";
  for (let i = 0; i < len; i++) out += alphabet[bytes[i] % alphabet.length];
  return out;
}

// Hash van de code (alleen voor lookup; de echte auth is het Supabase-wachtwoord).
// Optionele pepper uit env verhoogt de drempel als de DB ooit lekt.
export function hashCode(code) {
  const pepper = process.env.GYM_CODE_PEPPER || "";
  return crypto.createHash("sha256").update(pepper + ":" + String(code).toUpperCase()).digest("hex");
}

// --- Supabase REST (service-role) ---
export async function rest(path, init = {}) {
  const r = await fetch(supaUrl() + "/rest/v1/" + path, {
    ...init,
    headers: { apikey: svcKey(), Authorization: "Bearer " + svcKey(), "Content-Type": "application/json", ...(init.headers || {}) },
  });
  return r;
}

// --- Supabase Auth admin ---
export async function adminCreateUser(email, password, meta = {}) {
  const r = await fetch(supaUrl() + "/auth/v1/admin/users", {
    method: "POST",
    headers: { apikey: svcKey(), Authorization: "Bearer " + svcKey(), "Content-Type": "application/json" },
    body: JSON.stringify({ email, password, email_confirm: true, user_metadata: meta }),
  });
  return r;
}
export async function adminGetUser(userId) {
  const r = await fetch(supaUrl() + "/auth/v1/admin/users/" + encodeURIComponent(userId), {
    headers: { apikey: svcKey(), Authorization: "Bearer " + svcKey() },
  });
  return r.ok ? r.json().catch(() => null) : null;
}
export async function adminSetPassword(userId, password) {
  const r = await fetch(supaUrl() + "/auth/v1/admin/users/" + encodeURIComponent(userId), {
    method: "PUT",
    headers: { apikey: svcKey(), Authorization: "Bearer " + svcKey(), "Content-Type": "application/json" },
    body: JSON.stringify({ password }),
  });
  return r;
}
export async function adminUpdateUser(userId, fields) {
  const r = await fetch(supaUrl() + "/auth/v1/admin/users/" + encodeURIComponent(userId), {
    method: "PUT",
    headers: { apikey: svcKey(), Authorization: "Bearer " + svcKey(), "Content-Type": "application/json" },
    body: JSON.stringify(fields || {}),
  });
  return r;
}
export async function adminDeleteUser(userId) {
  const r = await fetch(supaUrl() + "/auth/v1/admin/users/" + encodeURIComponent(userId), {
    method: "DELETE",
    headers: { apikey: svcKey(), Authorization: "Bearer " + svcKey() },
  });
  return r;
}
// Logt een (synthetische) gebruiker in met wachtwoord en geeft de sessie terug.
export async function passwordGrant(email, password) {
  const r = await fetch(supaUrl() + "/auth/v1/token?grant_type=password", {
    method: "POST",
    headers: { apikey: anonKey(), "Content-Type": "application/json" },
    body: JSON.stringify({ email, password }),
  });
  return r;
}

// Verifieer een client-authtoken en geef de user-id terug (of null).
export async function userIdFromToken(authToken) {
  if (!authToken) return null;
  const r = await fetch(supaUrl() + "/auth/v1/user", { headers: { apikey: anonKey(), Authorization: "Bearer " + authToken } });
  if (!r.ok) return null;
  const u = await r.json().catch(() => null);
  return (u && u.id) || null;
}

// Is deze user een actieve coach? Zo ja, geef zijn org_id terug.
export async function coachOrgId(userId) {
  if (!userId) return null;
  const r = await rest("org_members?select=org_id,role,active&auth_user_id=eq." + encodeURIComponent(userId) + "&role=eq.coach&active=eq.true&limit=1");
  if (!r.ok) return null;
  const rows = await r.json().catch(() => []);
  return (rows && rows[0] && rows[0].org_id) || null;
}

// Geeft org_id alleen terug als de gebruiker EIGENAAR is (is_owner=true). Guarded: als de
// kolom nog niet bestaat (vóór migratie) valt 'ie terug op gewone coach-rechten.
export async function ownerOrgId(userId) {
  if (!userId) return null;
  try {
    const r = await rest("org_members?select=org_id,is_owner&auth_user_id=eq." + encodeURIComponent(userId) + "&role=eq.coach&active=eq.true&limit=1");
    if (r.ok) { const rows = await r.json().catch(() => []); const row = rows && rows[0]; if (row && row.is_owner) return row.org_id; return null; }
  } catch (e) {}
  // Fallback vóór migratie: eerste coach = eigenaar.
  return await coachOrgId(userId);
}

export function readBody(req) {
  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  return body || {};
}
