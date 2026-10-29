import React, { useState, useEffect } from "react";
import { INK, INK2, PAPER, MUTED, LINE, SAGE, EMBER_SOFT, disp, sectionTitle } from "../shared.js";
import { supabase } from "../supabaseClient.js";

// Coach-dashboard: verschijnt als een ingelogde gebruiker de rol 'coach' heeft.
// Toont de leden + voortgang, en laat de coach leden aanmaken (met code) + code resetten.
export default function CoachDash({ session, org, lang, onLogout }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const color = (org && org.brand_color) || "#E11D48";
  const token = session && session.access_token;

  const [members, setMembers] = useState(null);
  const [newName, setNewName] = useState("");
  const [busy, setBusy] = useState(false);
  const [codeShown, setCodeShown] = useState(null);  // {name, code}
  const [err, setErr] = useState("");

  const joinUrl = (typeof window !== "undefined" ? window.location.origin : "") + "/join/" + (org && org.slug);

  async function load() {
    if (!supabase) return;
    try {
      const { data: mem } = await supabase.from("org_members").select("id,auth_user_id,display_name,active,created_at").eq("role", "member").order("created_at", { ascending: true });
      const { data: prog } = await supabase.from("member_progress").select("user_id,adherence,last_active");
      const pmap = {}; (prog || []).forEach((p) => { pmap[p.user_id] = p; });
      setMembers((mem || []).map((m) => ({ ...m, progress: pmap[m.auth_user_id] || null })));
    } catch (e) { setMembers([]); }
  }
  useEffect(() => { load(); }, []);

  async function addMember() {
    const name = newName.trim();
    if (!name || busy) return;
    setBusy(true); setErr("");
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "create", authToken: token, display_name: name }) });
      const d = await r.json().catch(() => ({}));
      if (!r.ok || !d.code) { setErr(t("Aanmaken mislukt.", "Create failed.")); setBusy(false); return; }
      setCodeShown({ name, code: d.code }); setNewName(""); setBusy(false); load();
    } catch (e) { setErr(t("Aanmaken mislukt.", "Create failed.")); setBusy(false); }
  }

  async function resetCode(m) {
    if (busy) return; setBusy(true); setErr("");
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "reset", authToken: token, member_id: m.id }) });
      const d = await r.json().catch(() => ({}));
      if (!r.ok || !d.code) { setErr(t("Reset mislukt.", "Reset failed.")); setBusy(false); return; }
      setCodeShown({ name: m.display_name, code: d.code }); setBusy(false);
    } catch (e) { setErr(t("Reset mislukt.", "Reset failed.")); setBusy(false); }
  }

  const fmtDate = (s) => { try { return s ? new Date(s).toLocaleDateString(lang === "nl" ? "nl-NL" : "en-GB", { day: "numeric", month: "short" }) : "—"; } catch (e) { return "—"; } };
  const card = { background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16 };
  const input = { width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "11px 12px", fontSize: 14, borderRadius: 8, outline: "none", boxSizing: "border-box", fontFamily: "Inter, sans-serif" };

  return (
    <div style={{ minHeight: "100vh", background: INK, color: PAPER, fontFamily: "Inter, sans-serif", paddingBottom: 40 }}>
      {/* header white-label */}
      <div style={{ borderBottom: `1px solid ${LINE}`, padding: "14px 16px", display: "flex", alignItems: "center", gap: 10, position: "sticky", top: 0, background: INK, zIndex: 10 }}>
        {org && org.logo_url
          ? <img src={org.logo_url} alt={org.name} style={{ maxHeight: 30, maxWidth: 150, objectFit: "contain" }} />
          : <div style={{ ...disp, fontWeight: 800, fontSize: 17, color }}>{(org && org.name) || "Coach"}</div>}
        <div style={{ flex: 1 }} />
        <div style={{ fontSize: 11, color: MUTED, letterSpacing: 1, textTransform: "uppercase", ...disp, fontWeight: 700 }}>Coach</div>
        <div onClick={onLogout} style={{ cursor: "pointer", fontSize: 12.5, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 8, padding: "6px 11px" }}>{t("Uitloggen", "Log out")}</div>
      </div>

      <div style={{ maxWidth: 680, margin: "0 auto", padding: "20px 16px", display: "grid", gap: 16 }}>
        {/* nieuwe code tonen */}
        {codeShown && (
          <div style={{ ...card, border: `1px solid ${color}`, background: "linear-gradient(180deg, rgba(255,255,255,0.04), transparent 70%)" }}>
            <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 6 }}>{t("Code voor", "Code for")} <strong style={{ color: PAPER }}>{codeShown.name}</strong> {t("(geef 'm door, hij is nu niet meer te zien)", "(share it now, it won't show again)")}</div>
            <div style={{ ...disp, fontSize: 30, fontWeight: 800, letterSpacing: 6, color }}>{codeShown.code}</div>
            <div onClick={() => setCodeShown(null)} style={{ cursor: "pointer", marginTop: 10, fontSize: 12.5, color: MUTED, textAlign: "right" }}>{t("Sluiten", "Close")}</div>
          </div>
        )}

        {/* lid toevoegen */}
        <div style={card}>
          <div style={{ ...sectionTitle, color, marginBottom: 10 }}>{t("Lid toevoegen", "Add member")}</div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
            <input style={{ ...input, flex: 1, minWidth: 180 }} value={newName} onChange={(e) => setNewName(e.target.value)} onKeyDown={(e) => { if (e.key === "Enter") addMember(); }} placeholder={t("Naam van het lid", "Member name")} />
            <div onClick={addMember} style={{ cursor: busy ? "default" : "pointer", opacity: busy ? 0.7 : 1, background: color, color: "#fff", padding: "11px 18px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13.5, letterSpacing: 0.3, whiteSpace: "nowrap" }}>{t("Aanmaken", "Create")}</div>
          </div>
          <div style={{ fontSize: 11.5, color: MUTED, marginTop: 10, lineHeight: 1.5 }}>{t("Deel de join-link + code met je lid:", "Share the join link + code with your member:")} <span style={{ color: PAPER }}>{joinUrl}</span></div>
          {err && <div style={{ fontSize: 12, color: EMBER_SOFT, marginTop: 8 }}>{err}</div>}
        </div>

        {/* leden-lijst */}
        <div style={card}>
          <div style={{ ...sectionTitle, color, marginBottom: 12 }}>{t("Leden", "Members")} {members ? "(" + members.length + ")" : ""}</div>
          {!members ? <div style={{ fontSize: 13, color: MUTED }}>{t("Laden…", "Loading…")}</div>
            : members.length === 0 ? <div style={{ fontSize: 13, color: MUTED, lineHeight: 1.5 }}>{t("Nog geen leden. Voeg je eerste lid toe.", "No members yet. Add your first one.")}</div>
            : (
            <div style={{ display: "grid", gap: 8 }}>
              {members.map((m) => {
                const adh = m.progress && m.progress.adherence != null ? Math.round(m.progress.adherence) : null;
                const attention = adh != null && adh < 50;
                return (
                  <div key={m.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "11px 12px", background: INK, border: `1px solid ${LINE}`, borderRadius: 10 }}>
                    <div style={{ flex: 1, minWidth: 0 }}>
                      <div style={{ ...disp, fontWeight: 700, fontSize: 14.5 }}>{m.display_name || t("Naamloos", "Unnamed")}</div>
                      <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{t("Laatst actief", "Last active")}: {fmtDate(m.progress && m.progress.last_active)}</div>
                    </div>
                    <div style={{ textAlign: "right" }}>
                      <div style={{ ...disp, fontWeight: 700, fontSize: 14, color: adh == null ? MUTED : attention ? EMBER_SOFT : SAGE }}>{adh == null ? "—" : adh + "%"}</div>
                      <div style={{ fontSize: 10, color: MUTED }}>{t("adherentie", "adherence")}</div>
                    </div>
                    <div onClick={() => resetCode(m)} title={t("Nieuwe code", "New code")} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "6px 9px", whiteSpace: "nowrap" }}>{t("Reset code", "Reset code")}</div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
