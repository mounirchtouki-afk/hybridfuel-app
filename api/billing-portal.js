// /api/billing-portal — opent het Stripe-klantportaal zodat een abonnee zelf kan
// opzeggen, wijzigen of z'n facturen kan zien.
//
// App stuurt { userId }. We halen de stripe_customer_id uit Supabase (service-role),
// maken een portaalsessie en geven de URL terug.
//
// Env-vars: STRIPE_SECRET_KEY, SUPABASE_URL (of VITE_SUPABASE_URL),
//           SUPABASE_SERVICE_ROLE_KEY, PUBLIC_APP_URL (optioneel).

// Admin-dashboard is ingevouwen in dit endpoint (Vercel Hobby zit op 12 functies).
// Alleen dit e-mailadres mag de admin-ops aanroepen; server-side geverifieerd via het token.
import { kv } from "./_kv.js";

const ADMIN_EMAIL = (process.env.ADMIN_EMAIL || "hybridfuelco@gmail.com").toLowerCase();

function appBase(req) {
  if (process.env.PUBLIC_APP_URL) return process.env.PUBLIC_APP_URL.replace(/\/$/, "");
  const proto = (req.headers["x-forwarded-proto"] || "https").split(",")[0];
  const host = req.headers["x-forwarded-host"] || req.headers.host;
  return proto + "://" + host;
}

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).end(); }

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const authToken = (body && body.authToken || "").trim();
  if (!authToken) return res.status(401).json({ error: "no_auth" });

  const stripeKey = process.env.STRIPE_SECRET_KEY;
  const supaUrl = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
  const svcKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const anon = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
  if (!stripeKey || !supaUrl || !svcKey) return res.status(503).json({ error: "not_configured" });

  try {
    // Verifieer het token bij Supabase en leid de user-id daaruit af. NOOIT een door de
    // client meegestuurde userId vertrouwen, anders kan iemand andermans klantportaal openen.
    const ur = await fetch(supaUrl + "/auth/v1/user", { headers: { apikey: anon, Authorization: "Bearer " + authToken } });
    if (!ur.ok) return res.status(401).json({ error: "invalid_token" });
    const who = await ur.json().catch(() => ({}));
    const userId = who && who.id;
    if (!userId) return res.status(401).json({ error: "no_user" });

    // --- ADMIN-DASHBOARD (alleen ADMIN_EMAIL) ---
    const op = (body && body.op) || "";
    if (op.indexOf("admin.") === 0) {
      if (String((who && who.email) || "").toLowerCase() !== ADMIN_EMAIL) return res.status(403).json({ error: "forbidden" });
      const sv = { apikey: svcKey, Authorization: "Bearer " + svcKey };

      if (op === "admin.list") {
        const users = [];
        for (let page = 1; page <= 50; page++) {
          const ur2 = await fetch(supaUrl + "/auth/v1/admin/users?per_page=200&page=" + page, { headers: sv });
          if (!ur2.ok) break;
          const j = await ur2.json().catch(() => ({}));
          const list = (j && j.users) || [];
          users.push(...list);
          if (list.length < 200) break;
        }
        const subsR = await fetch(supaUrl + "/rest/v1/subscriptions?select=user_id,email,tier,status,current_period_end,stripe_customer_id", { headers: sv });
        const subs = await subsR.json().catch(() => []);
        const subBy = {}; (Array.isArray(subs) ? subs : []).forEach((s) => { subBy[s.user_id] = s; });
        const memR = await fetch(supaUrl + "/rest/v1/org_members?select=user_id,org_id", { headers: sv });
        const mem = await memR.json().catch(() => []);
        const orgR = await fetch(supaUrl + "/rest/v1/org_config?select=org_id,name", { headers: sv });
        const orgs = await orgR.json().catch(() => []);
        const orgName = {}; (Array.isArray(orgs) ? orgs : []).forEach((o) => { orgName[o.org_id] = o.name; });
        const gymBy = {}; (Array.isArray(mem) ? mem : []).forEach((m) => { if (!gymBy[m.user_id]) gymBy[m.user_id] = orgName[m.org_id] || null; });
        const accounts = users.map((u) => {
          const s = subBy[u.id] || {};
          return { id: u.id, email: u.email || s.email || "—", created_at: u.created_at || null, last_sign_in_at: u.last_sign_in_at || null, tier: s.tier || "free", status: s.status || null, period_end: s.current_period_end || null, has_customer: !!s.stripe_customer_id, gym: gymBy[u.id] || null };
        });
        accounts.sort((a, b) => String(b.created_at || "").localeCompare(String(a.created_at || "")));
        const counts = {
          total: accounts.length,
          paying: accounts.filter((a) => a.tier === "pro" || a.tier === "basis").length,
          pro: accounts.filter((a) => a.tier === "pro").length,
          basis: accounts.filter((a) => a.tier === "basis").length,
          gyms: Object.keys(orgName).length,
        };
        return res.status(200).json({ ok: true, accounts, counts });
      }

      if (op === "admin.setTier") {
        const targetUserId = String(body.targetUserId || "").trim();
        const tier = String(body.tier || "").trim();
        if (!targetUserId || ["free", "basis", "pro"].indexOf(tier) < 0) return res.status(400).json({ error: "bad_request" });
        const status = tier === "free" ? "admin_revoked" : "admin_granted";
        // App geeft alleen toegang bij een geldige, niet-verlopen current_period_end.
        // Bij toegang geven zetten we die ver in de toekomst; bij intrekken leeg.
        const periodEnd = tier === "free" ? null : "2099-01-01T00:00:00.000Z";
        const wr = await fetch(supaUrl + "/rest/v1/subscriptions?on_conflict=user_id", {
          method: "POST",
          headers: { ...sv, "Content-Type": "application/json", Prefer: "resolution=merge-duplicates,return=minimal" },
          body: JSON.stringify({ user_id: targetUserId, tier, status, current_period_end: periodEnd, updated_at: new Date().toISOString() }),
        });
        if (!wr.ok) { const txt = await wr.text().catch(() => ""); return res.status(502).json({ error: "write_failed", detail: txt.slice(0, 200) }); }
        return res.status(200).json({ ok: true });
      }

      if (op === "admin.createDemoGym") {
        const name = String(body.gymName || "Demo Sportschool").trim().slice(0, 60) || "Demo Sportschool";
        const slug = ((name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "").slice(0, 24)) || "demo") + "-" + Math.random().toString(36).slice(2, 6);
        const coachEmail = String(body.coachEmail || ("coach+" + slug + "@hybridfuelco.demo")).trim().toLowerCase();
        const coachPass = String(body.coachPass || ("Demo" + Math.random().toString(36).slice(2, 8)));
        const jsonHdr = { ...sv, "Content-Type": "application/json" };
        // 1) org
        const oIns = await fetch(supaUrl + "/rest/v1/orgs", { method: "POST", headers: { ...jsonHdr, Prefer: "return=representation" }, body: JSON.stringify({ name, slug }) });
        const oRows = await oIns.json().catch(() => []);
        const orgId = Array.isArray(oRows) && oRows[0] && oRows[0].id;
        if (!oIns.ok || !orgId) return res.status(502).json({ error: "org_failed", detail: JSON.stringify(oRows).slice(0, 200) });
        // 2) huisstijl (groen)
        await fetch(supaUrl + "/rest/v1/org_config", { method: "POST", headers: { ...jsonHdr, Prefer: "return=minimal,resolution=merge-duplicates" }, body: JSON.stringify({ org_id: orgId, brand_color: "#16A34A", theme: { template: "dark", accent: "#16A34A" } }) });
        // 3) coach-account
        const cu = await fetch(supaUrl + "/auth/v1/admin/users", { method: "POST", headers: jsonHdr, body: JSON.stringify({ email: coachEmail, password: coachPass, email_confirm: true }) });
        const cuRow = await cu.json().catch(() => ({}));
        const coachId = cuRow && cuRow.id;
        if (!coachId) return res.status(502).json({ error: "coach_failed", detail: JSON.stringify(cuRow).slice(0, 200) });
        // 4) coach koppelen aan org
        const mIns = await fetch(supaUrl + "/rest/v1/org_members", { method: "POST", headers: { ...jsonHdr, Prefer: "return=minimal" }, body: JSON.stringify({ org_id: orgId, auth_user_id: coachId, role: "coach", active: true }) });
        if (!mIns.ok) { const txt = await mIns.text().catch(() => ""); return res.status(502).json({ error: "member_failed", detail: txt.slice(0, 200) }); }
        return res.status(200).json({ ok: true, name, slug, coachEmail, coachPass, joinUrl: appBase(req) + "/join/" + slug });
      }

      if (op === "admin.makeMeCoach") {
        const jsonHdr = { ...sv, "Content-Type": "application/json" };
        // Kies de org met de meeste leden (gevuld dashboard); anders maak een HQ-org.
        let orgId = null, orgName = "";
        try {
          const amR = await fetch(supaUrl + "/rest/v1/org_members?select=org_id", { headers: sv });
          const am = amR.ok ? await amR.json().catch(() => []) : [];
          const tally = {}; (am || []).forEach((m) => { if (m.org_id) tally[m.org_id] = (tally[m.org_id] || 0) + 1; });
          const best = Object.keys(tally).sort((a, b) => tally[b] - tally[a])[0];
          if (best) {
            orgId = best;
            const oR = await fetch(supaUrl + "/rest/v1/orgs?select=name&id=eq." + encodeURIComponent(best), { headers: sv });
            const oo = oR.ok ? await oR.json().catch(() => []) : [];
            orgName = (oo && oo[0] && oo[0].name) || "";
          }
        } catch (e) {}
        if (!orgId) {
          const slug = "hybridfuelco-hq-" + Math.random().toString(36).slice(2, 6);
          const oIns = await fetch(supaUrl + "/rest/v1/orgs", { method: "POST", headers: { ...jsonHdr, Prefer: "return=representation" }, body: JSON.stringify({ name: "HybridFuelCo HQ", slug }) });
          const oRows = await oIns.json().catch(() => []);
          orgId = Array.isArray(oRows) && oRows[0] && oRows[0].id; orgName = "HybridFuelCo HQ";
          if (!orgId) return res.status(502).json({ error: "org_failed", detail: JSON.stringify(oRows).slice(0, 200) });
          await fetch(supaUrl + "/rest/v1/org_config", { method: "POST", headers: { ...jsonHdr, Prefer: "return=minimal,resolution=merge-duplicates" }, body: JSON.stringify({ org_id: orgId, brand_color: "#16A34A", theme: { template: "dark", accent: "#16A34A" } }) });
        }
        // Bestaat er al een lidmaatschap voor mij? Dan ombouwen naar coach-eigenaar; anders aanmaken.
        const exR = await fetch(supaUrl + "/rest/v1/org_members?select=org_id&auth_user_id=eq." + encodeURIComponent(userId), { headers: sv });
        const ex = exR.ok ? await exR.json().catch(() => []) : [];
        const payload = { org_id: orgId, role: "coach", is_owner: true, active: true };
        if (ex && ex.length) {
          const up = await fetch(supaUrl + "/rest/v1/org_members?auth_user_id=eq." + encodeURIComponent(userId), { method: "PATCH", headers: { ...jsonHdr, Prefer: "return=minimal" }, body: JSON.stringify(payload) });
          if (!up.ok) { const txt = await up.text().catch(() => ""); return res.status(502).json({ error: "update_failed", detail: txt.slice(0, 200) }); }
        } else {
          const ins = await fetch(supaUrl + "/rest/v1/org_members", { method: "POST", headers: { ...jsonHdr, Prefer: "return=minimal" }, body: JSON.stringify({ ...payload, auth_user_id: userId }) });
          if (!ins.ok) { const txt = await ins.text().catch(() => ""); return res.status(502).json({ error: "insert_failed", detail: txt.slice(0, 200) }); }
        }
        return res.status(200).json({ ok: true, orgName });
      }

      if (op === "admin.overview") {
        const jsonHdr = { ...sv, "Content-Type": "application/json" };
        const oR = await fetch(supaUrl + "/rest/v1/orgs?select=id,name,created_at,license_tier,license_status,license_end", { headers: sv });
        const orgs = oR.ok ? await oR.json().catch(() => []) : [];
        const mR = await fetch(supaUrl + "/rest/v1/org_members?select=org_id,role,active", { headers: sv });
        const mem = mR.ok ? await mR.json().catch(() => []) : [];
        const cnt = {}; mem.forEach((m) => { if (m.role === "member" && m.active !== false) cnt[m.org_id] = (cnt[m.org_id] || 0) + 1; });
        const monthStart = new Date(); monthStart.setUTCDate(1); monthStart.setUTCHours(0, 0, 0, 0);
        const soon = new Date(Date.now() + 30 * 86400000);
        const activeOrgs = orgs.filter((o) => o.license_status !== "stopped");
        const overview = {
          gyms: orgs.length,
          membersActive: Object.values(cnt).reduce((a, b) => a + b, 0),
          gymsPaying: activeOrgs.filter((o) => (o.license_tier || "basis") !== "gratis").length,
          gymsPro: activeOrgs.filter((o) => o.license_tier === "pro").length,
          gymsBasis: activeOrgs.filter((o) => o.license_tier === "basis").length,
          gymsFree: orgs.length - activeOrgs.filter((o) => (o.license_tier || "basis") !== "gratis").length,
          newGyms: orgs.filter((o) => o.created_at && new Date(o.created_at) >= monthStart).sort((a, b) => new Date(b.created_at) - new Date(a.created_at)).slice(0, 8).map((o) => ({ name: o.name, created_at: o.created_at, members: cnt[o.id] || 0 })),
          expiring: orgs.filter((o) => o.license_end && new Date(o.license_end) <= soon && o.license_status !== "stopped").map((o) => ({ name: o.name, license_end: o.license_end })),
        };
        return res.status(200).json({ ok: true, overview });
      }

      if (op === "admin.listGyms") {
        const oR = await fetch(supaUrl + "/rest/v1/orgs?select=id,name,slug,address,postal_code,city,country,contact_name,contact_email,contact_phone,kvk,vat,admin_note,license_tier,license_status,license_start,license_end,owner_user_id,created_at&order=created_at.desc", { headers: sv });
        const orgs = oR.ok ? await oR.json().catch(() => []) : [];
        const mR = await fetch(supaUrl + "/rest/v1/org_members?select=org_id,role,active", { headers: sv });
        const mem = mR.ok ? await mR.json().catch(() => []) : [];
        const cnt = {}; mem.forEach((m) => { if (m.role === "member" && m.active !== false) cnt[m.org_id] = (cnt[m.org_id] || 0) + 1; });
        return res.status(200).json({ ok: true, gyms: orgs.map((o) => ({ ...o, members: cnt[o.id] || 0 })) });
      }

      if (op === "admin.updateGym") {
        const orgId = String(body.orgId || "").trim();
        if (!orgId) return res.status(400).json({ error: "no_org" });
        const allow = ["name", "address", "postal_code", "city", "country", "contact_name", "contact_email", "contact_phone", "kvk", "vat", "admin_note", "license_tier", "license_status", "license_start", "license_end", "owner_user_id"];
        const patch = {}; allow.forEach((k) => { if (body[k] !== undefined) patch[k] = body[k] === "" ? null : body[k]; });
        if (!Object.keys(patch).length) return res.status(400).json({ error: "no_fields" });
        const up = await fetch(supaUrl + "/rest/v1/orgs?id=eq." + encodeURIComponent(orgId), { method: "PATCH", headers: { ...sv, "Content-Type": "application/json", Prefer: "return=minimal" }, body: JSON.stringify(patch) });
        if (!up.ok) { const txt = await up.text().catch(() => ""); return res.status(502).json({ error: "update_failed", detail: txt.slice(0, 200) }); }
        return res.status(200).json({ ok: true });
      }

      if (op === "admin.createGym") {
        const jsonHdr = { ...sv, "Content-Type": "application/json" };
        const name = String(body.name || "").trim().slice(0, 80);
        if (!name) return res.status(400).json({ error: "no_name" });
        const slug = ((name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "").slice(0, 24)) || "gym") + "-" + Math.random().toString(36).slice(2, 6);
        const allow = ["address", "postal_code", "city", "country", "contact_name", "contact_email", "contact_phone", "kvk", "vat", "admin_note", "license_tier", "license_status", "license_start", "license_end", "owner_user_id"];
        const rec = { name, slug }; allow.forEach((k) => { if (body[k] !== undefined && body[k] !== "") rec[k] = body[k]; });
        const oIns = await fetch(supaUrl + "/rest/v1/orgs", { method: "POST", headers: { ...jsonHdr, Prefer: "return=representation" }, body: JSON.stringify(rec) });
        const oRows = await oIns.json().catch(() => []);
        const orgId = Array.isArray(oRows) && oRows[0] && oRows[0].id;
        if (!oIns.ok || !orgId) return res.status(502).json({ error: "org_failed", detail: JSON.stringify(oRows).slice(0, 200) });
        await fetch(supaUrl + "/rest/v1/org_config", { method: "POST", headers: { ...jsonHdr, Prefer: "return=minimal,resolution=merge-duplicates" }, body: JSON.stringify({ org_id: orgId, brand_color: "#16A34A", theme: { template: "dark", accent: "#16A34A" } }) });
        return res.status(200).json({ ok: true, orgId, slug, joinUrl: appBase(req) + "/join/" + slug });
      }

      if (op === "admin.updateMember") {
        const memberId = String(body.memberId || "").trim();
        if (!memberId) return res.status(400).json({ error: "no_member" });
        const allow = ["display_name", "member_tier", "active", "org_id", "plan_id", "class_access"];
        const patch = {}; allow.forEach((k) => { if (body[k] !== undefined) patch[k] = body[k] === "" ? null : body[k]; });
        if (Object.keys(patch).length) {
          const up = await fetch(supaUrl + "/rest/v1/org_members?id=eq." + encodeURIComponent(memberId), { method: "PATCH", headers: { ...sv, "Content-Type": "application/json", Prefer: "return=minimal" }, body: JSON.stringify(patch) });
          if (!up.ok) { const txt = await up.text().catch(() => ""); return res.status(502).json({ error: "update_failed", detail: txt.slice(0, 200) }); }
        }
        return res.status(200).json({ ok: true });
      }

      if (op === "admin.updateAccount") {
        const target = String(body.targetUserId || "").trim();
        if (!target) return res.status(400).json({ error: "no_user" });
        const patch = {};
        if (body.email !== undefined && String(body.email).trim()) { patch.email = String(body.email).trim().toLowerCase(); patch.email_confirm = true; }
        if (body.password !== undefined && String(body.password).length >= 6) patch.password = String(body.password);
        if (!Object.keys(patch).length) return res.status(400).json({ error: "no_fields" });
        const up = await fetch(supaUrl + "/auth/v1/admin/users/" + encodeURIComponent(target), { method: "PUT", headers: { ...sv, "Content-Type": "application/json" }, body: JSON.stringify(patch) });
        const d = await up.json().catch(() => ({}));
        if (!up.ok) return res.status(502).json({ error: "account_update_failed", detail: JSON.stringify(d).slice(0, 200) });
        return res.status(200).json({ ok: true });
      }

      if (op === "admin.stripe") {
        const targetUserId = String(body.targetUserId || "").trim();
        const sr = await fetch(supaUrl + "/rest/v1/subscriptions?select=stripe_customer_id&user_id=eq." + encodeURIComponent(targetUserId), { headers: sv });
        const rows3 = await sr.json().catch(() => []);
        const cust = rows3 && rows3[0] && rows3[0].stripe_customer_id;
        if (!cust) return res.status(404).json({ error: "no_customer" });
        return res.status(200).json({ ok: true, url: "https://dashboard.stripe.com/customers/" + cust });
      }

      if (op === "admin.resetPassword") {
        const email = String(body.email || "").trim().toLowerCase();
        if (!email) return res.status(400).json({ error: "bad_request" });
        const gl = await fetch(supaUrl + "/auth/v1/admin/generate_link", {
          method: "POST", headers: { ...sv, "Content-Type": "application/json" },
          body: JSON.stringify({ type: "recovery", email }),
        });
        const d = await gl.json().catch(() => ({}));
        const link = d && (d.action_link || (d.properties && d.properties.action_link));
        if (!gl.ok || !link) return res.status(502).json({ error: "reset_failed", detail: JSON.stringify(d).slice(0, 200) });
        return res.status(200).json({ ok: true, url: link });
      }

      if (op === "admin.export") {
        const target = (body && body.targetUserId || "").trim();
        // Per-klant: alleen de rijen van die gebruiker. Zonder target: alles (volledige back-up).
        const userCol = { profiles: "id", subscriptions: "user_id", weights: "user_id", plans: "user_id", recipes: "user_id", products: "user_id", org_members: "auth_user_id" };
        const tables = target
          ? ["profiles", "subscriptions", "weights", "plans", "recipes", "products", "org_members"]
          : ["profiles", "subscriptions", "weights", "plans", "recipes", "products", "orgs", "org_config", "org_members"];
        const out = {};
        let email = "";
        if (target) { try { const ur2 = await fetch(supaUrl + "/auth/v1/admin/users/" + encodeURIComponent(target), { headers: sv }); if (ur2.ok) { const u2 = await ur2.json().catch(() => ({})); email = (u2 && u2.email) || ""; } } catch (e) {} }
        for (const tb of tables) {
          const filt = target && userCol[tb] ? "&" + userCol[tb] + "=eq." + encodeURIComponent(target) : "";
          try { const r = await fetch(supaUrl + "/rest/v1/" + tb + "?select=*" + filt, { headers: sv }); out[tb] = r.ok ? await r.json().catch(() => []) : { error: r.status }; }
          catch (e) { out[tb] = { error: String(e).slice(0, 80) }; }
        }
        return res.status(200).json({ ok: true, scope: target ? "customer" : "all", email, exportedAt: new Date().toISOString(), data: out });
      }

      if (op === "admin.getBackupSchedule") {
        const d = await kv(["GET", "backup:schedule"]);
        return res.status(200).json({ ok: true, schedule: (d && d.result) || "monthly", configured: !!(d && d.configured) });
      }
      if (op === "admin.setBackupSchedule") {
        const val = ["off", "weekly", "monthly"].includes(body && body.schedule) ? body.schedule : "monthly";
        const d = await kv(["SET", "backup:schedule", val]);
        if (d && d.configured === false) return res.status(503).json({ error: "kv_not_configured" });
        return res.status(200).json({ ok: true, schedule: val });
      }

      return res.status(400).json({ error: "unknown_op" });
    }

    const r = await fetch(supaUrl + "/rest/v1/subscriptions?select=stripe_customer_id&user_id=eq." + encodeURIComponent(userId), {
      headers: { apikey: svcKey, Authorization: "Bearer " + svcKey },
    });
    const rows = await r.json().catch(() => []);
    const customer = rows && rows[0] && rows[0].stripe_customer_id;
    if (!customer) return res.status(404).json({ error: "no_customer" });

    const params = new URLSearchParams();
    params.set("customer", customer);
    params.set("return_url", appBase(req) + "/?portal=back");
    const pr = await fetch("https://api.stripe.com/v1/billing_portal/sessions", {
      method: "POST",
      headers: { Authorization: "Bearer " + stripeKey, "Content-Type": "application/x-www-form-urlencoded" },
      body: params.toString(),
    });
    const s = await pr.json().catch(() => ({}));
    if (!pr.ok || !s.url) return res.status(502).json({ error: "stripe_error", detail: s && s.error && s.error.message });
    return res.status(200).json({ ok: true, url: s.url });
  } catch (err) {
    console.error("billing-portal error", err);
    return res.status(500).json({ error: "server_error" });
  }
}
