import React, { useState, useEffect } from "react";
import { INK, INK2, PAPER, MUTED, LINE, EMBER, EMBER_SOFT, disp } from "../shared.js";
import { apiUrl } from "../apiBase";

const GREEN = "#58C27D";

// Platform-admin (alleen zichtbaar voor ADMIN_EMAIL): alle accounts, abonnementen,
// sportscholen + ingrijpen (tier geven/intrekken, Stripe openen).
export default function AdminDash({ session, lang, onClose }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const token = (session && session.access_token) || "";
  const [accounts, setAccounts] = useState(null);
  const [counts, setCounts] = useState(null);
  const [err, setErr] = useState("");
  const [busy, setBusy] = useState(false);
  const [q, setQ] = useState("");
  const [filter, setFilter] = useState("all");
  const [rowBusy, setRowBusy] = useState("");
  const [demoBusy, setDemoBusy] = useState(false);
  const [demo, setDemo] = useState(null);
  const [reset, setReset] = useState(null);
  const [expBusy, setExpBusy] = useState(false);
  const [sched, setSched] = useState(null);

  function download(obj, fname) {
    const blob = new Blob([JSON.stringify(obj, null, 2)], { type: "application/json" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url; link.download = fname;
    document.body.appendChild(link); link.click(); link.remove();
    setTimeout(() => URL.revokeObjectURL(url), 2000);
  }
  async function backupOne(a) {
    setRowBusy(a.id); setErr("");
    try { const d = await call("admin.export", { targetUserId: a.id }); download(d, "hybridfuel-" + (a.email || a.id).replace(/[^a-z0-9]/gi, "_") + "-" + new Date().toISOString().slice(0, 10) + ".json"); }
    catch (e) { setErr(t("Back-up klant mislukt: ", "Customer backup failed: ") + String(e.message || e)); }
    setRowBusy("");
  }
  async function changeSched(v) {
    setSched(v);
    try { await call("admin.setBackupSchedule", { schedule: v }); }
    catch (e) { setErr(t("Instelling opslaan mislukt (KV niet actief?).", "Saving setting failed (KV off?).")); }
  }

  async function resetPw(a) {
    setRowBusy(a.id); setErr("");
    try { const d = await call("admin.resetPassword", { email: a.email }); setReset({ email: a.email, url: d.url }); }
    catch (e) { setErr(t("Reset-link maken mislukt: ", "Reset link failed: ") + String(e.message || e)); }
    setRowBusy("");
  }
  async function exportData() {
    setExpBusy(true); setErr("");
    try {
      const d = await call("admin.export");
      const blob = new Blob([JSON.stringify(d, null, 2)], { type: "application/json" });
      const url = URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.href = url; link.download = "hybridfuel-backup-" + new Date().toISOString().slice(0, 10) + ".json";
      document.body.appendChild(link); link.click(); link.remove();
      setTimeout(() => URL.revokeObjectURL(url), 2000);
    } catch (e) { setErr(t("Export mislukt: ", "Export failed: ") + String(e.message || e)); }
    setExpBusy(false);
  }

  async function makeDemo() {
    const name = window.prompt(t("Naam van de nieuwe sportschool?", "Name of the new gym?"), "");
    if (!name || !name.trim()) return;
    setDemoBusy(true); setErr("");
    try { const d = await call("admin.createDemoGym", { gymName: name.trim() }); setDemo(d); await load(); }
    catch (e) { setErr(t("Sportschool aanmaken mislukt: ", "Creating gym failed: ") + String(e.message || e)); }
    setDemoBusy(false);
  }

  async function call(op, extra) {
    const r = await fetch(apiUrl("/api/billing-portal"), {
      method: "POST", headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ authToken: token, op, ...(extra || {}) }),
    });
    const d = await r.json().catch(() => ({}));
    if (!r.ok) throw new Error(d && d.error || ("http_" + r.status));
    return d;
  }
  async function load() {
    setErr(""); setBusy(true);
    try { const d = await call("admin.list"); setAccounts(d.accounts || []); setCounts(d.counts || null); }
    catch (e) { setErr(String(e.message || e)); }
    setBusy(false);
  }
  useEffect(() => { load(); call("admin.getBackupSchedule").then((d) => setSched(d && d.schedule || "monthly")).catch(() => setSched("monthly")); /* eslint-disable-next-line */ }, []);

  async function setTier(a, tier) {
    if (a.tier === tier) return;
    setRowBusy(a.id);
    try { await call("admin.setTier", { targetUserId: a.id, tier }); setAccounts((prev) => prev.map((x) => x.id === a.id ? { ...x, tier, status: tier === "free" ? "admin_revoked" : "admin_granted" } : x)); recount(); }
    catch (e) { setErr(String(e.message || e)); }
    setRowBusy("");
  }
  function recount() {
    setAccounts((prev) => { if (prev) { const c = { total: prev.length, paying: prev.filter((a) => a.tier !== "free").length, pro: prev.filter((a) => a.tier === "pro").length, basis: prev.filter((a) => a.tier === "basis").length, gyms: (counts && counts.gyms) || 0 }; setCounts(c); } return prev; });
  }
  async function openStripe(a) {
    setRowBusy(a.id);
    try { const d = await call("admin.stripe", { targetUserId: a.id }); if (d.url) window.open(d.url, "_blank", "noopener"); }
    catch (e) { setErr(t("Geen Stripe-klant voor dit account.", "No Stripe customer for this account.")); }
    setRowBusy("");
  }

  const fmtDate = (s) => { try { return s ? new Date(s).toLocaleDateString(lang === "nl" ? "nl-NL" : "en-US", { day: "numeric", month: "short" }) : "—"; } catch (e) { return "—"; } };
  const ago = (s) => {
    if (!s) return "—";
    const d = Math.floor((Date.now() - new Date(s).getTime()) / 86400000);
    if (isNaN(d)) return "—";
    if (d <= 0) return t("vandaag", "today");
    if (d === 1) return t("gisteren", "yesterday");
    if (d < 30) return d + t(" dgn", "d");
    return fmtDate(s);
  };

  const list = (accounts || []).filter((a) => {
    if (filter === "paying" && a.tier === "free") return false;
    if (filter === "pro" && a.tier !== "pro") return false;
    if (filter === "basis" && a.tier !== "basis") return false;
    if (filter === "free" && a.tier !== "free") return false;
    if (filter === "gym" && !a.gym) return false;
    if (q.trim()) { const s = (a.email + " " + (a.gym || "")).toLowerCase(); if (s.indexOf(q.trim().toLowerCase()) < 0) return false; }
    return true;
  });

  const pill = (tier) => {
    const map = { pro: { bg: "rgba(var(--hf-ember-rgb),0.12)", c: EMBER, l: "PRO" }, basis: { bg: "rgba(75,75,219,0.12)", c: "#6366F1", l: "BASIS" }, free: { bg: "var(--hf-track)", c: MUTED, l: t("GRATIS", "FREE") } };
    const m = map[tier] || map.free;
    return <span style={{ display: "inline-block", fontSize: 10.5, fontWeight: 700, padding: "3px 9px", borderRadius: 6, ...disp, letterSpacing: 0.3, background: m.bg, color: m.c }}>{m.l}</span>;
  };
  const stat = (v, l, red) => (
    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 15, boxShadow: "var(--hf-shadow)" }}>
      <div style={{ ...disp, fontWeight: 700, fontSize: 26, color: red ? EMBER : PAPER, lineHeight: 1 }}>{v}</div>
      <div style={{ fontSize: 10, letterSpacing: 0.6, textTransform: "uppercase", color: MUTED, marginTop: 7, fontWeight: 600 }}>{l}</div>
    </div>
  );
  const chip = (id, label) => (
    <div onClick={() => setFilter(id)} style={{ cursor: "pointer", fontSize: 12, fontWeight: 700, ...disp, padding: "7px 12px", borderRadius: 8, border: `1px solid ${filter === id ? EMBER : LINE}`, background: filter === id ? EMBER : "transparent", color: filter === id ? "#fff" : MUTED }}>{label}</div>
  );

  return (
    <div style={{ position: "fixed", inset: 0, background: "var(--hf-bg)", zIndex: 999, overflowY: "auto" }}>
      <div style={{ maxWidth: 1040, margin: "0 auto", padding: "calc(18px + env(safe-area-inset-top)) 18px calc(28px + env(safe-area-inset-bottom))" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: 18 }}>
          <div>
            <div style={{ ...disp, fontWeight: 700, fontSize: 24, color: PAPER }}>Admin · HybridFuelCo</div>
            <div style={{ fontSize: 12.5, color: MUTED, marginTop: 3 }}>{t("Alle accounts, abonnementen en sportscholen", "All accounts, subscriptions and gyms")}</div>
          </div>
          <div style={{ display: "flex", gap: 8 }}>
            <div onClick={demoBusy ? null : makeDemo} className="hf-tap" style={{ cursor: demoBusy ? "default" : "pointer", fontSize: 12.5, fontWeight: 700, ...disp, color: "#fff", background: EMBER, borderRadius: 9, padding: "9px 13px", opacity: demoBusy ? 0.6 : 1 }}>{demoBusy ? "…" : t("+ Nieuwe sportschool", "+ New gym")}</div>
            <div onClick={expBusy ? null : exportData} className="hf-tap" style={{ cursor: expBusy ? "default" : "pointer", fontSize: 12.5, fontWeight: 700, ...disp, color: EMBER, border: `1px solid ${LINE}`, borderRadius: 9, padding: "9px 13px", opacity: expBusy ? 0.6 : 1 }}>{expBusy ? "…" : t("↓ Back-up", "↓ Backup")}</div>
            <div onClick={load} className="hf-tap" style={{ cursor: "pointer", fontSize: 12.5, fontWeight: 700, ...disp, color: EMBER, border: `1px solid ${LINE}`, borderRadius: 9, padding: "9px 13px" }}>{busy ? "…" : t("Vernieuwen", "Refresh")}</div>
            <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 18, width: 38, height: 38, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
          </div>
        </div>

        {counts && (
          <div style={{ display: "grid", gridTemplateColumns: "repeat(5, 1fr)", gap: 12, marginBottom: 18 }}>
            {stat(counts.total, t("Accounts", "Accounts"))}
            {stat(counts.paying, t("Betalend", "Paying"), true)}
            {stat(counts.pro, "Pro")}
            {stat(counts.basis, "Basis")}
            {stat(counts.gyms, t("Sportscholen", "Gyms"))}
          </div>
        )}

        {counts && counts.total > 0 && (() => {
          const free = Math.max(0, counts.total - counts.paying);
          const segs = [
            { k: "Pro", n: counts.pro, c: EMBER },
            { k: "Basis", n: counts.basis, c: "#6366F1" },
            { k: t("Gratis", "Free"), n: free, c: MUTED },
          ];
          const tot = counts.total || 1;
          return (
            <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: "14px 16px", marginBottom: 18, boxShadow: "var(--hf-shadow)" }}>
              <div style={{ fontSize: 10, letterSpacing: 0.8, textTransform: "uppercase", color: MUTED, fontWeight: 700, marginBottom: 10 }}>{t("Verdeling betaald / gratis", "Paid / free breakdown")}</div>
              <div style={{ display: "flex", height: 22, borderRadius: 7, overflow: "hidden", background: "var(--hf-track)" }}>
                {segs.map((s, i) => s.n > 0 ? <div key={i} style={{ width: (s.n / tot * 100) + "%", background: s.c }} title={s.k + ": " + s.n} /> : null)}
              </div>
              <div style={{ display: "flex", gap: 18, marginTop: 11, flexWrap: "wrap" }}>
                {segs.map((s, i) => (
                  <div key={i} style={{ display: "flex", alignItems: "center", gap: 7, fontSize: 12 }}>
                    <span style={{ width: 11, height: 11, borderRadius: 3, background: s.c, flexShrink: 0 }} />
                    <span style={{ color: PAPER, fontWeight: 600 }}>{s.k}</span>
                    <span style={{ color: MUTED }}>{s.n} · {Math.round(s.n / tot * 100)}%</span>
                  </div>
                ))}
              </div>
            </div>
          );
        })()}

        <div style={{ display: "flex", alignItems: "center", gap: 12, flexWrap: "wrap", background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, padding: "11px 14px", marginBottom: 16 }}>
          <div style={{ flex: 1, minWidth: 180 }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 13, color: PAPER }}>{t("Automatische back-up", "Automatic backup")}</div>
            <div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{t("Volledige back-up gemaild naar jou (bijlage).", "Full backup emailed to you (attachment).")}</div>
          </div>
          <div style={{ display: "flex", gap: 6 }}>
            {[["off", t("Uit", "Off")], ["weekly", t("Wekelijks", "Weekly")], ["monthly", t("Maandelijks", "Monthly")]].map(([id, lbl]) => (
              <div key={id} onClick={() => changeSched(id)} style={{ cursor: "pointer", fontSize: 12, fontWeight: 700, ...disp, padding: "7px 12px", borderRadius: 8, border: `1px solid ${sched === id ? EMBER : LINE}`, background: sched === id ? EMBER : "transparent", color: sched === id ? "#fff" : MUTED }}>{lbl}</div>
            ))}
          </div>
        </div>

        {demo && (
          <div style={{ background: "rgba(88,194,125,0.10)", border: `1px solid ${GREEN}`, borderRadius: 12, padding: "14px 16px", marginBottom: 16 }}>
            <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 8 }}>
              <div style={{ ...disp, fontWeight: 700, fontSize: 15, color: PAPER }}>{t("Sportschool aangemaakt", "Gym created")} · {demo.name}</div>
              <div onClick={() => setDemo(null)} style={{ cursor: "pointer", color: MUTED, fontSize: 16 }}>×</div>
            </div>
            <div style={{ fontSize: 12.5, color: PAPER, lineHeight: 1.7 }}>
              {t("Log hiermee in om het groene gym-dashboard te zien:", "Log in with this to see the green gym dashboard:")}<br />
              <b>{t("Coach e-mail", "Coach email")}:</b> <span style={{ color: GREEN }}>{demo.coachEmail}</span><br />
              <b>{t("Wachtwoord", "Password")}:</b> <span style={{ color: GREEN }}>{demo.coachPass}</span><br />
              <b>{t("Leden-link (codes)", "Member link (codes)")}:</b> <span style={{ color: GREEN, wordBreak: "break-all" }}>{demo.joinUrl}</span>
            </div>
            <div style={{ fontSize: 11, color: MUTED, marginTop: 8 }}>{t("Noteer dit — het wachtwoord zie je maar één keer. Log eerst uit, dan in als deze coach.", "Note this down — the password is shown once. Log out first, then in as this coach.")}</div>
          </div>
        )}

        <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 14, flexWrap: "wrap" }}>
          <input value={q} onChange={(e) => setQ(e.target.value)} placeholder={t("Zoek op e-mail of sportschool…", "Search email or gym…")} style={{ flex: 1, minWidth: 200, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: "10px 13px", fontSize: 13, color: PAPER, outline: "none", fontFamily: "Inter, sans-serif" }} />
          <div style={{ display: "flex", gap: 6, flexWrap: "wrap" }}>
            {chip("all", t("Alle", "All"))}{chip("paying", t("Betalend", "Paying"))}{chip("pro", "Pro")}{chip("basis", "Basis")}{chip("free", t("Gratis", "Free"))}{chip("gym", t("Sportschool", "Gym"))}
          </div>
        </div>

        {reset && (
          <div style={{ background: "rgba(var(--hf-ember-rgb),0.08)", border: `1px solid ${EMBER}`, borderRadius: 12, padding: "14px 16px", marginBottom: 16 }}>
            <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 8 }}>
              <div style={{ ...disp, fontWeight: 700, fontSize: 15, color: PAPER }}>{t("Wachtwoord-herstellink", "Password reset link")} · {reset.email}</div>
              <div onClick={() => setReset(null)} style={{ cursor: "pointer", color: MUTED, fontSize: 16 }}>×</div>
            </div>
            <div style={{ fontSize: 12.5, color: PAPER, wordBreak: "break-all", lineHeight: 1.5 }}>{t("Geef deze link aan de klant om een nieuw wachtwoord te zetten:", "Give this link to the customer to set a new password:")}<br /><span style={{ color: EMBER_SOFT }}>{reset.url}</span></div>
            <div onClick={() => { try { navigator.clipboard.writeText(reset.url); } catch (e) {} }} className="hf-tap" style={{ cursor: "pointer", display: "inline-block", marginTop: 9, fontSize: 12, fontWeight: 700, ...disp, color: "#fff", background: EMBER, borderRadius: 8, padding: "7px 12px" }}>{t("Kopieer link", "Copy link")}</div>
          </div>
        )}

        {err && <div style={{ background: "rgba(var(--hf-ember-rgb),0.12)", border: `1px solid ${EMBER}`, borderRadius: 10, padding: "10px 13px", fontSize: 12.5, color: EMBER_SOFT, marginBottom: 14 }}>{err}</div>}

        <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, overflow: "hidden", boxShadow: "var(--hf-shadow)" }}>
          <div style={{ display: "grid", gridTemplateColumns: "2.3fr 2fr 1.4fr 1fr 1fr", gap: 10, padding: "11px 16px", fontSize: 10, letterSpacing: 0.8, textTransform: "uppercase", color: MUTED, fontWeight: 700, borderBottom: `1px solid ${LINE}` }}>
            <div>{t("E-mail", "Email")}</div><div>{t("Pakket · ingrijpen", "Plan · act")}</div><div>{t("Sportschool", "Gym")}</div><div>{t("Sinds", "Since")}</div><div>{t("Laatst", "Last")}</div>
          </div>
          {!accounts && !err && <div style={{ padding: 24, textAlign: "center", color: MUTED, fontSize: 13 }}>{t("Laden…", "Loading…")}</div>}
          {accounts && list.length === 0 && <div style={{ padding: 24, textAlign: "center", color: MUTED, fontSize: 13 }}>{t("Geen accounts gevonden.", "No accounts found.")}</div>}
          {list.map((a, i) => (
            <div key={a.id} style={{ display: "grid", gridTemplateColumns: "2.3fr 2fr 1.4fr 1fr 1fr", gap: 10, alignItems: "center", padding: "11px 16px", borderTop: i > 0 ? `1px solid ${LINE}` : "none", opacity: rowBusy === a.id ? 0.5 : 1 }}>
              <div style={{ minWidth: 0 }}>
                <div style={{ fontSize: 13, fontWeight: 600, color: PAPER, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{a.email}</div>
                {a.status && <div style={{ fontSize: 10.5, color: a.tier === "free" ? MUTED : GREEN, marginTop: 2 }}>{a.tier === "free" ? t("geen toegang", "no access") : t("toegang actief", "access active")}</div>}
              </div>
              <div style={{ display: "flex", alignItems: "center", gap: 6, flexWrap: "wrap" }}>
                {["free", "basis", "pro"].map((tr) => (
                  <div key={tr} onClick={() => setTier(a, tr)} style={{ cursor: "pointer", fontSize: 10, fontWeight: 700, ...disp, padding: "4px 7px", borderRadius: 6, border: `1px solid ${a.tier === tr ? EMBER : LINE}`, background: a.tier === tr ? "rgba(var(--hf-ember-rgb),0.14)" : "transparent", color: a.tier === tr ? EMBER : MUTED }}>{tr === "free" ? t("gratis", "free") : tr}</div>
                ))}
                {a.has_customer && <div onClick={() => openStripe(a)} title="Stripe" style={{ cursor: "pointer", fontSize: 10, fontWeight: 700, ...disp, padding: "4px 7px", borderRadius: 6, border: `1px solid ${LINE}`, color: MUTED }}>Stripe ↗</div>}
                <div onClick={() => resetPw(a)} title={t("Wachtwoord resetten", "Reset password")} style={{ cursor: "pointer", fontSize: 10, fontWeight: 700, ...disp, padding: "4px 7px", borderRadius: 6, border: `1px solid ${LINE}`, color: MUTED }}>{t("Reset ww", "Reset pw")}</div>
                <div onClick={() => backupOne(a)} title={t("Back-up van deze klant", "Back up this customer")} style={{ cursor: "pointer", fontSize: 10, fontWeight: 700, ...disp, padding: "4px 7px", borderRadius: 6, border: `1px solid ${LINE}`, color: GREEN }}>↓ {t("back-up", "backup")}</div>
              </div>
              <div style={{ fontSize: 12, color: a.gym ? PAPER : MUTED, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{a.gym || "—"}</div>
              <div style={{ fontSize: 12, color: MUTED }}>{fmtDate(a.created_at)}</div>
              <div style={{ fontSize: 12, color: MUTED }}>{ago(a.last_sign_in_at)}</div>
            </div>
          ))}
        </div>
        <div style={{ fontSize: 11, color: MUTED, marginTop: 12, textAlign: "center", lineHeight: 1.5 }}>
          {t("Tik een pakket om toegang te geven of in te trekken. Wijzigingen gaan direct in.", "Tap a plan to grant or revoke access. Changes apply immediately.")}
        </div>
      </div>
    </div>
  );
}
