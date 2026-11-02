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

      if (op === "admin.stripe") {
        const targetUserId = String(body.targetUserId || "").trim();
        const sr = await fetch(supaUrl + "/rest/v1/subscriptions?select=stripe_customer_id&user_id=eq." + encodeURIComponent(targetUserId), { headers: sv });
        const rows3 = await sr.json().catch(() => []);
        const cust = rows3 && rows3[0] && rows3[0].stripe_customer_id;
        if (!cust) return res.status(404).json({ error: "no_customer" });
        return res.status(200).json({ ok: true, url: "https://dashboard.stripe.com/customers/" + cust });
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
