import React, { useState, useEffect } from "react";
import { INK, INK2, PAPER, MUTED, LINE, EMBER, disp } from "../shared.js";
import { apiUrl } from "../apiBase";

const GREEN = "#16A34A";

async function call(token, op, extra) {
  const r = await fetch(apiUrl("/api/billing-portal"), {
    method: "POST", headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ authToken: token, op, ...(extra || {}) }),
  });
  const d = await r.json().catch(() => ({}));
  if (!r.ok) throw new Error(((d && d.error) || ("http_" + r.status)) + (d && d.detail ? " — " + d.detail : ""));
  return d;
}
function download(obj, fname) {
  const blob = new Blob([JSON.stringify(obj, null, 2)], { type: "application/json" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a"); a.href = url; a.download = fname;
  document.body.appendChild(a); a.click(); a.remove();
  setTimeout(() => URL.revokeObjectURL(url), 2000);
}

const card = { background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16 };
const lblS = { fontSize: 10, letterSpacing: 0.7, textTransform: "uppercase", color: MUTED, fontWeight: 800, margin: "14px 0 6px" };
const fieldS = { flex: 1, background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "10px 12px", fontSize: 13.5, borderRadius: 9, outline: "none", boxSizing: "border-box", fontFamily: "Inter, sans-serif" };
const btnS = (bg) => ({ cursor: "pointer", background: bg, color: "#fff", fontWeight: 800, fontSize: 12.5, padding: "10px 14px", borderRadius: 9, whiteSpace: "nowrap", ...disp, textAlign: "center" });
const ghostS = { cursor: "pointer", background: INK, border: `1px solid ${LINE}`, color: PAPER, fontWeight: 800, fontSize: 12.5, padding: "10px 14px", borderRadius: 9, whiteSpace: "nowrap", ...disp, textAlign: "center" };

// ===== OVERVIEW (platform) =====
export function AdminOverview({ session, lang }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const token = (session && session.access_token) || "";
  const [ov, setOv] = useState(null);
  const [err, setErr] = useState("");
  useEffect(() => { call(token, "admin.overview").then((d) => setOv(d.overview)).catch((e) => setErr(String(e.message || e))); }, []);
  const fmt = (s) => { try { return new Date(s).toLocaleDateString(lang === "nl" ? "nl-NL" : "en-GB", { day: "numeric", month: "short" }); } catch (e) { return "—"; } };
  const stat = (v, l, g) => (<div style={card}><div style={{ ...disp, fontWeight: 800, fontSize: 26, color: g ? GREEN : PAPER, lineHeight: 1 }}>{v}</div><div style={{ fontSize: 10, letterSpacing: 0.6, textTransform: "uppercase", color: MUTED, marginTop: 7, fontWeight: 700 }}>{l}</div></div>);
  if (err) return <div style={{ ...card, color: EMBER }}>{err}</div>;
  if (!ov) return <div style={{ ...card, color: MUTED }}>{t("Laden…", "Loading…")}</div>;
  const tot = ov.gyms || 1;
  return (
    <div style={{ display: "grid", gap: 16 }}>
      <div style={{ display: "grid", gridTemplateColumns: "repeat(5,1fr)", gap: 12 }}>
        {stat(ov.gyms, t("Sportscholen", "Gyms"), true)}
        {stat(ov.membersActive, t("Actieve leden", "Active members"))}
        {stat(ov.gymsPaying, t("Betalend", "Paying"), true)}
        {stat(ov.gymsPro, "Pro")}
        {stat(ov.gymsBasis, "Basis")}
      </div>
      <div style={card}>
        <div style={{ fontSize: 10, letterSpacing: 0.8, textTransform: "uppercase", color: MUTED, fontWeight: 800, marginBottom: 10 }}>{t("Verdeling", "Breakdown")}</div>
        <div style={{ display: "flex", height: 20, borderRadius: 6, overflow: "hidden", background: LINE }}>
          <div style={{ width: (ov.gymsPro / tot * 100) + "%", background: GREEN }} />
          <div style={{ width: (ov.gymsBasis / tot * 100) + "%", background: "#6366F1" }} />
        </div>
      </div>
      <div style={card}>
        <div style={{ fontSize: 10, letterSpacing: 0.8, textTransform: "uppercase", color: MUTED, fontWeight: 800, marginBottom: 10 }}>{t("Nieuwe sportscholen · deze maand", "New gyms · this month")}</div>
        {(ov.newGyms || []).length === 0 && <div style={{ color: MUTED, fontSize: 13 }}>{t("Nog geen nieuwe deze maand.", "None yet this month.")}</div>}
        {(ov.newGyms || []).map((g, i) => (
          <div key={i} style={{ display: "flex", justifyContent: "space-between", padding: "9px 0", borderBottom: `1px solid ${LINE}`, fontSize: 13, color: PAPER }}>
            <span>{g.name}</span><span style={{ color: MUTED, fontSize: 12 }}>{fmt(g.created_at)} · {g.members} {t("leden", "members")}</span>
          </div>
        ))}
      </div>
      {(ov.expiring || []).length > 0 && (
        <div style={{ ...card, borderColor: EMBER }}>
          <div style={{ fontSize: 10, letterSpacing: 0.8, textTransform: "uppercase", color: EMBER, fontWeight: 800, marginBottom: 10 }}>{t("Licenties lopen binnenkort af", "Licenses expiring soon")}</div>
          {ov.expiring.map((g, i) => (<div key={i} style={{ display: "flex", justifyContent: "space-between", padding: "7px 0", fontSize: 13, color: PAPER }}><span>{g.name}</span><span style={{ color: EMBER }}>{fmt(g.license_end)}</span></div>))}
        </div>
      )}
    </div>
  );
}

// ===== ACCOUNT (filter: sportscholen / members) =====
export function AdminAccount({ session, lang }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const token = (session && session.access_token) || "";
  const [mode, setMode] = useState("gyms"); // gyms | members
  const [gyms, setGyms] = useState(null);
  const [members, setMembers] = useState(null);
  const [q, setQ] = useState("");
  const [sel, setSel] = useState(null);   // geselecteerde rij (bewerken)
  const [err, setErr] = useState("");
  const [msg, setMsg] = useState("");

  async function loadGyms() { try { const d = await call(token, "admin.listGyms"); setGyms(d.gyms || []); } catch (e) { setErr(String(e.message || e)); } }
  async function loadMembers() { try { const d = await call(token, "admin.list"); setMembers(d.accounts || []); } catch (e) { setErr(String(e.message || e)); } }
  useEffect(() => { loadGyms(); loadMembers(); }, []);

  const seg = (id, lbl) => (<div onClick={() => { setMode(id); setSel(null); }} style={{ cursor: "pointer", fontSize: 13, fontWeight: 800, ...disp, padding: "9px 16px", borderRadius: 9, border: `1px solid ${mode === id ? GREEN : LINE}`, background: mode === id ? GREEN : "transparent", color: mode === id ? "#fff" : MUTED }}>{lbl}</div>);

  if (sel && mode === "gyms") return <GymEditor token={token} lang={lang} gym={sel} onBack={() => { setSel(null); loadGyms(); }} />;
  if (sel && mode === "members") return <MemberEditor token={token} lang={lang} acc={sel} onBack={() => { setSel(null); loadMembers(); }} />;

  const gl = (gyms || []).filter((g) => !q.trim() || ((g.name || "") + " " + (g.city || "")).toLowerCase().includes(q.toLowerCase()));
  const ml = (members || []).filter((m) => !q.trim() || ((m.email || "") + " " + (m.gym || "")).toLowerCase().includes(q.toLowerCase()));
  const pill = (txt, c) => <span style={{ fontSize: 9.5, fontWeight: 800, padding: "3px 8px", borderRadius: 5, border: `1px solid ${c || LINE}`, color: c || MUTED }}>{txt}</span>;

  return (
    <div style={{ display: "grid", gap: 14 }}>
      <div style={{ display: "flex", gap: 8, alignItems: "center", flexWrap: "wrap" }}>
        {seg("gyms", t("Sportscholen", "Gyms"))}{seg("members", "Members")}
        <div style={{ flex: 1 }} />
        {mode === "gyms" && <div onClick={() => setSel({ _new: true, license_tier: "basis", license_status: "active", country: "NL" })} style={btnS(GREEN)}>+ {t("Sportschool", "Gym")}</div>}
      </div>
      <input value={q} onChange={(e) => setQ(e.target.value)} placeholder={t("Zoeken…", "Search…")} style={{ ...fieldS, flex: "none" }} />
      {err && <div style={{ ...card, color: EMBER }}>{err}</div>}
      {msg && <div style={{ ...card, color: GREEN }}>{msg}</div>}

      {mode === "gyms" && (
        <div style={{ ...card, padding: "4px 16px" }}>
          {!gyms && <div style={{ padding: 18, color: MUTED }}>{t("Laden…", "Loading…")}</div>}
          {gyms && gl.length === 0 && <div style={{ padding: 18, color: MUTED }}>{t("Geen sportscholen.", "No gyms.")}</div>}
          {gl.map((g, i) => (
            <div key={g.id} onClick={() => setSel(g)} style={{ cursor: "pointer", display: "flex", justifyContent: "space-between", alignItems: "center", padding: "12px 0", borderTop: i > 0 ? `1px solid ${LINE}` : "none" }}>
              <div style={{ minWidth: 0 }}>
                <div style={{ fontWeight: 700, fontSize: 14, color: PAPER }}>{g.name}</div>
                <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{[g.address, g.city].filter(Boolean).join(" · ") || t("geen adres", "no address")}</div>
              </div>
              <div style={{ display: "flex", gap: 6, alignItems: "center" }}>
                {pill((g.members || 0) + " " + t("leden", "members"))}
                {pill(g.license_status === "stopped" ? t("gestopt", "stopped") : (g.license_tier || "basis"), g.license_status === "stopped" ? EMBER : GREEN)}
                <span style={{ color: MUTED, fontSize: 16 }}>›</span>
              </div>
            </div>
          ))}
        </div>
      )}

      {mode === "members" && (
        <div style={{ ...card, padding: "4px 16px" }}>
          {!members && <div style={{ padding: 18, color: MUTED }}>{t("Laden…", "Loading…")}</div>}
          {members && ml.length === 0 && <div style={{ padding: 18, color: MUTED }}>{t("Geen members.", "No members.")}</div>}
          {ml.map((m, i) => (
            <div key={m.id} onClick={() => setSel(m)} style={{ cursor: "pointer", display: "flex", justifyContent: "space-between", alignItems: "center", padding: "12px 0", borderTop: i > 0 ? `1px solid ${LINE}` : "none" }}>
              <div style={{ minWidth: 0 }}>
                <div style={{ fontWeight: 700, fontSize: 14, color: PAPER, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{m.email}</div>
                <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{m.gym || t("geen sportschool", "no gym")}</div>
              </div>
              <div style={{ display: "flex", gap: 6, alignItems: "center" }}>
                {pill(m.tier === "free" ? t("gratis", "free") : m.tier, m.tier === "free" ? MUTED : GREEN)}
                <span style={{ color: MUTED, fontSize: 16 }}>›</span>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

// ===== Sportschool bewerken / aanmaken =====
function GymEditor({ token, lang, gym, onBack }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const [f, setF] = useState({ ...gym });
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");
  const set = (k, v) => setF((p) => ({ ...p, [k]: v }));
  const F = (label, k, ph) => (<div><div style={lblS}>{label}</div><input value={f[k] || ""} onChange={(e) => set(k, e.target.value)} placeholder={ph || ""} style={fieldS} /></div>);
  async function save() {
    if (!f.name || !f.name.trim()) { setErr(t("Naam is verplicht.", "Name is required.")); return; }
    setBusy(true); setErr("");
    try {
      if (f._new) { const d = await call(token, "admin.createGym", f); if (f.license_start || f.license_end || f.license_status || f.license_tier) await call(token, "admin.updateGym", { orgId: d.orgId, license_tier: f.license_tier, license_status: f.license_status, license_start: f.license_start, license_end: f.license_end }); }
      else await call(token, "admin.updateGym", { orgId: f.id, name: f.name, address: f.address, postal_code: f.postal_code, city: f.city, country: f.country, contact_name: f.contact_name, contact_email: f.contact_email, contact_phone: f.contact_phone, kvk: f.kvk, vat: f.vat, admin_note: f.admin_note, license_tier: f.license_tier, license_status: f.license_status, license_start: f.license_start, license_end: f.license_end });
      onBack();
    } catch (e) { setErr(String(e.message || e)); setBusy(false); }
  }
  const segTier = (id, lbl) => (<div onClick={() => set("license_tier", id)} style={{ cursor: "pointer", fontSize: 12.5, fontWeight: 800, ...disp, padding: "8px 14px", borderRadius: 8, border: `1px solid ${f.license_tier === id ? GREEN : LINE}`, background: f.license_tier === id ? GREEN : "transparent", color: f.license_tier === id ? "#fff" : MUTED }}>{lbl}</div>);
  const active = (f.license_status || "active") !== "stopped";
  // standaard licentie-einddatum = 1 jaar na start
  const setYear = () => { const s = f.license_start ? new Date(f.license_start) : new Date(); const e = new Date(s); e.setFullYear(e.getFullYear() + 1); set("license_start", s.toISOString().slice(0, 10)); set("license_end", e.toISOString().slice(0, 10)); };
  return (
    <div style={{ display: "grid", gap: 2, maxWidth: 620 }}>
      <div onClick={onBack} style={{ cursor: "pointer", color: MUTED, fontSize: 13, fontWeight: 700, marginBottom: 6 }}>‹ {t("Terug", "Back")}</div>
      <div style={{ ...disp, fontWeight: 800, fontSize: 20, color: PAPER }}>{f._new ? t("Nieuwe sportschool", "New gym") : f.name}</div>
      <div style={{ fontSize: 12, color: MUTED, marginBottom: 6 }}>{t("Alle administratiegegevens · ", "All administration data · ")}<span style={{ color: EMBER }}>*</span> {t("= verplicht", "= required")}</div>
      {err && <div style={{ ...card, color: EMBER }}>{err}</div>}
      <div><div style={lblS}>{t("Naam", "Name")} <span style={{ color: EMBER }}>*</span></div><input value={f.name || ""} onChange={(e) => set("name", e.target.value)} style={fieldS} /></div>
      {F(t("Adres", "Address"), "address")}
      <div style={{ display: "flex", gap: 10 }}><div style={{ flex: 1 }}>{F(t("Postcode", "Postal code"), "postal_code")}</div><div style={{ flex: 2 }}>{F(t("Stad", "City"), "city")}</div></div>
      {F(t("Contactpersoon", "Contact"), "contact_name")}
      <div style={{ display: "flex", gap: 10 }}><div style={{ flex: 1 }}>{F("E-mail", "contact_email")}</div><div style={{ flex: 1 }}>{F(t("Telefoon", "Phone"), "contact_phone")}</div></div>
      <div style={{ display: "flex", gap: 10 }}><div style={{ flex: 1 }}>{F("KvK", "kvk")}</div><div style={{ flex: 1 }}>{F("Btw", "vat")}</div></div>
      {F(t("Notitie", "Note"), "admin_note")}

      <div style={lblS}>{t("Licentie", "License")}</div>
      <div style={{ display: "flex", gap: 7, marginBottom: 10 }}>{segTier("pro", "Pro")}{segTier("basis", "Basis")}{segTier("gratis", t("Gratis", "Free"))}</div>
      <div style={{ display: "flex", gap: 10, alignItems: "flex-end" }}>
        <div style={{ flex: 1 }}><div style={lblS}>{t("Start", "Start")}</div><input type="date" value={f.license_start || ""} onChange={(e) => set("license_start", e.target.value)} style={fieldS} /></div>
        <div style={{ flex: 1 }}><div style={lblS}>{t("Einde", "End")}</div><input type="date" value={f.license_end || ""} onChange={(e) => set("license_end", e.target.value)} style={fieldS} /></div>
        <div onClick={setYear} style={ghostS}>{t("+1 jaar", "+1 year")}</div>
      </div>
      <div style={{ display: "flex", gap: 8, marginTop: 12 }}>
        <div onClick={() => set("license_status", active ? "stopped" : "active")} style={active ? btnS(EMBER) : btnS(GREEN)}>{active ? t("Licentie stopzetten", "Stop license") : t("Licentie activeren", "Activate license")}</div>
        <div style={{ flex: 1 }} />
        <div onClick={busy ? null : save} style={{ ...btnS(GREEN), opacity: busy ? 0.6 : 1, padding: "12px 22px" }}>{busy ? "…" : t("Opslaan", "Save")}</div>
      </div>
    </div>
  );
}

// ===== Member / account bewerken =====
function MemberEditor({ token, lang, acc, onBack }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const [email, setEmail] = useState(acc.email || "");
  const [pw, setPw] = useState("");
  const [tier, setTier] = useState(acc.tier || "free");
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");
  const [resetUrl, setResetUrl] = useState("");
  async function saveEmail() { setBusy(true); setErr(""); try { await call(token, "admin.updateAccount", { targetUserId: acc.id, email }); } catch (e) { setErr(String(e.message || e)); } setBusy(false); }
  async function savePw() { if (pw.length < 6) { setErr(t("Wachtwoord min. 6 tekens.", "Password min 6 chars.")); return; } setBusy(true); setErr(""); try { await call(token, "admin.updateAccount", { targetUserId: acc.id, password: pw }); setPw(""); } catch (e) { setErr(String(e.message || e)); } setBusy(false); }
  async function resetLink() { setBusy(true); setErr(""); try { const d = await call(token, "admin.resetPassword", { email }); setResetUrl(d.url); } catch (e) { setErr(String(e.message || e)); } setBusy(false); }
  async function changeTier(v) {
    setErr("");
    try {
      const d = await call(token, "admin.setTier", { targetUserId: acc.id, tier: v });
      const stored = d && d.tier ? d.tier : v;
      setTier(stored);
      if (stored !== v) setErr(t("Niet opgeslagen — staat nu op: ", "Not saved — now set to: ") + stored);
    } catch (e) { setErr(t("Opslaan mislukt: ", "Save failed: ") + String(e.message || e)); }
  }
  const segTier = (id, lbl) => (<div onClick={() => changeTier(id)} style={{ cursor: "pointer", fontSize: 12.5, fontWeight: 800, ...disp, padding: "8px 14px", borderRadius: 8, border: `1px solid ${tier === id ? GREEN : LINE}`, background: tier === id ? GREEN : "transparent", color: tier === id ? "#fff" : MUTED }}>{lbl}</div>);
  return (
    <div style={{ display: "grid", gap: 2, maxWidth: 560 }}>
      <div onClick={onBack} style={{ cursor: "pointer", color: MUTED, fontSize: 13, fontWeight: 700, marginBottom: 6 }}>‹ {t("Terug", "Back")}</div>
      <div style={{ ...disp, fontWeight: 800, fontSize: 20, color: PAPER }}>{acc.email}</div>
      <div style={{ fontSize: 12, color: MUTED, marginBottom: 6 }}>{acc.gym || t("Account", "Account")}</div>
      {err && <div style={{ ...card, color: EMBER }}>{err}</div>}
      <div style={lblS}>{t("E-mailadres", "Email")}</div>
      <div style={{ display: "flex", gap: 8 }}><input value={email} onChange={(e) => setEmail(e.target.value)} style={fieldS} /><div onClick={busy ? null : saveEmail} style={ghostS}>{t("Opslaan", "Save")}</div></div>
      <div style={lblS}>{t("Nieuw wachtwoord", "New password")}</div>
      <div style={{ display: "flex", gap: 8 }}><input value={pw} onChange={(e) => setPw(e.target.value)} placeholder={t("nieuw wachtwoord", "new password")} style={fieldS} /><div onClick={busy ? null : savePw} style={ghostS}>{t("Instellen", "Set")}</div></div>
      <div onClick={busy ? null : resetLink} style={{ ...ghostS, marginTop: 8 }}>{t("Of: stuur herstellink", "Or: make reset link")} ↗</div>
      {resetUrl && <div style={{ ...card, marginTop: 8, wordBreak: "break-all", fontSize: 12, color: PAPER }}>{resetUrl}<div onClick={() => { try { navigator.clipboard.writeText(resetUrl); } catch (e) {} }} style={{ ...btnS(GREEN), display: "inline-block", marginTop: 8, padding: "7px 12px" }}>{t("Kopieer", "Copy")}</div></div>}
      <div style={lblS}>{t("Licentie / pakket", "License / plan")}</div>
      <div style={{ display: "flex", gap: 7 }}>{segTier("pro", "Pro")}{segTier("basis", "Basis")}{segTier("free", t("Gratis / stop", "Free / stop"))}</div>
    </div>
  );
}
