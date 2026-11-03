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

// Nette bevestig-popup in de huisstijl (vervangt window.confirm).
function ConfirmModal({ open, title, message, confirmLabel, cancelLabel, onConfirm, onCancel, busy, accent }) {
  if (!open) return null;
  const red = accent || EMBER;
  return (
    <div onClick={busy ? null : onCancel} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.6)", display: "grid", placeItems: "center", zIndex: 1000, padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 16, padding: 22, maxWidth: 380, width: "100%", boxShadow: "0 24px 70px rgba(0,0,0,0.55)" }}>
        <div style={{ width: 46, height: 46, borderRadius: 12, background: "rgba(225,29,72,0.14)", display: "grid", placeItems: "center", marginBottom: 14 }}>
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke={red} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M3 6h18M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6M10 11v6M14 11v6" /></svg>
        </div>
        <div style={{ ...disp, fontWeight: 800, fontSize: 19, color: PAPER, marginBottom: 6 }}>{title}</div>
        <div style={{ fontSize: 13.5, color: MUTED, lineHeight: 1.55, marginBottom: 18 }}>{message}</div>
        <div style={{ display: "flex", gap: 10 }}>
          <div onClick={busy ? null : onCancel} style={{ ...ghostS, flex: 1, opacity: busy ? 0.6 : 1 }}>{cancelLabel}</div>
          <div onClick={busy ? null : onConfirm} style={{ ...btnS(red), flex: 1, opacity: busy ? 0.6 : 1 }}>{busy ? "…" : confirmLabel}</div>
        </div>
      </div>
    </div>
  );
}

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
export function AdminAccount({ session, lang, color }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const token = (session && session.access_token) || "";
  const brand = color || EMBER;
  const [mode, setMode] = useState("gyms"); // gyms | members | trash
  const [gyms, setGyms] = useState(null);
  const [members, setMembers] = useState(null);
  const [trash, setTrash] = useState(null);
  const [q, setQ] = useState("");
  const [sel, setSel] = useState(null);   // geselecteerde rij (bewerken)
  const [err, setErr] = useState("");
  const [msg, setMsg] = useState("");
  const [rowBusy, setRowBusy] = useState("");
  const [purge, setPurge] = useState(null); // {kind,id,label} wacht op bevestiging definitief verwijderen

  async function loadGyms() { try { const d = await call(token, "admin.listGyms"); setGyms(d.gyms || []); } catch (e) { setErr(String(e.message || e)); } }
  async function loadMembers() { try { const d = await call(token, "admin.list"); setMembers(d.accounts || []); } catch (e) { setErr(String(e.message || e)); } }
  async function loadTrash() { try { const d = await call(token, "admin.listTrash"); setTrash(d); } catch (e) { setErr(String(e.message || e)); } }
  useEffect(() => { loadGyms(); loadMembers(); loadTrash(); }, []);

  async function restore(kind, id) { setRowBusy(id); setErr(""); try { await call(token, kind === "gym" ? "admin.restoreGym" : "admin.restoreMember", kind === "gym" ? { orgId: id } : { targetUserId: id }); await loadTrash(); await loadGyms(); await loadMembers(); } catch (e) { setErr(String(e.message || e)); } setRowBusy(""); }
  async function doPurge() { if (!purge) return; setRowBusy(purge.id); setErr(""); try { await call(token, purge.kind === "gym" ? "admin.purgeGym" : "admin.purgeMember", purge.kind === "gym" ? { orgId: purge.id } : { targetUserId: purge.id }); setPurge(null); await loadTrash(); } catch (e) { setErr(String(e.message || e)); } setRowBusy(""); }

  const seg = (id, lbl) => (<div onClick={() => { setMode(id); setSel(null); }} style={{ cursor: "pointer", fontSize: 13, fontWeight: 800, ...disp, padding: "9px 16px", borderRadius: 9, border: `1px solid ${mode === id ? brand : LINE}`, background: mode === id ? brand : "transparent", color: mode === id ? "#fff" : MUTED }}>{lbl}</div>);

  if (sel && mode === "gyms") return <GymEditor token={token} lang={lang} gym={sel} accent={brand} onBack={() => { setSel(null); loadGyms(); loadTrash(); }} />;
  if (sel && mode === "members") return <MemberEditor token={token} lang={lang} acc={sel} accent={brand} onBack={() => { setSel(null); loadMembers(); loadTrash(); }} />;

  const gl = (gyms || []).filter((g) => !q.trim() || ((g.name || "") + " " + (g.city || "")).toLowerCase().includes(q.toLowerCase()));
  const ml = (members || []).filter((m) => !q.trim() || ((m.email || "") + " " + (m.gym || "")).toLowerCase().includes(q.toLowerCase()));
  const pill = (txt, c) => <span style={{ fontSize: 9.5, fontWeight: 800, padding: "3px 8px", borderRadius: 5, border: `1px solid ${c || LINE}`, color: c || MUTED }}>{txt}</span>;

  return (
    <div style={{ display: "grid", gap: 14 }}>
      <div style={{ display: "flex", gap: 8, alignItems: "center", flexWrap: "wrap" }}>
        {seg("gyms", t("Sportscholen", "Gyms"))}{seg("members", "Members")}{seg("trash", t("Prullenbak", "Trash") + (trash && (trash.gyms.length + trash.members.length) ? " (" + (trash.gyms.length + trash.members.length) + ")" : ""))}
        <div style={{ flex: 1 }} />
        {mode === "gyms" && <div onClick={() => setSel({ _new: true, license_tier: "basis", license_status: "active", country: "NL" })} style={btnS(brand)}>+ {t("Sportschool", "Gym")}</div>}
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

      {mode === "trash" && (
        <div style={{ ...card, padding: "4px 16px" }}>
          {!trash && <div style={{ padding: 18, color: MUTED }}>{t("Laden…", "Loading…")}</div>}
          {trash && trash.gyms.length === 0 && trash.members.length === 0 && <div style={{ padding: 18, color: MUTED }}>{t("Prullenbak is leeg.", "Trash is empty.")}</div>}
          {trash && trash.gyms.map((g, i) => (
            <div key={g.id} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "12px 0", borderTop: i > 0 ? `1px solid ${LINE}` : "none", opacity: rowBusy === g.id ? 0.5 : 1 }}>
              <div style={{ minWidth: 0 }}><div style={{ fontWeight: 700, fontSize: 14, color: PAPER }}>{g.name} <span style={{ fontSize: 10, color: MUTED }}>· {t("sportschool", "gym")}</span></div><div style={{ fontSize: 11.5, color: MUTED }}>{g.city || ""}</div></div>
              <div style={{ display: "flex", gap: 6 }}>
                <div onClick={() => restore("gym", g.id)} style={{ cursor: "pointer", fontSize: 11, fontWeight: 800, ...disp, padding: "6px 11px", borderRadius: 7, border: `1px solid ${GREEN}`, color: GREEN }}>{t("Herstellen", "Restore")}</div>
                <div onClick={() => setPurge({ kind: "gym", id: g.id, label: g.name })} style={{ cursor: "pointer", fontSize: 11, fontWeight: 800, ...disp, padding: "6px 11px", borderRadius: 7, border: `1px solid ${EMBER}`, color: EMBER }}>{t("Definitief", "Delete")}</div>
              </div>
            </div>
          ))}
          {trash && trash.members.map((m, i) => (
            <div key={m.id} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "12px 0", borderTop: (i > 0 || trash.gyms.length) ? `1px solid ${LINE}` : "none", opacity: rowBusy === m.id ? 0.5 : 1 }}>
              <div style={{ minWidth: 0 }}><div style={{ fontWeight: 700, fontSize: 14, color: PAPER, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{m.email} <span style={{ fontSize: 10, color: MUTED }}>· member</span></div></div>
              <div style={{ display: "flex", gap: 6 }}>
                <div onClick={() => restore("member", m.id)} style={{ cursor: "pointer", fontSize: 11, fontWeight: 800, ...disp, padding: "6px 11px", borderRadius: 7, border: `1px solid ${GREEN}`, color: GREEN }}>{t("Herstellen", "Restore")}</div>
                <div onClick={() => setPurge({ kind: "member", id: m.id, label: m.email })} style={{ cursor: "pointer", fontSize: 11, fontWeight: 800, ...disp, padding: "6px 11px", borderRadius: 7, border: `1px solid ${EMBER}`, color: EMBER }}>{t("Definitief", "Delete")}</div>
              </div>
            </div>
          ))}
        </div>
      )}

      <ConfirmModal open={!!purge} busy={!!rowBusy}
        title={t("Definitief verwijderen?", "Delete permanently?")}
        message={t("'" + (purge && purge.label || "") + "' wordt definitief verwijderd. Dit kan NIET meer hersteld worden.", "'" + (purge && purge.label || "") + "' will be permanently deleted. This can NOT be restored.")}
        confirmLabel={t("Definitief verwijderen", "Delete permanently")} cancelLabel={t("Annuleren", "Cancel")}
        onConfirm={doPurge} onCancel={() => setPurge(null)} />
    </div>
  );
}

