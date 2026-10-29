import React, { useState, useEffect } from "react";
import { INK, INK2, PAPER, MUTED, LINE, SAGE, EMBER_SOFT, disp, sectionTitle, applyOrgTheme, THEME_TEMPLATES } from "../shared.js";
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

  // Huisstijl (self-serve white-label)
  const [tpl, setTpl] = useState((org && org.theme && org.theme.template) || "dark");
  const [accent, setAccent] = useState((org && org.theme && org.theme.accent) || (org && org.brand_color) || "#E11D48");
  const [logoData, setLogoData] = useState((org && org.logo_url) || null);
  const [brandBusy, setBrandBusy] = useState(false);
  const [brandMsg, setBrandMsg] = useState("");

  // PT-agenda
  const [sessions, setSessions] = useState(null);
  const [sTitle, setSTitle] = useState("");
  const [sWho, setSWho] = useState("");        // "" = hele groep, anders auth_user_id van een lid
  const [sDate, setSDate] = useState("");
  const [sTime, setSTime] = useState("");
  const [sBusy, setSBusy] = useState(false);
  const [sErr, setSErr] = useState("");

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
  async function loadSessions() {
    if (!supabase) return;
    try {
      const { data } = await supabase.from("org_sessions").select("id,member_id,title,starts_at,note").gte("starts_at", new Date(Date.now() - 36e5).toISOString()).order("starts_at", { ascending: true });
      setSessions(data || []);
    } catch (e) { setSessions([]); }
  }
  useEffect(() => { load(); loadSessions(); }, []);

  async function addSession() {
    const title = sTitle.trim();
    if (!title || !sDate || !sTime || sBusy) { if (!sDate || !sTime) setSErr(t("Kies datum en tijd.", "Pick a date and time.")); return; }
    setSBusy(true); setSErr("");
    try {
      const starts = new Date(sDate + "T" + sTime);
      if (isNaN(starts.getTime())) { setSErr(t("Ongeldige datum/tijd.", "Invalid date/time.")); setSBusy(false); return; }
      const row = { org_id: org && org.id, member_id: sWho || null, title, starts_at: starts.toISOString(), created_by: session && session.user && session.user.id };
      const { error } = await supabase.from("org_sessions").insert(row);
      if (error) { setSErr(t("Opslaan mislukt. Staat de agenda-tabel al aan?", "Save failed. Is the agenda table enabled yet?")); setSBusy(false); return; }
      setSTitle(""); setSWho(""); setSDate(""); setSTime(""); setSBusy(false); loadSessions();
    } catch (e) { setSErr(t("Opslaan mislukt.", "Save failed.")); setSBusy(false); }
  }

  async function delSession(id) {
    if (!supabase) return;
    try { await supabase.from("org_sessions").delete().eq("id", id); loadSessions(); } catch (e) {}
  }

  const memberName = (uid) => { const m = (members || []).find((x) => x.auth_user_id === uid); return m ? (m.display_name || t("Lid", "Member")) : t("Lid", "Member"); };
  const fmtWhen = (s) => { try { return new Date(s).toLocaleString(lang === "nl" ? "nl-NL" : "en-GB", { weekday: "short", day: "numeric", month: "short", hour: "2-digit", minute: "2-digit" }); } catch (e) { return s; } };

  // Live-preview van de huisstijl terwijl de coach schuift.
  useEffect(() => { applyOrgTheme({ template: tpl, accent }); }, [tpl, accent]);

  // Logo kiezen → verkleinen naar max 320px breed → als data-URL bewaren (geen aparte opslag nodig).
  function onLogoFile(e) {
    const f = e.target.files && e.target.files[0];
    if (!f) return;
    if (f.size > 4 * 1024 * 1024) { setBrandMsg(t("Logo te groot (max 4MB).", "Logo too large (max 4MB).")); return; }
    const rd = new FileReader();
    rd.onload = () => {
      const img = new Image();
      img.onload = () => {
        try {
          const max = 320; let w = img.width, h = img.height;
          if (w > max) { h = Math.round(h * max / w); w = max; }
          const c = document.createElement("canvas"); c.width = w; c.height = h;
          c.getContext("2d").drawImage(img, 0, 0, w, h);
          setLogoData(c.toDataURL("image/png"));
        } catch (err) { setLogoData(rd.result); }
      };
      img.onerror = () => setLogoData(rd.result); // bv. SVG zonder afmetingen
      img.src = rd.result;
    };
    rd.readAsDataURL(f);
  }

  async function saveBrand() {
    if (!supabase || !org || !org.id || brandBusy) return;
    setBrandBusy(true); setBrandMsg("");
    try {
      const theme = { template: tpl, accent };
      const { error } = await supabase.from("org_config").update({ brand_color: accent, logo_url: logoData || null, theme }).eq("org_id", org.id);
      if (error) { setBrandMsg(t("Opslaan mislukt.", "Save failed.")); setBrandBusy(false); return; }
      applyOrgTheme(theme);
      setBrandMsg(t("Opgeslagen. Leden zien het na verversen van de app.", "Saved. Members see it after refreshing the app.")); setBrandBusy(false);
    } catch (e) { setBrandMsg(t("Opslaan mislukt.", "Save failed.")); setBrandBusy(false); }
  }

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

        {/* PT-agenda */}
        <div style={card}>
          <div style={{ ...sectionTitle, color, marginBottom: 10 }}>{t("PT-agenda", "PT schedule")}</div>
          <div style={{ display: "grid", gap: 8 }}>
            <input style={input} value={sTitle} onChange={(e) => setSTitle(e.target.value)} placeholder={t("Titel (bv. Personal training)", "Title (e.g. Personal training)")} />
            <select style={{ ...input, appearance: "auto" }} value={sWho} onChange={(e) => setSWho(e.target.value)}>
              <option value="">{t("Hele groep", "Whole group")}</option>
              {(members || []).map((m) => <option key={m.id} value={m.auth_user_id}>{m.display_name || t("Naamloos", "Unnamed")}</option>)}
            </select>
            <div style={{ display: "flex", gap: 8 }}>
              <input style={{ ...input, flex: 1 }} type="date" value={sDate} onChange={(e) => setSDate(e.target.value)} />
              <input style={{ ...input, flex: 1 }} type="time" value={sTime} onChange={(e) => setSTime(e.target.value)} />
            </div>
            <div onClick={addSession} style={{ cursor: sBusy ? "default" : "pointer", opacity: sBusy ? 0.7 : 1, background: color, color: "#fff", padding: "11px 0", borderRadius: 8, textAlign: "center", ...disp, fontWeight: 700, fontSize: 13.5, letterSpacing: 0.3 }}>{t("Sessie plannen", "Schedule session")}</div>
          </div>
          {sErr && <div style={{ fontSize: 12, color: EMBER_SOFT, marginTop: 8 }}>{sErr}</div>}

          <div style={{ marginTop: 14, display: "grid", gap: 8 }}>
            {!sessions ? <div style={{ fontSize: 13, color: MUTED }}>{t("Laden…", "Loading…")}</div>
              : sessions.length === 0 ? <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.5 }}>{t("Nog geen geplande sessies.", "No sessions scheduled yet.")}</div>
              : sessions.map((s) => (
                <div key={s.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "10px 12px", background: INK, border: `1px solid ${LINE}`, borderRadius: 10 }}>
                  <div style={{ flex: 1, minWidth: 0 }}>
                    <div style={{ ...disp, fontWeight: 700, fontSize: 14 }}>{s.title}</div>
                    <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{fmtWhen(s.starts_at)} · {s.member_id ? memberName(s.member_id) : t("Hele groep", "Whole group")}</div>
                  </div>
                  <div onClick={() => delSession(s.id)} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "6px 9px", whiteSpace: "nowrap" }}>{t("Verwijderen", "Delete")}</div>
                </div>
              ))}
          </div>
        </div>

        {/* Huisstijl (self-serve white-label) */}
        <div style={card}>
          <div style={{ ...sectionTitle, color: accent, marginBottom: 12 }}>{t("Huisstijl", "Branding")}</div>

          <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 6 }}>{t("Logo", "Logo")}</div>
          <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: 16, flexWrap: "wrap" }}>
            <div style={{ height: 46, minWidth: 90, maxWidth: 190, background: INK, border: `1px solid ${LINE}`, borderRadius: 8, display: "flex", alignItems: "center", justifyContent: "center", padding: "4px 10px" }}>
              {logoData ? <img src={logoData} alt="logo" style={{ maxHeight: 36, maxWidth: 170, objectFit: "contain" }} /> : <span style={{ fontSize: 11, color: MUTED }}>{t("Geen logo", "No logo")}</span>}
            </div>
            <label style={{ cursor: "pointer", fontSize: 12.5, color: PAPER, border: `1px solid ${LINE}`, borderRadius: 8, padding: "9px 13px", ...disp, fontWeight: 600 }}>
              {t("Logo kiezen", "Choose logo")}
              <input type="file" accept="image/*" onChange={onLogoFile} style={{ display: "none" }} />
            </label>
            {logoData && <div onClick={() => setLogoData(null)} style={{ cursor: "pointer", fontSize: 12, color: MUTED }}>{t("Verwijderen", "Remove")}</div>}
          </div>

          <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 6 }}>{t("Basis-template", "Base template")}</div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap", marginBottom: 16 }}>
            {Object.keys(THEME_TEMPLATES).map((k) => {
              const on = tpl === k; const base = THEME_TEMPLATES[k];
              return (
                <div key={k} onClick={() => setTpl(k)} style={{ cursor: "pointer", border: `2px solid ${on ? accent : LINE}`, borderRadius: 10, padding: 8, display: "flex", alignItems: "center", gap: 8, background: INK }}>
                  <div style={{ width: 24, height: 24, borderRadius: 6, background: base.ink, border: `1px solid ${base.line}`, position: "relative" }}>
                    <div style={{ position: "absolute", right: 3, bottom: 3, width: 8, height: 8, borderRadius: "50%", background: accent }} />
                  </div>
                  <span style={{ fontSize: 12.5, color: PAPER, textTransform: "capitalize", ...disp, fontWeight: 600 }}>{k}</span>
                </div>
              );
            })}
          </div>

          <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 6 }}>{t("Accentkleur (knoppen & accenten)", "Accent color (buttons & accents)")}</div>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 16 }}>
            <input type="color" value={accent} onChange={(e) => setAccent(e.target.value)} style={{ width: 46, height: 38, border: `1px solid ${LINE}`, borderRadius: 8, background: INK, cursor: "pointer", padding: 2 }} />
            <input value={accent} onChange={(e) => setAccent(e.target.value)} style={{ ...input, width: 130 }} />
          </div>

          <div onClick={saveBrand} style={{ cursor: brandBusy ? "default" : "pointer", opacity: brandBusy ? 0.7 : 1, background: accent, color: "#fff", padding: "11px 0", borderRadius: 8, textAlign: "center", ...disp, fontWeight: 700, fontSize: 13.5, letterSpacing: 0.3 }}>{brandBusy ? t("Opslaan…", "Saving…") : t("Huisstijl opslaan", "Save branding")}</div>
          {brandMsg && <div style={{ fontSize: 12, color: SAGE, marginTop: 8 }}>{brandMsg}</div>}
        </div>
      </div>
    </div>
  );
}