// ===== Sportschool bewerken / aanmaken =====
function GymEditor({ token, lang, gym, accent, onBack }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const [f, setF] = useState({ ...gym });
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");
  const [created, setCreated] = useState(null);
  const set = (k, v) => setF((p) => ({ ...p, [k]: v }));
  const F = (label, k, ph) => (<div><div style={lblS}>{label}</div><input value={f[k] || ""} onChange={(e) => set(k, e.target.value)} placeholder={ph || ""} style={fieldS} /></div>);
  async function save() {
    if (!f.name || !f.name.trim()) { setErr(t("Naam is verplicht.", "Name is required.")); return; }
    if (f._new && (!f.contact_email || !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(f.contact_email.trim()))) { setErr(t("Geldig e-mailadres is verplicht — dit wordt de coach-login.", "Valid email required — this is the coach login.")); return; }
    setBusy(true); setErr("");
    try {
      if (f._new) {
        const d = await call(token, "admin.createGym", f);
        if (f.license_start || f.license_end || f.license_status || f.license_tier) await call(token, "admin.updateGym", { orgId: d.orgId, license_tier: f.license_tier, license_status: f.license_status, license_start: f.license_start, license_end: f.license_end });
        setCreated(d); setBusy(false); return;
      }
      await call(token, "admin.updateGym", { orgId: f.id, name: f.name, address: f.address, postal_code: f.postal_code, city: f.city, country: f.country, contact_name: f.contact_name, contact_email: f.contact_email, contact_phone: f.contact_phone, kvk: f.kvk, vat: f.vat, admin_note: f.admin_note, license_tier: f.license_tier, license_status: f.license_status, license_start: f.license_start, license_end: f.license_end });
      onBack();
    } catch (e) { setErr(String(e.message || e)); setBusy(false); }
  }
  if (created) return (
    <div style={{ display: "grid", gap: 10, maxWidth: 560 }}>
      <div style={{ ...disp, fontWeight: 800, fontSize: 20, color: PAPER }}>{t("Sportschool aangemaakt", "Gym created")} · {f.name}</div>
      <div style={{ ...card, borderColor: GREEN }}>
        {created.emailSent
          ? <div style={{ fontSize: 13, color: GREEN, fontWeight: 700, marginBottom: 8 }}>✓ {t("Uitnodiging gemaild naar ", "Invite emailed to ")}{created.coachEmail}</div>
          : <div style={{ fontSize: 12.5, color: EMBER, fontWeight: 700, marginBottom: 8 }}>{t("Mail kon niet automatisch verstuurd worden — stuur de link hieronder zelf.", "Email couldn't be sent automatically — send the link below yourself.")}</div>}
        <div style={{ fontSize: 12.5, color: PAPER, lineHeight: 1.7 }}>
          {t("Coach-login:", "Coach login:")}<br />
          <b>E-mail:</b> <span style={{ color: GREEN }}>{created.coachEmail}</span><br />
          <b>{t("Wachtwoord instellen", "Set password")}:</b>
          {created.inviteUrl ? <div style={{ wordBreak: "break-all", color: GREEN, marginTop: 4 }}>{created.inviteUrl}</div> : <span style={{ color: MUTED }}> {t("(link maken mislukt — gebruik Reset ww bij Members)", "(link failed — use Reset pw under Members)")}</span>}
        </div>
        {created.inviteUrl && <div onClick={() => { try { navigator.clipboard.writeText(created.inviteUrl); } catch (e) {} }} style={{ ...btnS(GREEN), display: "inline-block", marginTop: 10, padding: "8px 14px" }}>{t("Kopieer link", "Copy link")}</div>}
      </div>
      <div style={{ fontSize: 11.5, color: MUTED }}>{t("De sportschool zet via de link zelf een wachtwoord en logt dan in met het groene coach-dashboard.", "The gym sets a password via the link, then logs in to the green coach dashboard.")}</div>
      <div onClick={onBack} style={{ ...btnS(GREEN), width: "fit-content", padding: "11px 20px", marginTop: 4 }}>{t("Klaar", "Done")}</div>
    </div>
  );
  const segTier = (id, lbl) => (<div onClick={() => set("license_tier", id)} style={{ cursor: "pointer", fontSize: 12.5, fontWeight: 800, ...disp, padding: "8px 14px", borderRadius: 8, border: `1px solid ${f.license_tier === id ? GREEN : LINE}`, background: f.license_tier === id ? GREEN : "transparent", color: f.license_tier === id ? "#fff" : MUTED }}>{lbl}</div>);
  const active = (f.license_status || "active") !== "stopped";
  // standaard licentie-einddatum = 1 jaar na start
  const setYear = () => { const s = f.license_start ? new Date(f.license_start) : new Date(); const e = new Date(s); e.setFullYear(e.getFullYear() + 1); set("license_start", s.toISOString().slice(0, 10)); set("license_end", e.toISOString().slice(0, 10)); };
  const [confirmDel, setConfirmDel] = useState(false);
  async function doDelete() {
    setBusy(true); setErr("");
    try { await call(token, "admin.deleteGym", { orgId: f.id }); onBack(); }
    catch (e) { setErr(t("Verwijderen mislukt: ", "Delete failed: ") + String(e.message || e)); setBusy(false); setConfirmDel(false); }
  }
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
      <div style={{ display: "flex", gap: 10 }}>
        <div style={{ flex: 1 }}><div style={lblS}>E-mail {f._new && <span style={{ color: EMBER }}>*</span>}</div><input value={f.contact_email || ""} onChange={(e) => set("contact_email", e.target.value)} placeholder={f._new ? t("coach-login", "coach login") : ""} style={fieldS} /></div>
        <div style={{ flex: 1 }}>{F(t("Telefoon", "Phone"), "contact_phone")}</div>
      </div>
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
      {!f._new && (
        <div style={{ marginTop: 18, borderTop: `1px solid ${LINE}`, paddingTop: 14 }}>
          <div onClick={() => setConfirmDel(true)} style={{ ...btnS(EMBER), width: "fit-content" }}>{t("Sportschool verwijderen", "Delete gym")}</div>
          <div style={{ fontSize: 11, color: MUTED, marginTop: 6 }}>{t("Gaat naar de prullenbak — je kunt het daar herstellen.", "Moves to trash — you can restore it there.")}</div>
        </div>
      )}
      <ConfirmModal open={confirmDel} busy={busy} accent={accent}
        title={t("Sportschool verwijderen?", "Delete gym?")}
        message={t("'" + (f.name || "") + "' gaat naar de prullenbak en de coach-login wordt geblokkeerd. Je kunt het binnen de prullenbak weer herstellen.", "'" + (f.name || "") + "' moves to trash and the coach login is blocked. You can restore it from the trash.")}
        confirmLabel={t("Verwijderen", "Delete")} cancelLabel={t("Annuleren", "Cancel")}
        onConfirm={doDelete} onCancel={() => setConfirmDel(false)} />
    </div>
  );
}

// ===== Member / account bewerken =====
function MemberEditor({ token, lang, acc, accent, onBack }) {
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
  const [confirmDel, setConfirmDel] = useState(false);
  async function doDelMember() {
    setBusy(true); setErr("");
    try { await call(token, "admin.deleteMember", { targetUserId: acc.id }); onBack(); }
    catch (e) { setErr(t("Verwijderen mislukt: ", "Delete failed: ") + String(e.message || e)); setBusy(false); setConfirmDel(false); }
  }
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
      <div style={{ marginTop: 18, borderTop: `1px solid ${LINE}`, paddingTop: 14 }}>
        <div onClick={() => setConfirmDel(true)} style={{ ...btnS(EMBER), width: "fit-content" }}>{t("Member verwijderen", "Delete member")}</div>
        <div style={{ fontSize: 11, color: MUTED, marginTop: 6 }}>{t("Gaat naar de prullenbak — je kunt het daar herstellen.", "Moves to trash — you can restore it there.")}</div>
      </div>
      <ConfirmModal open={confirmDel} busy={busy} accent={accent}
        title={t("Member verwijderen?", "Delete member?")}
        message={t("'" + (acc.email || "") + "' gaat naar de prullenbak (login geblokkeerd, data blijft bewaard). Je kunt het weer herstellen.", "'" + (acc.email || "") + "' moves to trash (login blocked, data kept). You can restore it.")}
        confirmLabel={t("Verwijderen", "Delete")} cancelLabel={t("Annuleren", "Cancel")}
        onConfirm={doDelMember} onCancel={() => setConfirmDel(false)} />
    </div>
  );
}
