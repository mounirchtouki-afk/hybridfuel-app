import React, { useState, useEffect } from "react";
import { INK, INK2, PAPER, MUTED, LINE, SAGE, EMBER_SOFT, disp, sectionTitle, applyOrgTheme, THEME_TEMPLATES } from "../shared.js";
import { supabase } from "../supabaseClient.js";

// Herbruikbaar uitklap-menu met aanvinkvakjes (meervoudige keuze, i.p.v. losse knoppen).
function MultiPick({ options, selected, onToggle, placeholder, color }) {
  const [open, setOpen] = useState(false);
  const sel = Array.isArray(selected) ? selected : [];
  const labelFor = (id) => { const o = options.find((x) => x.id === id); return o ? o.label : id; };
  const summary = sel.length === 0 ? placeholder : (sel.length <= 2 ? sel.map(labelFor).join(", ") : sel.length + " gekozen");
  return (
    <div style={{ position: "relative" }}>
      <div onClick={() => setOpen((v) => !v)} style={{ cursor: "pointer", width: "100%", background: INK, border: `1px solid ${open ? color : LINE}`, color: sel.length ? PAPER : MUTED, padding: "11px 12px", fontSize: 13.5, borderRadius: 8, boxSizing: "border-box", display: "flex", alignItems: "center", gap: 8 }}>
        <span style={{ flex: 1, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{summary}</span>
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke={MUTED} strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round" style={{ transform: open ? "rotate(180deg)" : "none", flexShrink: 0 }}><path d="M6 9l6 6 6-6" /></svg>
      </div>
      {open && (
        <>
          <div onClick={() => setOpen(false)} style={{ position: "fixed", inset: 0, zIndex: 48 }} />
          <div style={{ position: "absolute", left: 0, right: 0, top: "calc(100% + 4px)", background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, overflow: "hidden", zIndex: 49, boxShadow: "0 12px 34px rgba(0,0,0,.4)", maxHeight: 240, overflowY: "auto" }}>
            {options.map((o) => {
              const on = sel.includes(o.id);
              return (
                <div key={o.id} onClick={() => onToggle(o.id)} style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 9, padding: "10px 12px", fontSize: 13, color: PAPER, borderBottom: `1px solid ${LINE}` }}>
                  <span style={{ width: 17, height: 17, borderRadius: 5, border: `1.5px solid ${on ? color : LINE}`, background: on ? color : "transparent", display: "grid", placeItems: "center", flexShrink: 0 }}>{on && <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="3.5" strokeLinecap="round" strokeLinejoin="round"><path d="M20 6L9 17l-5-5" /></svg>}</span>
                  {o.label}
                </div>
              );
            })}
          </div>
        </>
      )}
    </div>
  );
}

// Coach-dashboard: verschijnt als een ingelogde gebruiker de rol 'coach' heeft.
// Toont de leden + voortgang, en laat de coach leden aanmaken (met code) + code resetten.
export default function CoachDash({ session, org, isOwner, perms, lang, onLogout }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const color = (org && org.brand_color) || "#E11D48";
  const token = session && session.access_token;
  // Altijd een VERS, geldig access-token ophalen (anders 401 op de server). Forceer een
  // refresh als het token (bijna) verlopen is.
  async function freshToken() {
    try {
      const { data } = await supabase.auth.getSession();
      const s = data && data.session;
      let tok = s && s.access_token;
      const expMs = s && s.expires_at ? s.expires_at * 1000 : 0;
      if (!tok || (expMs && expMs < Date.now() + 10000)) {
        const r = await supabase.auth.refreshSession();
        tok = r && r.data && r.data.session && r.data.session.access_token;
      }
      return tok || token;
    } catch (e) { return token; }
  }

  // Modules (datagedreven/uitbreidbaar). De org heeft een beschikbare set (superuser-gestuurd);
  // de eigenaar ziet alles + Team, een coach alleen z'n toegewezen rechten.
  const MODS = (org && org.enabled_modules && org.enabled_modules.length) ? org.enabled_modules : ["members", "classes", "pt", "plans", "branding", "formula"];
  const LABEL = { overview: t("Overzicht", "Overview"), members: t("Leden", "Members"), classes: t("Lessen", "Classes"), pt: t("PT-agenda", "PT"), plans: t("Abonnementen", "Plans"), branding: t("Huisstijl", "Branding"), formula: t("Formule", "Formula"), team: t("Team", "Team") };
  const [previewRole, setPreviewRole] = useState("owner"); // demo: eigenaar bekijkt als coach
  const demoCoachMods = ["members", "pt", "classes"].filter((m) => MODS.includes(m));
  const myTabs = ["overview", ...(isOwner
    ? (previewRole === "coach" ? demoCoachMods : [...MODS, "team"])
    : (Array.isArray(perms) ? MODS.filter((m) => perms.includes(m)) : []))];
  const [active, setActive] = useState(null);
  const current = active && myTabs.includes(active) ? active : (myTabs[0] || null);
  const [navOpen, setNavOpen] = useState(false);     // nav-uitklapmenu (mobiel drawer)
  const [rowMenu, setRowMenu] = useState(null);       // member.id waarvan het actie-uitklapmenu open staat
  const [isWide, setIsWide] = useState(() => (typeof window !== "undefined" ? window.innerWidth >= 880 : true));
  useEffect(() => {
    const onR = () => setIsWide(window.innerWidth >= 880);
    window.addEventListener("resize", onR);
    return () => window.removeEventListener("resize", onR);
  }, []);

  const [members, setMembers] = useState(null);
  const [newName, setNewName] = useState("");
  const [busy, setBusy] = useState(false);
  const [codeShown, setCodeShown] = useState(null);  // {name, code}
  const [err, setErr] = useState("");

  // AI-ledenimport (CSV/Excel → koppen herkennen → bulk aanmaken)
  const [imp, setImp] = useState(null);     // {headers:[], rows:[[...]], map:{name,first,last,tier}, fileName}
  const [impBusy, setImpBusy] = useState(false);
  const [impErr, setImpErr] = useState("");
  const [impResults, setImpResults] = useState(null); // {created,total,results:[...]}

  // Huisstijl (self-serve white-label)
  const [tpl, setTpl] = useState((org && org.theme && org.theme.template) || "dark");
  const [accent, setAccent] = useState((org && org.theme && org.theme.accent) || (org && org.brand_color) || "#E11D48");
  const [logoData, setLogoData] = useState((org && org.logo_url) || null);
  const [brandBusy, setBrandBusy] = useState(false);
  const [brandMsg, setBrandMsg] = useState("");

  // Tiers + lessen
  const [newTier, setNewTier] = useState("pro");
  const [classes, setClasses] = useState(null);
  const [cName, setCName] = useState("");
  const [cDay, setCDay] = useState("1");
  const [cTime, setCTime] = useState("");
  const [cDur, setCDur] = useState("");
  const [cCap, setCCap] = useState("");
  const [editClassId, setEditClassId] = useState(null);
  const [cBusy, setCBusy] = useState(false);

  // Abonnementen
  const [plans, setPlans] = useState(null);
  const [pName, setPName] = useState("");
  const [pPt, setPPt] = useState(false);
  const [pClassIds, setPClassIds] = useState([]);
  const [planBusy, setPlanBusy] = useState(false);
  const [openClasses, setOpenClasses] = useState(null); // member.id waarvan de les-toegang open staat
  const [sel, setSel] = useState([]);                    // werk-selectie van class-ids
  const [openNote, setOpenNote] = useState(null);        // member.id waarvan de notitie open staat
  const [noteText, setNoteText] = useState("");
  const [noteBusy, setNoteBusy] = useState(false);
  const [openFormula, setOpenFormula] = useState(null);  // member.id waarvan de per-lid formule open staat
  const [fo, setFo] = useState({ protein_g_per_kg: "", fat_g_per_kg: "", cut_pct: "", gain_pct: "" });
  const [dictating, setDictating] = useState(false);
  const srSupported = typeof window !== "undefined" && !!(window.SpeechRecognition || window.webkitSpeechRecognition);

  // Team (eigenaar beheert coaches + rechten)
  const [coaches, setCoaches] = useState(null);
  const [ncEmail, setNcEmail] = useState("");
  const [ncPass, setNcPass] = useState("");
  const [ncName, setNcName] = useState("");
  const [ncPerms, setNcPerms] = useState(["members", "pt"]);
  const [teamBusy, setTeamBusy] = useState(false);
  const [teamMsg, setTeamMsg] = useState("");
  const [openPerms, setOpenPerms] = useState(null); // coach-id waarvan de rechten-editor open staat
  const [permSel, setPermSel] = useState([]);
  const [openEdit, setOpenEdit] = useState(null);   // coach-id waarvan de bewerk-editor open staat
  const [edName, setEdName] = useState("");
  const [edEmail, setEdEmail] = useState("");
  const [edPass, setEdPass] = useState("");
  const [edPass2, setEdPass2] = useState("");
  const [edShow, setEdShow] = useState(false);
  const [editMsg, setEditMsg] = useState("");

  // Rekenformule + juridisch akkoord
  const [termsOk, setTermsOk] = useState(null);     // null = nog niet geladen
  const [termsCheck, setTermsCheck] = useState(false);
  const [pPerKg, setPPerKg] = useState("2.0");
  const [fPerKg, setFPerKg] = useState("0.9");
  const [cutPct, setCutPct] = useState("-18");
  const [gainPct, setGainPct] = useState("8");
  const [calcBusy, setCalcBusy] = useState(false);
  const [calcMsg, setCalcMsg] = useState("");

  // PT-agenda
  const [sessions, setSessions] = useState(null);
  const [enrollCounts, setEnrollCounts] = useState(null); // {class_id: aantal inschrijvingen}
  const [dashCustom, setDashCustom] = useState(false);     // 'Aanpassen'-modus eigenaar
  const [dashHidden, setDashHidden] = useState(() => { try { return JSON.parse(localStorage.getItem("hf_dash_hidden_" + (org && org.id)) || "[]"); } catch (e) { return []; } });
  const [memberQuery, setMemberQuery] = useState("");
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
      // Tier + lestoegang apart + guarded (kolommen bestaan mogelijk nog niet vóór migratie).
      const tmap = {};
      try {
        const { data: tr } = await supabase.from("org_members").select("*").eq("role", "member"); // * = ontbrekende kolommen breken niks
        (tr || []).forEach((x) => { tmap[x.id] = x; });
      } catch (e) {}
      setMembers((mem || []).map((m) => ({ ...m, progress: pmap[m.auth_user_id] || null, member_tier: (tmap[m.id] && tmap[m.id].member_tier) || "pro", class_access: tmap[m.id] ? tmap[m.id].class_access : null, coach_note: (tmap[m.id] && tmap[m.id].coach_note) || "", calc_override: (tmap[m.id] && tmap[m.id].calc_override) || null, plan_id: (tmap[m.id] && tmap[m.id].plan_id) || null })));
    } catch (e) { setMembers([]); }
  }
  async function loadClasses() {
    if (!supabase) return;
    try {
      let { data, error } = await supabase.from("org_classes").select("id,name,day_of_week,start_time,duration_min,capacity").order("day_of_week", { ascending: true }).order("start_time", { ascending: true });
      if (error) { const r2 = await supabase.from("org_classes").select("id,name,day_of_week,start_time,duration_min").order("day_of_week", { ascending: true }).order("start_time", { ascending: true }); data = r2.data; } // capacity-kolom bestaat nog niet
      setClasses(data || []);
    } catch (e) { setClasses([]); }
  }
  async function loadPlans() {
    if (!supabase) return;
    try {
      const { data } = await supabase.from("org_plans").select("id,name,pt_included,class_ids").order("created_at", { ascending: true });
      setPlans(data || []);
    } catch (e) { setPlans([]); }
  }
  async function addPlan() {
    const name = pName.trim();
    if (!name || planBusy) return;
    setPlanBusy(true);
    try {
      const all = (classes || []).map((c) => c.id);
      const classIds = pClassIds.length >= all.length && all.every((id) => pClassIds.includes(id)) ? null : pClassIds; // alles = null (alle lessen)
      const { error } = await supabase.from("org_plans").insert({ org_id: org && org.id, name, pt_included: pPt, class_ids: classIds });
      if (!error) { setPName(""); setPPt(false); setPClassIds([]); loadPlans(); }
      setPlanBusy(false);
    } catch (e) { setPlanBusy(false); }
  }
  async function delPlan(id) {
    if (!supabase) return;
    try { await supabase.from("org_plans").delete().eq("id", id); loadPlans(); load(); } catch (e) {}
  }
  async function assignPlan(m, planId) {
    if (!supabase) return;
    const value = planId || null;
    try {
      const { error } = await supabase.from("org_members").update({ plan_id: value }).eq("id", m.id);
      if (!error) setMembers((xs) => xs.map((x) => x.id === m.id ? { ...x, plan_id: value } : x));
    } catch (e) {}
  }
  async function loadSessions() {
    if (!supabase) return;
    try {
      const { data } = await supabase.from("org_sessions").select("id,member_id,title,starts_at,note").gte("starts_at", new Date(Date.now() - 36e5).toISOString()).order("starts_at", { ascending: true });
      setSessions(data || []);
    } catch (e) { setSessions([]); }
  }
  async function loadEnroll() {
    if (!supabase) return;
    try {
      const { data, error } = await supabase.from("class_enrollments").select("class_id");
      if (error) { setEnrollCounts({}); return; }
      const c = {}; (data || []).forEach((r) => { c[r.class_id] = (c[r.class_id] || 0) + 1; });
      setEnrollCounts(c);
    } catch (e) { setEnrollCounts({}); }
  }
  function toggleWidget(key) {
    setDashHidden((xs) => {
      const next = xs.includes(key) ? xs.filter((x) => x !== key) : [...xs, key];
      try { localStorage.setItem("hf_dash_hidden_" + (org && org.id), JSON.stringify(next)); } catch (e) {}
      return next;
    });
  }
  async function loadConfig() {
    if (!supabase || !org || !org.id) return;
    try {
      const { data } = await supabase.from("org_config").select("terms_accepted_at,calc_profile").eq("org_id", org.id).limit(1);
      const cfg = data && data[0];
      setTermsOk(!!(cfg && cfg.terms_accepted_at));
      const raw = (cfg && cfg.calc_profile) || {}; const m = raw.macros || {}, g = raw.goal || {};
      const pick2 = (a, b2, d) => (a != null ? a : (b2 != null ? b2 : d));
      setPPerKg(String(pick2(raw.protein_g_per_kg, m.protein_g_per_kg, 2.0)));
      setFPerKg(String(pick2(raw.fat_g_per_kg, m.fat_g_per_kg, 0.9)));
      setCutPct(String(pick2(raw.cut_pct, g.cut_pct, -18)));
      setGainPct(String(pick2(raw.gain_pct, g.gain_pct, 8)));
    } catch (e) { setTermsOk(false); }
  }
  async function loadCoaches() {
    if (!supabase || !isOwner) return;
    try {
      let { data, error } = await supabase.from("org_members").select("id,auth_user_id,display_name,is_owner,perms").eq("role", "coach").order("is_owner", { ascending: false });
      if (error) { // kolommen is_owner/perms bestaan nog niet (vóór gym-roles.sql) → zonder laden
        const r2 = await supabase.from("org_members").select("id,auth_user_id,display_name").eq("role", "coach").order("created_at", { ascending: true });
        data = r2.data;
      }
      setCoaches(data || []);
    } catch (e) { setCoaches([]); }
  }
  useEffect(() => { load(); loadSessions(); loadClasses(); loadConfig(); loadCoaches(); loadPlans(); loadEnroll(); }, []);

  const togglePermIn = (arr, setArr, p) => setArr(arr.includes(p) ? arr.filter((x) => x !== p) : [...arr, p]);
  async function addCoach() {
    const email = ncEmail.trim().toLowerCase();
    if (!email || ncPass.length < 8 || teamBusy) { if (ncPass.length < 8) setTeamMsg(t("Wachtwoord min. 8 tekens.", "Password min. 8 chars.")); return; }
    setTeamBusy(true); setTeamMsg("");
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "addcoach", authToken: await freshToken(), email, password: ncPass, display_name: ncName.trim(), perms: ncPerms }) });
      const d = await r.json().catch(() => ({}));
      if (!r.ok) { setTeamMsg(d.error === "coach_exists_or_failed" ? t("E-mail bestaat al of ongeldig.", "Email exists or invalid.") : t("Aanmaken mislukt.", "Create failed.")); setTeamBusy(false); return; }
      setNcEmail(""); setNcPass(""); setNcName(""); setNcPerms(["members", "pt"]); setTeamBusy(false); setTeamMsg(t("Coach aangemaakt.", "Coach created.")); await loadCoaches(); setTimeout(loadCoaches, 700);
    } catch (e) { setTeamMsg(t("Aanmaken mislukt.", "Create failed.")); setTeamBusy(false); }
  }
  function openCoachPerms(c) {
    if (openPerms === c.id) { setOpenPerms(null); return; }
    setOpenPerms(c.id); setPermSel(Array.isArray(c.perms) ? c.perms.slice() : []);
  }
  async function saveCoachPerms(c) {
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "setperms", authToken: await freshToken(), member_id: c.id, perms: permSel }) });
      if (r.ok) { setCoaches((xs) => xs.map((x) => x.id === c.id ? { ...x, perms: permSel } : x)); setOpenPerms(null); }
    } catch (e) {}
  }
  function openCoachEdit(c) {
    if (openEdit === c.id) { setOpenEdit(null); return; }
    setOpenEdit(c.id); setEdName(c.display_name || ""); setEdEmail(""); setEdPass(""); setEdPass2(""); setEdShow(false); setEditMsg("");
  }
  async function saveCoachEdit(c) {
    setEditMsg("");
    const email = edEmail.trim().toLowerCase();
    if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) { setEditMsg(t("Ongeldig e-mailadres.", "Invalid email.")); return; }
    if (edPass && edPass.length < 8) { setEditMsg(t("Wachtwoord min. 8 tekens.", "Password min. 8 chars.")); return; }
    if (edPass && edPass !== edPass2) { setEditMsg(t("Wachtwoorden komen niet overeen.", "Passwords don't match.")); return; }
    try {
      const payload = { action: "editcoach", authToken: await freshToken(), member_id: c.id, display_name: edName.trim() };
      if (edPass) payload.password = edPass;
      if (email) payload.email = email;
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(payload) });
      if (r.ok) { setCoaches((xs) => xs.map((x) => x.id === c.id ? { ...x, display_name: edName.trim() } : x)); setEditMsg(t("Opgeslagen.", "Saved.")); setEdPass(""); setEdPass2(""); }
      else { const e = await r.json().catch(() => ({})); setEditMsg(e && e.error === "update_failed" ? t("E-mail/wachtwoord kon niet worden opgeslagen (bestaat de e-mail al?).", "Email/password could not be saved (email already in use?).") : t("Opslaan mislukt.", "Save failed.")); }
    } catch (e) { setEditMsg(t("Opslaan mislukt.", "Save failed.")); }
  }
  async function removeCoach(c) {
    if (typeof window !== "undefined" && !window.confirm(t("Coach verwijderen?", "Delete coach?"))) return;
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "removecoach", authToken: await freshToken(), member_id: c.id }) });
      if (r.ok) setCoaches((xs) => xs.filter((x) => x.id !== c.id));
    } catch (e) {}
  }

  async function acceptTerms() {
    if (!supabase || !termsCheck) return;
    try {
      const { error } = await supabase.from("org_config").update({ terms_accepted_at: new Date().toISOString(), terms_accepted_by: session && session.user && session.user.id }).eq("org_id", org.id);
      if (!error) setTermsOk(true);
    } catch (e) {}
  }
  async function saveFormula() {
    if (!supabase || calcBusy) return;
    setCalcBusy(true); setCalcMsg("");
    try {
      const prof = { protein_g_per_kg: parseFloat(pPerKg), fat_g_per_kg: parseFloat(fPerKg), cut_pct: parseFloat(cutPct), gain_pct: parseFloat(gainPct) };
      const { error } = await supabase.from("org_config").update({ calc_profile: prof }).eq("org_id", org.id);
      setCalcMsg(error ? t("Opslaan mislukt.", "Save failed.") : t("Opgeslagen. Geldt voor nieuwe berekeningen.", "Saved. Applies to new calculations."));
      setCalcBusy(false);
    } catch (e) { setCalcMsg(t("Opslaan mislukt.", "Save failed.")); setCalcBusy(false); }
  }

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
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "create", authToken: await freshToken(), display_name: name, tier: newTier }) });
      const d = await r.json().catch(() => ({}));
      if (!r.ok || !d.code) { setErr(t("Aanmaken mislukt.", "Create failed.")); setBusy(false); return; }
      setCodeShown({ name, code: d.code }); setNewName(""); setBusy(false); load();
    } catch (e) { setErr(t("Aanmaken mislukt.", "Create failed.")); setBusy(false); }
  }

  // --- AI-ledenimport ---
  // Raadt per veld de meest waarschijnlijke kolom (op basis van de kop-tekst).
  function guessMap(headers) {
    const lc = headers.map((h) => String(h || "").toLowerCase().trim());
    const find = (res) => { for (let i = 0; i < lc.length; i++) { if (res.some((re) => re.test(lc[i]))) return i; } return -1; };
    const first = find([/voornaam/, /first\s*name/, /^first$/, /given/]);
    const last = find([/achternaam/, /last\s*name/, /^last$/, /surname|familienaam/]);
    let name = find([/volledige\s*naam/, /full\s*name/, /^naam$/, /^name$/, /lid\s*naam|member\s*name|naam\s*lid/]);
    if (name < 0 && first < 0 && last < 0) name = find([/naam/, /name/]); // vang-alles
    const tier = find([/tier/, /abonnement/, /pakket/, /plan/, /lidmaatschap|membership/, /type/]);
    return { name, first, last, tier };
  }
  function normTier(v) {
    const s = String(v || "").toLowerCase();
    if (/basis|basic|light|start/.test(s)) return "basis";
    if (/pro|premium|plus|full|all/.test(s)) return "pro";
    return "pro";
  }
  // Zet de geparste rijen + mapping om naar de lijst leden die we aanmaken.
  function buildImportRows() {
    if (!imp) return [];
    const { map, rows } = imp;
    const out = [];
    const seen = new Set();
    for (const r of rows) {
      let name = map.name >= 0 ? String(r[map.name] || "").trim() : "";
      if (!name) { const f = map.first >= 0 ? String(r[map.first] || "").trim() : ""; const l = map.last >= 0 ? String(r[map.last] || "").trim() : ""; name = (f + " " + l).trim(); }
      if (!name) continue;
      const k = name.toLowerCase();
      if (seen.has(k)) continue; seen.add(k);
      out.push({ display_name: name.slice(0, 80), tier: map.tier >= 0 ? normTier(r[map.tier]) : "pro" });
    }
    return out;
  }
  async function onImportFile(file) {
    setImpErr(""); setImpResults(null);
    if (!file) return;
    const XLSX = typeof window !== "undefined" ? window.XLSX : null;
    if (!XLSX) { setImpErr(t("Importmodule nog aan het laden, probeer zo opnieuw.", "Import module still loading, try again.")); return; }
    try {
      const buf = await file.arrayBuffer();
      const wb = XLSX.read(buf, { type: "array" });
      const ws = wb.Sheets[wb.SheetNames[0]];
      const aoa = XLSX.utils.sheet_to_json(ws, { header: 1, blankrows: false, defval: "" });
      if (!aoa || aoa.length < 2) { setImpErr(t("Geen rijen gevonden (eerste rij = koppen).", "No rows found (first row = headers).")); return; }
      const headers = aoa[0].map((h) => String(h == null ? "" : h).trim());
      const rows = aoa.slice(1).filter((r) => r.some((c) => String(c || "").trim() !== ""));
      setImp({ headers, rows, map: guessMap(headers), fileName: file.name });
    } catch (e) { setImpErr(t("Bestand kon niet worden gelezen (gebruik .csv of .xlsx).", "Could not read the file (use .csv or .xlsx).")); }
  }
  function setImpMap(field, idx) { setImp((s) => s ? { ...s, map: { ...s.map, [field]: idx } } : s); }
  async function runImport() {
    const list = buildImportRows();
    if (!list.length) { setImpErr(t("Geen geldige namen om te importeren. Kies de juiste kolom.", "No valid names to import. Pick the right column.")); return; }
    setImpBusy(true); setImpErr("");
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "bulkcreate", authToken: await freshToken(), members: list }) });
      const d = await r.json().catch(() => ({}));
      if (!r.ok) { setImpErr(d && d.error === "too_many" ? t("Maximaal 200 leden per import.", "Max 200 members per import.") : t("Importeren mislukt.", "Import failed.")); setImpBusy(false); return; }
      setImpResults(d); setImpBusy(false); load();
    } catch (e) { setImpErr(t("Importeren mislukt.", "Import failed.")); setImpBusy(false); }
  }
  function downloadImportCodes() {
    if (!impResults || !impResults.results) return;
    const ok = impResults.results.filter((x) => x.ok);
    const esc = (s) => '"' + String(s == null ? "" : s).replace(/"/g, '""') + '"';
    const lines = [["Naam", "Code", "Tier"].map(esc).join(",")].concat(ok.map((x) => [esc(x.display_name), esc(x.code), esc(x.tier || "pro")].join(",")));
    const blob = new Blob(["﻿" + lines.join("\r\n")], { type: "text/csv;charset=utf-8" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a"); a.href = url; a.download = "leden-codes-" + new Date().toISOString().slice(0, 10) + ".csv";
    document.body.appendChild(a); a.click(); a.remove(); setTimeout(() => URL.revokeObjectURL(url), 1500);
  }
  function resetImport() { setImp(null); setImpErr(""); setImpResults(null); setImpBusy(false); }

  async function resetCode(m) {
    if (busy) return; setBusy(true); setErr("");
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "reset", authToken: await freshToken(), member_id: m.id }) });
      const d = await r.json().catch(() => ({}));
      if (!r.ok || !d.code) { setErr(t("Reset mislukt.", "Reset failed.")); setBusy(false); return; }
      setCodeShown({ name: m.display_name, code: d.code }); setBusy(false);
    } catch (e) { setErr(t("Reset mislukt.", "Reset failed.")); setBusy(false); }
  }

  // Tier wisselen (basis <-> pro) — coach mag org_members updaten (RLS).
  async function toggleTier(m) {
    if (!supabase) return;
    const next = (m.member_tier || "pro") === "pro" ? "basis" : "pro";
    try {
      const { error } = await supabase.from("org_members").update({ member_tier: next }).eq("id", m.id);
      if (!error) setMembers((xs) => xs.map((x) => x.id === m.id ? { ...x, member_tier: next } : x));
    } catch (e) {}
  }

  // Lessenbeheer
  function resetClassForm() { setCName(""); setCTime(""); setCDur(""); setCCap(""); setCDay("1"); setEditClassId(null); }
  function editClass(c) {
    setEditClassId(c.id);
    setCName(c.name || ""); setCDay(String(c.day_of_week)); setCTime(c.start_time || "");
    setCDur(c.duration_min != null ? String(c.duration_min) : ""); setCCap(c.capacity != null ? String(c.capacity) : "");
    try { window.scrollTo({ top: 0, behavior: "smooth" }); } catch (e) {}
  }
  async function addClass() {
    const name = cName.trim();
    if (!name || !cTime || cBusy) return;
    setCBusy(true);
    try {
      const fields = { name, day_of_week: parseInt(cDay, 10), start_time: cTime, duration_min: cDur ? parseInt(cDur, 10) : null, capacity: cCap ? parseInt(cCap, 10) : null };
      if (editClassId) {
        const { error } = await supabase.from("org_classes").update(fields).eq("id", editClassId);
        if (!error) { resetClassForm(); loadClasses(); }
      } else {
        const { error } = await supabase.from("org_classes").insert({ ...fields, org_id: org && org.id, created_by: session && session.user && session.user.id });
        if (!error) { resetClassForm(); loadClasses(); }
      }
      setCBusy(false);
    } catch (e) { setCBusy(false); }
  }
  async function delClass(id) {
    if (!supabase) return;
    if (typeof window !== "undefined" && !window.confirm(t("Les verwijderen?", "Delete class?"))) return;
    try { await supabase.from("org_classes").delete().eq("id", id); if (editClassId === id) resetClassForm(); loadClasses(); } catch (e) {}
  }

  // Les-toegang per lid
  function openMemberClasses(m) {
    if (openClasses === m.id) { setOpenClasses(null); return; }
    setOpenClasses(m.id);
    setSel(Array.isArray(m.class_access) ? m.class_access.slice() : (classes || []).map((c) => c.id)); // null = alles toegestaan
  }
  function toggleSel(id) { setSel((xs) => xs.includes(id) ? xs.filter((x) => x !== id) : [...xs, id]); }
  async function saveMemberClasses(m) {
    if (!supabase) return;
    // Alles aangevinkt -> null (alles toegestaan) zodat nieuwe lessen automatisch meekomen.
    const all = (classes || []).map((c) => c.id);
    const value = sel.length >= all.length && all.every((id) => sel.includes(id)) ? null : sel;
    try {
      const { error } = await supabase.from("org_members").update({ class_access: value }).eq("id", m.id);
      if (!error) { setMembers((xs) => xs.map((x) => x.id === m.id ? { ...x, class_access: value } : x)); setOpenClasses(null); }
    } catch (e) {}
  }
  const DAY_LBL = (d) => (lang === "nl" ? ["zo", "ma", "di", "wo", "do", "vr", "za"] : ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"])[d];

  // Lid verwijderen (org_members-rij + auth-gebruiker) via de server.
  async function deleteMember(m) {
    if (busy) return;
    const ok = typeof window !== "undefined" ? window.confirm(t("Lid \"" + (m.display_name || "") + "\" definitief verwijderen?", "Permanently delete member \"" + (m.display_name || "") + "\"?")) : true;
    if (!ok) return;
    setBusy(true);
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "remove", authToken: await freshToken(), member_id: m.id }) });
      if (r.ok) setMembers((xs) => xs.filter((x) => x.id !== m.id));
      setBusy(false);
    } catch (e) { setBusy(false); }
  }

  // Coach-notitie per lid (voor de coach zelf).
  function openMemberNote(m) {
    if (openNote === m.id) { setOpenNote(null); return; }
    setOpenNote(m.id); setNoteText(m.coach_note || "");
  }
  async function saveNote(m) {
    if (!supabase || noteBusy) return;
    setNoteBusy(true);
    try {
      const { error } = await supabase.from("org_members").update({ coach_note: noteText }).eq("id", m.id);
      if (!error) { setMembers((xs) => xs.map((x) => x.id === m.id ? { ...x, coach_note: noteText } : x)); setOpenNote(null); }
      setNoteBusy(false);
    } catch (e) { setNoteBusy(false); }
  }
  // Per-lid formule-override (leeg veld = standaard van de sportschool).
  function openMemberFormula(m) {
    if (openFormula === m.id) { setOpenFormula(null); return; }
    const o = m.calc_override || {};
    setOpenFormula(m.id);
    setFo({ protein_g_per_kg: o.protein_g_per_kg != null ? String(o.protein_g_per_kg) : "", fat_g_per_kg: o.fat_g_per_kg != null ? String(o.fat_g_per_kg) : "", cut_pct: o.cut_pct != null ? String(o.cut_pct) : "", gain_pct: o.gain_pct != null ? String(o.gain_pct) : "" });
  }
  async function saveMemberFormula(m) {
    if (!supabase) return;
    const clean = {};
    ["protein_g_per_kg", "fat_g_per_kg", "cut_pct", "gain_pct"].forEach((k) => { if (fo[k] !== "" && fo[k] != null && !isNaN(parseFloat(fo[k]))) clean[k] = parseFloat(fo[k]); });
    const value = Object.keys(clean).length ? clean : null; // niets ingevuld = terug naar standaard
    try {
      const { error } = await supabase.from("org_members").update({ calc_override: value }).eq("id", m.id);
      if (!error) { setMembers((xs) => xs.map((x) => x.id === m.id ? { ...x, calc_override: value } : x)); setOpenFormula(null); }
    } catch (e) {}
  }

  // Spraak-naar-tekst: voegt het gesproken stuk toe aan de notitie.
  function dictate() {
    const SR = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (!SR) return;
    const rec = new SR();
    rec.lang = lang === "nl" ? "nl-NL" : "en-US";
    rec.interimResults = false; rec.maxAlternatives = 1;
    rec.onresult = (e) => { try { const txt = e.results[0][0].transcript; setNoteText((t0) => (t0 ? t0.trim() + " " : "") + txt); } catch (err) {} };
    rec.onend = () => setDictating(false);
    rec.onerror = () => setDictating(false);
    setDictating(true);
    try { rec.start(); } catch (e) { setDictating(false); }
  }

  const fmtDate = (s) => { try { return s ? new Date(s).toLocaleDateString(lang === "nl" ? "nl-NL" : "en-GB", { day: "numeric", month: "short" }) : "—"; } catch (e) { return "—"; } };

  // Lijn-iconen (SVG, geen emoji/sjablonen). Kleur via currentColor.
  const svg = (paths, extra) => (p) => <svg width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" style={{ color: (p && p.col) || "currentColor", flexShrink: 0 }}>{paths}{extra}</svg>;
  const ICON = {
    overview: svg(<><rect x="3" y="3" width="7" height="7" rx="1.5" /><rect x="14" y="3" width="7" height="7" rx="1.5" /><rect x="3" y="14" width="7" height="7" rx="1.5" /><rect x="14" y="14" width="7" height="7" rx="1.5" /></>),
    members: svg(<><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><path d="M22 21v-2a4 4 0 0 0-3-3.87" /></>),
    classes: svg(<><rect x="3" y="4" width="18" height="18" rx="2" /><path d="M16 2v4M8 2v4M3 10h18" /></>),
    pt: svg(<><path d="M6.5 6.5l11 11M4 9l-1.5 1.5a1.5 1.5 0 000 2L4 14M20 9l1.5 1.5a1.5 1.5 0 010 2L20 14M7 4l1.5 1.5M17 20l-1.5-1.5" /></>),
    plans: svg(<><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z" /><circle cx="7" cy="7" r="1.2" /></>),
    branding: svg(<><circle cx="13.5" cy="6.5" r="1.3" /><circle cx="17.5" cy="10.5" r="1.3" /><circle cx="8.5" cy="7.5" r="1.3" /><circle cx="6.5" cy="12.5" r="1.3" /><path d="M12 2a10 10 0 1 0 0 20c1.1 0 2-.9 2-2 0-.5-.2-1-.5-1.3-.3-.4-.5-.8-.5-1.2 0-1.1.9-2 2-2h1.5A3.5 3.5 0 0 0 22 11c0-5-4.5-9-10-9z" /></>),
    formula: svg(<><rect x="4" y="2" width="16" height="20" rx="2" /><path d="M8 6h8M8 10h2M8 14h2M8 18h2M14 10v8" /></>),
    team: svg(<><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><circle cx="19" cy="7" r="3" /><path d="M23 21v-1.5a3.5 3.5 0 0 0-3-3.4" /></>),
    alert: svg(<><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><path d="M12 9v4M12 17h.01" /></>),
    wave: svg(<><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" /><path d="M13.73 21a2 2 0 0 1-3.46 0" /></>),
    calendar2: svg(<><rect x="3" y="4" width="18" height="18" rx="2" /><path d="M16 2v4M8 2v4M3 10h18M8 14h.01M12 14h.01M16 14h.01" /></>),
  };
  const EYE_ON = <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z" /><circle cx="12" cy="12" r="3" /></svg>;
  const EYE_OFF = <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" /><path d="M1 1l22 22" /></svg>;
  const UPLOAD_ICON = <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" /><path d="M17 8l-5-5-5 5" /><path d="M12 3v12" /></svg>;
  const DOWNLOAD_ICON = <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" /><path d="M7 10l5 5 5-5" /><path d="M12 15V3" /></svg>;
  const GEAR_ICON = <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="3" /><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z" /></svg>;
  const DONUT_COLORS = [color, "#60A5FA", "#34D399", "#F59E0B", "#A78BFA", "#F472B6"];

  // Aandacht-items (voor het overzicht én de badge in de zijbalk).
  function attentionItems() {
    const today = new Date().toISOString().slice(0, 10);
    const att = [];
    const lowAdh = (members || []).filter((m) => m.progress && m.progress.adherence != null && m.progress.adherence < 50);
    if (lowAdh.length) att.push({ ic: "alert", tint: "rgba(251,113,133,0.14)", icCol: EMBER_SOFT, title: lowAdh.length + " " + t("leden hebben aandacht nodig", "members need attention"), sub: t("Lage adherentie — bekijk hun voortgang", "Low adherence — check their progress"), badge: lowAdh.length, badgeColor: EMBER_SOFT, go: "members" });
    const notActive = (members || []).filter((m) => !(m.progress && m.progress.last_active));
    if (notActive.length) att.push({ ic: "wave", tint: "rgba(96,165,250,0.14)", icCol: "#60A5FA", title: notActive.length + " " + t("leden nog niet actief", "members not active yet"), sub: t("Nog niet ingelogd — deel hun code", "Not logged in yet — share their code"), badge: notActive.length, badgeColor: "#60A5FA", go: "members" });
    const noPlan = (plans && plans.length) ? (members || []).filter((m) => !m.plan_id) : [];
    if (noPlan.length) att.push({ ic: "plans", tint: "rgba(167,139,250,0.14)", icCol: "#A78BFA", title: noPlan.length + " " + t("leden zonder abonnement", "members without a plan"), sub: t("Koppel een abonnement zodat toegang klopt", "Assign a plan so access is correct"), badge: noPlan.length, badgeColor: "#A78BFA", go: "members" });
    const todaySessions = (sessions || []).filter((s) => (s.starts_at || "").slice(0, 10) === today);
    if (todaySessions.length) att.push({ ic: "calendar2", tint: "rgba(52,211,153,0.14)", icCol: "#34D399", title: todaySessions.length + " " + t("PT-sessies vandaag", "PT sessions today"), sub: t("Staan in je agenda", "In your schedule"), chevron: true, go: "pt" });
    if (!(classes && classes.length)) att.push({ ic: "classes", tint: "rgba(150,150,150,0.12)", icCol: MUTED, title: t("Nog geen lesrooster", "No class schedule yet"), sub: t("Voeg je weeklessen toe", "Add your weekly classes"), chevron: true, go: "classes" });
    if (!(plans && plans.length)) att.push({ ic: "plans", tint: "rgba(150,150,150,0.12)", icCol: MUTED, title: t("Nog geen abonnementen", "No plans yet"), sub: t("Maak je abonnementen aan", "Create your plans"), chevron: true, go: "plans" });
    return att;
  }
  // --- Dashboard-berekeningen (echte cijfers, niets verzonnen) ---
  function dashStats() {
    const ms = members || [];
    const now = new Date();
    const monthStart = new Date(now.getFullYear(), now.getMonth(), 1);
    const newThisMonth = ms.filter((m) => m.created_at && new Date(m.created_at) >= monthStart).length;
    const adhVals = ms.map((m) => (m.progress && m.progress.adherence != null ? m.progress.adherence : null)).filter((x) => x != null);
    const adhAvg = adhVals.length ? Math.round(adhVals.reduce((s, x) => s + x, 0) / adhVals.length) : null;
    const adhLow = ms.filter((m) => m.progress && m.progress.adherence != null && m.progress.adherence < 50).length;
    let capSum = 0, enrSum = 0, capKnown = false;
    (classes || []).forEach((c) => { if (c.capacity) { capSum += c.capacity; capKnown = true; } if (enrollCounts) enrSum += (enrollCounts[c.id] || 0); });
    const occ = (capKnown && capSum > 0 && enrollCounts) ? Math.round((enrSum / capSum) * 100) : null;
    const ptOpen = (sessions || []).length;
    const weeks = 8; const growth = [];
    for (let i = weeks - 1; i >= 0; i--) { const edge = new Date(now); edge.setDate(edge.getDate() - i * 7); growth.push(ms.filter((m) => m.created_at && new Date(m.created_at) <= edge).length); }
    return { active: ms.length, newThisMonth, adhAvg, adhLow, adhCount: adhVals.length, occ, enrSum, classCount: (classes || []).length, ptOpen, nextSession: (sessions || [])[0] || null, growth };
  }
  // Sparkline-/area-punten uit een reeks getallen.
  const sparkPts = (vals, w, h) => {
    if (!vals || vals.length < 2) return "";
    const mn = Math.min(...vals), mx = Math.max(...vals), rng = (mx - mn) || 1;
    return vals.map((v, i) => `${((i / (vals.length - 1)) * w).toFixed(1)},${(h - ((v - mn) / rng) * (h - 4) - 2).toFixed(1)}`).join(" ");
  };
  const aboSegments = () => {
    const ms = members || [];
    if (plans && plans.length) {
      const segs = plans.map((p, i) => ({ label: p.name, n: ms.filter((m) => m.plan_id === p.id).length, col: DONUT_COLORS[i % DONUT_COLORS.length] }));
      const none = ms.filter((m) => !m.plan_id).length;
      if (none) segs.push({ label: t("Zonder abo", "No plan"), n: none, col: "#2a333f" });
      return segs.filter((s) => s.n > 0);
    }
    const basis = ms.filter((m) => (m.member_tier || "pro") === "basis").length;
    const pro = ms.length - basis;
    return [{ label: "Pro", n: pro, col: color }, { label: "Basis", n: basis, col: "#60A5FA" }].filter((s) => s.n > 0);
  };

  // Relatieve tijd ("12 min geleden", "over 2 uur", "3 dagen geleden").
  const relTime = (iso) => {
    if (!iso) return "";
    const d = new Date(iso), diff = (d - new Date()) / 1000, abs = Math.abs(diff), fut = diff > 30;
    const mins = Math.round(abs / 60), hrs = Math.round(abs / 3600), days = Math.round(abs / 86400);
    let s;
    if (abs < 60) return t("zojuist", "just now");
    else if (abs < 3600) s = mins + " " + t("min", "min");
    else if (abs < 86400) s = hrs + " " + t("uur", "h");
    else if (days < 7) s = days + " " + (days === 1 ? t("dag", "d") : t("dagen", "d"));
    else return d.toLocaleDateString(lang === "nl" ? "nl-NL" : "en-GB", { day: "numeric", month: "short" });
    return fut ? (t("over", "in") + " " + s) : (s + " " + t("geleden", "ago"));
  };
  // Echte activiteiten-feed: samengevoegd uit leden (aangemaakt, laatst actief) + PT-sessies.
  function activityFeed() {
    const byId = {}; (members || []).forEach((m) => { byId[m.id] = m; });
    const ev = [];
    (members || []).forEach((m) => {
      if (m.created_at) ev.push({ ts: m.created_at, name: m.display_name || t("Naamloos", "Unnamed"), action: t("Nieuw lid aangemaakt", "New member added"), kind: "new", chip: (m.member_tier || "pro"), chipCol: MUTED });
      if (m.progress && m.progress.last_active) { const adh = m.progress.adherence; ev.push({ ts: m.progress.last_active, name: m.display_name || t("Naamloos", "Unnamed"), action: t("Actief in de app", "Active in the app"), kind: "active", chip: adh != null ? Math.round(adh) + "%" : null, chipCol: adh != null && adh < 50 ? color : "#34D399" }); }
    });
    (sessions || []).forEach((s) => {
      const nm = (byId[s.member_id] && byId[s.member_id].display_name) || s.title || t("PT-sessie", "PT session");
      if (s.starts_at) ev.push({ ts: s.starts_at, name: nm, action: t("PT-sessie gepland", "PT session scheduled"), kind: "pt", chip: null });
    });
    ev.sort((a, b) => (b.ts || "").localeCompare(a.ts || ""));
    return ev.slice(0, 7);
  }

  const navCount = (m) => {
    if (m === "overview") { const n = attentionItems().length; return n || null; }
    if (m === "members") return members ? members.length : null;
    if (m === "classes") return classes ? classes.length : null;
    if (m === "plans") return plans ? plans.length : null;
    if (m === "team") return coaches ? coaches.length : null;
    return null;
  };

  const card = { background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16 };
  const input = { width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "11px 12px", fontSize: 14, borderRadius: 8, outline: "none", boxSizing: "border-box", fontFamily: "Inter, sans-serif" };

  const meCoach = (coaches || []).find((c) => session && session.user && c.auth_user_id === session.user.id);
  const myName = (meCoach && meCoach.display_name) || "";
  const nowHour = new Date().getHours();
  const greetWord = nowHour < 12 ? t("Goedemorgen", "Good morning") : nowHour < 18 ? t("Goedemiddag", "Good afternoon") : t("Goedenavond", "Good evening");
  const todayLong = new Date().toLocaleDateString(lang === "nl" ? "nl-NL" : "en-GB", { weekday: "long", day: "numeric", month: "long" });
  // Navigatie in secties (zoals de mockup): Overzicht · Beheer · Organisatie.
  const NAV_SECTIONS = [
    { label: t("Overzicht", "Overview"), items: ["overview"] },
    { label: t("Beheer", "Manage"), items: ["members", "classes", "pt", "plans"] },
    { label: t("Organisatie", "Organization"), items: ["team", "branding", "formula"] },
  ];
  const renderNav = (closeAfter) => (
    <div style={{ display: "grid", gap: 2 }}>
      {NAV_SECTIONS.map((sec) => {
        const items = sec.items.filter((m) => myTabs.includes(m));
        if (!items.length) return null;
        return (
          <div key={sec.label} style={{ marginBottom: 6 }}>
            <div style={{ fontSize: 10, letterSpacing: 1.3, textTransform: "uppercase", color: MUTED, fontWeight: 700, padding: "12px 10px 6px", opacity: 0.8 }}>{sec.label}</div>
            {items.map((m) => {
              const on = current === m; const cnt = navCount(m);
              return (
                <div key={m} onClick={() => { setActive(m); if (closeAfter) setNavOpen(false); }} style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 11, padding: "10px 11px", borderRadius: 9, background: on ? (color + "1F") : "transparent", color: on ? color : PAPER }}>
                  <span style={{ display: "flex" }}>{ICON[m] ? ICON[m]({ col: on ? color : MUTED }) : null}</span>
                  <span style={{ ...disp, fontWeight: 600, fontSize: 13.5, flex: 1, color: on ? color : PAPER }}>{LABEL[m]}</span>
                  {cnt != null && <span style={{ minWidth: 20, height: 20, borderRadius: 10, background: on ? color : LINE, color: on ? "#fff" : MUTED, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 11, fontWeight: 700, ...disp, padding: "0 6px" }}>{cnt}</span>}
                </div>
              );
            })}
          </div>
        );
      })}
    </div>
  );
  const brandInitials = ((org && org.name) || "HF").replace(/[^A-Za-z0-9 ]/g, "").split(/\s+/).map((w) => w[0]).join("").slice(0, 2).toUpperCase() || "HF";
  const navBrand = (
    <div style={{ display: "flex", alignItems: "center", gap: 11, padding: "4px 8px 14px" }}>
      {org && org.logo_url
        ? <img src={org.logo_url} alt={org.name} style={{ maxHeight: 34, maxWidth: 150, objectFit: "contain" }} />
        : <>
            <div style={{ width: 34, height: 34, borderRadius: 9, background: color, display: "grid", placeItems: "center", color: "#fff", ...disp, fontWeight: 800, fontSize: 14, flexShrink: 0 }}>{brandInitials}</div>
            <div style={{ minWidth: 0 }}>
              <div style={{ ...disp, fontWeight: 800, fontSize: 15, color: PAPER, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{(org && org.name) || "Coach"}</div>
              <div style={{ fontSize: 10.5, color: MUTED, marginTop: 1 }}>{t("Beheer · white-label", "Admin · white-label")}</div>
            </div>
          </>}
    </div>
  );
  const myInitials = (myName || (org && org.name) || "?").slice(0, 2).toUpperCase();
  const navFooter = (
    <div style={{ marginTop: "auto", borderTop: `1px solid ${LINE}`, paddingTop: 12, display: "flex", alignItems: "center", gap: 10 }}>
      <div style={{ width: 32, height: 32, borderRadius: "50%", background: "#2a333f", display: "grid", placeItems: "center", fontSize: 12, fontWeight: 700, color: "#cfd5de", flexShrink: 0 }}>{myInitials}</div>
      <div style={{ flex: 1, minWidth: 0 }}>
        <div style={{ ...disp, fontWeight: 700, fontSize: 12.5, color: PAPER, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{myName || t("Beheerder", "Admin")}</div>
        <div style={{ fontSize: 10.5, color: MUTED }}>{isOwner ? t("Eigenaar", "Owner") : t("Coach", "Coach")}</div>
      </div>
      <div onClick={onLogout} title={t("Uitloggen", "Log out")} style={{ cursor: "pointer", color: MUTED, display: "grid", placeItems: "center", width: 30, height: 30, borderRadius: 8, border: `1px solid ${LINE}` }}>
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" /><path d="M16 17l5-5-5-5M21 12H9" /></svg>
      </div>
    </div>
  );

  return (
    <div style={{ minHeight: "100vh", background: INK, color: PAPER, fontFamily: "Inter, sans-serif", display: "flex" }}>
      {/* Zijbalk (desktop) */}
      {isWide && (
        <div style={{ width: 244, flexShrink: 0, borderRight: `1px solid ${LINE}`, background: INK, position: "sticky", top: 0, alignSelf: "flex-start", height: "100vh", display: "flex", flexDirection: "column", padding: "18px 14px", boxSizing: "border-box" }}>
          {navBrand}
          <div style={{ flex: 1, overflowY: "auto" }}>{renderNav(false)}</div>
          {navFooter}
        </div>
      )}
      {/* Drawer (mobiel) */}
      {!isWide && navOpen && (
        <>
          <div onClick={() => setNavOpen(false)} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.5)", zIndex: 40 }} />
          <div style={{ position: "fixed", top: 0, left: 0, bottom: 0, width: 252, background: INK, borderRight: `1px solid ${LINE}`, zIndex: 41, padding: "18px 14px", display: "flex", flexDirection: "column", boxSizing: "border-box" }}>
            {navBrand}
            <div style={{ flex: 1, overflowY: "auto" }}>{renderNav(true)}</div>
            {navFooter}
          </div>
        </>
      )}

      {/* Content-kolom */}
      <div style={{ flex: 1, minWidth: 0, paddingBottom: 40 }}>
        {isWide && (
          <div style={{ borderBottom: `1px solid ${LINE}`, background: INK, position: "sticky", top: 0, zIndex: 20 }}>
          <div style={{ maxWidth: current === "overview" ? 1320 : 1060, margin: "0 auto", padding: "16px 26px", display: "flex", alignItems: "center", gap: 14 }}>
            <div style={{ minWidth: 0 }}>
              {current === "overview"
                ? <>
                    <div style={{ ...disp, fontWeight: 800, fontSize: 20, color: PAPER, whiteSpace: "nowrap" }}>{greetWord}{myName ? ", " + myName : ""}</div>
                    <div style={{ fontSize: 12.5, color: MUTED, marginTop: 2, textTransform: "capitalize" }}>{todayLong}{isOwner ? "" : " · " + t("jouw overzicht", "your overview")}</div>
                  </>
                : <div style={{ ...disp, fontWeight: 800, fontSize: 20, color: PAPER }}>{LABEL[current]}</div>}
            </div>
            <div style={{ flex: 1 }} />
            {isOwner && (
              <div style={{ display: "flex", alignItems: "center", gap: 7 }}>
                <span style={{ fontSize: 11.5, color: MUTED, ...disp, fontWeight: 700, letterSpacing: 0.3 }}>{t("Bekijk als", "View as")}</span>
                <select value={previewRole} onChange={(e) => { setPreviewRole(e.target.value); setActive("overview"); }} style={{ ...input, width: "auto", appearance: "auto", WebkitAppearance: "auto", padding: "9px 12px", fontSize: 13, cursor: "pointer" }}>
                  <option value="owner">{t("Eigenaar", "Owner")}</option>
                  <option value="coach">{t("Coach", "Coach")}</option>
                </select>
              </div>
            )}
            {myTabs.includes("members") && (
              <div style={{ display: "flex", alignItems: "center", gap: 8, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: "8px 12px", width: 210 }}>
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke={MUTED} strokeWidth="2" strokeLinecap="round"><circle cx="11" cy="11" r="7" /><path d="M21 21l-4-4" /></svg>
                <input value={memberQuery} onChange={(e) => { setMemberQuery(e.target.value); if (current !== "members") setActive("members"); }} placeholder={t("Zoek lid…", "Search member…")} style={{ border: "none", outline: "none", background: "transparent", color: PAPER, fontSize: 13, width: "100%", fontFamily: "Inter, sans-serif" }} />
              </div>
            )}
            {myTabs.includes("members") && (
              <div onClick={() => setActive("members")} style={{ cursor: "pointer", display: "inline-flex", alignItems: "center", gap: 7, background: color, color: "#fff", borderRadius: 10, padding: "10px 15px", ...disp, fontWeight: 700, fontSize: 13, whiteSpace: "nowrap" }}>
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2.2" strokeLinecap="round"><path d="M12 5v14M5 12h14" /></svg>{t("Lid toevoegen", "Add member")}
              </div>
            )}
            {isOwner && previewRole === "coach" && <span style={{ fontSize: 11.5, color: MUTED }}>{t("(coach-voorbeeld)", "(coach preview)")}</span>}
          </div>
          </div>
        )}
        {!isWide && (
          <div style={{ borderBottom: `1px solid ${LINE}`, padding: "12px 14px", display: "flex", alignItems: "center", gap: 10, position: "sticky", top: 0, background: INK, zIndex: 20 }}>
            <div onClick={() => setNavOpen(true)} style={{ cursor: "pointer", color: PAPER, border: `1px solid ${LINE}`, borderRadius: 8, padding: "7px 10px", display: "flex" }}>
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M3 12h18M3 6h18M3 18h18" /></svg>
            </div>
            {org && org.logo_url ? <img src={org.logo_url} alt={org.name} style={{ maxHeight: 26, maxWidth: 130, objectFit: "contain" }} /> : <div style={{ ...disp, fontWeight: 800, fontSize: 16, color }}>{(org && org.name) || "Coach"}</div>}
            <div style={{ flex: 1 }} />
            <div style={{ ...disp, fontWeight: 700, fontSize: 14, color: PAPER }}>{LABEL[current]}</div>
          </div>
        )}
      <div style={{ maxWidth: current === "overview" ? 1320 : 1060, margin: "0 auto", padding: isWide ? "22px 26px" : "18px 14px", display: "grid", gap: 16 }}>
        {current === "overview" && (() => {
          const h = new Date().getHours();
          const greet = h < 12 ? t("Goedemorgen", "Good morning") : h < 18 ? t("Goedemiddag", "Good afternoon") : t("Goedenavond", "Good evening");
          const st = dashStats();
          const att = attentionItems().filter((a) => myTabs.includes(a.go));
          const canSee = (m) => myTabs.includes(m);
          const on = (k) => !dashHidden.includes(k);
          const SAGE2 = "#34D399", BLUE = "#60A5FA", AMBER = "#F59E0B";

          // KPI-tegels (alleen die onder je rechten vallen).
          const tiles = [];
          const brandTint = (color || "#E11D48") + "2E";
          if (canSee("members")) tiles.push({ k: "leden", ic: "members", col: color, tint: brandTint, label: t("Actieve leden", "Active members"), val: String(st.active), sub: st.newThisMonth ? "▲ " + st.newThisMonth + " " + t("deze maand", "this month") : t("stabiel", "steady"), subCol: st.newThisMonth ? SAGE2 : MUTED, spark: st.growth, sparkCol: SAGE2 });
          if (canSee("members")) tiles.push({ k: "adh", ic: "formula", col: BLUE, tint: "rgba(96,165,250,0.15)", label: t("Gem. adherentie", "Avg. adherence"), val: st.adhAvg == null ? "—" : st.adhAvg + "%", sub: st.adhAvg == null ? t("nog geen data", "no data yet") : (st.adhLow ? st.adhLow + " " + t("onder 50%", "below 50%") : t("iedereen ≥ 50%", "all ≥ 50%")), subCol: st.adhLow ? color : MUTED });
          if (canSee("classes")) tiles.push({ k: "bezet", ic: "classes", col: AMBER, tint: "rgba(245,158,11,0.15)", label: t("Lesbezetting", "Class occupancy"), val: st.occ == null ? (st.classCount + " " + t("lessen", "classes")) : st.occ + "%", sub: st.occ == null ? t("zet capaciteit per les", "set capacity per class") : st.enrSum + " " + t("ingeschreven", "enrolled"), subCol: MUTED });
          if (canSee("pt")) tiles.push({ k: "pt", ic: "pt", col: color, tint: brandTint, label: t("Open PT-sessies", "Open PT sessions"), val: String(st.ptOpen), sub: st.nextSession ? t("eerstvolgende", "next") + " " + fmtDate(st.nextSession.starts_at) : t("niets gepland", "nothing scheduled"), subCol: MUTED });

          const segs = aboSegments();
          const totalAbo = segs.reduce((s, x) => s + x.n, 0) || 1;
          const todayDow = new Date().getDay();
          const todayClasses = (classes || []).filter((c) => c.day_of_week === todayDow).sort((a, b) => (a.start_time || "").localeCompare(b.start_time || ""));
          const recentMembers = [...(members || [])].sort((a, b) => (b.created_at || "").localeCompare(a.created_at || "")).slice(0, 5);

          const cardHead = (title, mini) => (
            <div style={{ display: "flex", alignItems: "center", marginBottom: 14 }}>
              <div style={{ ...disp, fontWeight: 800, fontSize: 15 }}>{title}</div>
              {mini != null && <div style={{ marginLeft: "auto", fontSize: 11.5, color: MUTED, fontWeight: 600 }}>{mini}</div>}
            </div>
          );

          return (
            <>
              {/* header-actie: aanpassen (eigenaar) */}
              {isOwner && (
                <div style={{ display: "flex", justifyContent: "flex-end" }}>
                  <div onClick={() => setDashCustom((v) => !v)} style={{ cursor: "pointer", display: "inline-flex", alignItems: "center", gap: 7, border: `1px solid ${dashCustom ? color : LINE}`, color: dashCustom ? color : MUTED, borderRadius: 9, padding: "8px 13px", ...disp, fontWeight: 700, fontSize: 12.5 }}>{GEAR_ICON} {t("Aanpassen", "Customize")}</div>
                </div>
              )}

              {/* customization panel */}
              {isOwner && dashCustom && (
                <div style={{ ...card, border: `1px solid ${color}` }}>
                  <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 10 }}>{t("Kies wat je op je dashboard ziet:", "Choose what shows on your dashboard:")}</div>
                  <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
                    {[["kpis", t("Kerncijfers", "Key figures")], ["feed", t("Aandacht", "Attention")], ["growth", t("Ledengroei", "Member growth")], ["abo", t("Abonnementen", "Plans")], ["classes", t("Lessen vandaag", "Classes today")], ["team", "Team"], ["activity", t("Recente activiteit", "Recent activity")]].map(([k, lbl]) => {
                      const vis = on(k);
                      return <div key={k} onClick={() => toggleWidget(k)} style={{ cursor: "pointer", fontSize: 12.5, ...disp, fontWeight: 700, padding: "7px 13px", borderRadius: 8, border: `1px solid ${vis ? color : LINE}`, background: vis ? color : "transparent", color: vis ? "#fff" : MUTED }}>{vis ? "✓ " : ""}{lbl}</div>;
                    })}
                  </div>
                </div>
              )}

              {/* KPI-rij */}
              {on("kpis") && tiles.length > 0 && (
                <div style={{ display: "grid", gridTemplateColumns: isWide ? "repeat(" + Math.min(tiles.length, 4) + ", 1fr)" : "1fr 1fr", gap: 14 }}>
                  {tiles.map((ti) => (
                    <div key={ti.k} style={{ ...card, padding: 16, position: "relative", overflow: "hidden" }}>
                      <div style={{ width: 34, height: 34, borderRadius: 9, background: ti.tint, display: "grid", placeItems: "center", color: ti.col, marginBottom: 12 }}>{ICON[ti.ic] && ICON[ti.ic]({ col: ti.col })}</div>
                      <div style={{ fontSize: 12, color: MUTED, fontWeight: 600 }}>{ti.label}</div>
                      <div style={{ ...disp, fontSize: 26, fontWeight: 800, letterSpacing: 0.3, marginTop: 2 }}>{ti.val}</div>
                      <div style={{ fontSize: 11.5, fontWeight: 700, color: ti.subCol, marginTop: 6 }}>{ti.sub}</div>
                      {ti.spark && ti.spark.length > 1 && (Math.max(...ti.spark) > Math.min(...ti.spark)) && (
                        <svg width="70" height="26" viewBox="0 0 70 26" fill="none" style={{ position: "absolute", right: 14, bottom: 14, opacity: 0.9 }}><polyline points={sparkPts(ti.spark, 70, 26)} stroke={ti.sparkCol} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" /></svg>
                      )}
                    </div>
                  ))}
                </div>
              )}

              {/* grid */}
              <div style={{ display: "grid", gridTemplateColumns: isWide ? "1fr 340px" : "1fr", gap: 16 }}>
                {/* links */}
                <div style={{ display: "grid", gap: 16, alignContent: "start" }}>
                  {on("feed") && (
                    <div style={card}>
                      {cardHead(t("Dit vraagt vandaag je aandacht", "This needs your attention today"), att.length ? att.length + " " + t("punten", "items") : null)}
                      {att.length === 0
                        ? <div style={{ background: "rgba(52,211,153,0.1)", border: "1px solid rgba(52,211,153,0.3)", borderRadius: 11, padding: "13px 15px", display: "flex", alignItems: "center", gap: 10, color: SAGE2, fontSize: 13.5 }}><span style={{ fontSize: 16 }}>✓</span> {t("Alles bij — niets dat nu je aandacht vraagt.", "All clear — nothing needs your attention right now.")}</div>
                        : <div style={{ display: "grid", gap: 9 }}>
                            {att.map((a, i) => (
                              <div key={i} onClick={() => setActive(a.go)} style={{ display: "flex", alignItems: "center", gap: 13, background: INK, border: `1px solid ${LINE}`, borderRadius: 11, padding: "12px 14px", cursor: "pointer" }}>
                                <div style={{ width: 34, height: 34, borderRadius: 9, background: a.tint, display: "grid", placeItems: "center", color: a.icCol, flexShrink: 0 }}>{ICON[a.ic] && ICON[a.ic]({ col: a.icCol })}</div>
                                <div style={{ flex: 1, minWidth: 0 }}>
                                  <div style={{ ...disp, fontWeight: 700, fontSize: 13.5 }}>{a.title}</div>
                                  <div style={{ fontSize: 11.5, color: MUTED, marginTop: 1 }}>{a.sub}</div>
                                </div>
                                <span style={{ fontSize: 11.5, fontWeight: 700, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 8, padding: "6px 11px", flexShrink: 0 }}>{t("Bekijk", "View")}</span>
                              </div>
                            ))}
                          </div>}
                    </div>
                  )}

                  {isOwner && on("growth") && (
                    <div style={card}>
                      {cardHead(t("Ledengroei — laatste 8 weken", "Member growth — last 8 weeks"), (st.growth[st.growth.length - 1] - st.growth[0] >= 0 ? "+" : "") + (st.growth[st.growth.length - 1] - st.growth[0]) + " " + t("leden", "members"))}
                      {st.active === 0
                        ? <div style={{ fontSize: 12.5, color: MUTED }}>{t("Nog geen leden om te tonen.", "No members to show yet.")}</div>
                        : (() => {
                            const g = st.growth, w = 620, hgt = 150, mn = Math.min(...g), mx = Math.max(...g), rng = (mx - mn) || 1;
                            const pts = g.map((v, i) => `${((i / (g.length - 1)) * w).toFixed(1)},${(hgt - ((v - mn) / rng) * (hgt - 16) - 8).toFixed(1)}`);
                            return (
                              <svg viewBox={`0 0 ${w} ${hgt}`} width="100%" height={hgt} fill="none" preserveAspectRatio="none">
                                <line x1="0" y1={hgt * 0.25} x2={w} y2={hgt * 0.25} stroke={LINE} /><line x1="0" y1={hgt * 0.6} x2={w} y2={hgt * 0.6} stroke={LINE} />
                                <path d={`M0,${hgt} L${pts.join(" L")} L${w},${hgt} Z`} fill={color} fillOpacity="0.14" />
                                <polyline points={pts.join(" ")} stroke={color} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" />
                              </svg>
                            );
                          })()}
                    </div>
                  )}
                </div>

                {/* rechts */}
                <div style={{ display: "grid", gap: 16, alignContent: "start" }}>
                  {isOwner && on("abo") && (members && members.length > 0) && (
                    <div style={card}>
                      {cardHead(t("Leden per abonnement", "Members per plan"))}
                      <div style={{ display: "flex", alignItems: "center", gap: 16 }}>
                        <svg width="104" height="104" viewBox="0 0 42 42">
                          <circle cx="21" cy="21" r="15.9" fill="none" stroke="#242c38" strokeWidth="6.5" />
                          {(() => { let acc = 0; return segs.map((s, i) => { const len = (s.n / totalAbo) * 100; const el = <circle key={i} cx="21" cy="21" r="15.9" fill="none" stroke={s.col} strokeWidth="6.5" strokeDasharray={`${len} ${100 - len}`} strokeDashoffset={-acc} transform="rotate(-90 21 21)" />; acc += len; return el; }); })()}
                          <text x="21" y="20.5" textAnchor="middle" fontSize="7" fontWeight="700" fill={PAPER}>{st.active}</text>
                          <text x="21" y="26" textAnchor="middle" fontSize="3.2" fill={MUTED}>{t("leden", "members")}</text>
                        </svg>
                        <div style={{ display: "grid", gap: 8, fontSize: 12.5 }}>
                          {segs.map((s, i) => <div key={i} style={{ display: "flex", alignItems: "center", gap: 8, color: "#c7cdd6" }}><i style={{ width: 11, height: 11, borderRadius: 3, background: s.col, display: "inline-block" }} />{s.label} <b style={{ color: PAPER, marginLeft: 4 }}>{s.n}</b></div>)}
                        </div>
                      </div>
                    </div>
                  )}

                  {canSee("classes") && on("classes") && (
                    <div style={card}>
                      {cardHead(t("Lessen vandaag", "Classes today"), DAY_LBL(todayDow))}
                      {todayClasses.length === 0
                        ? <div style={{ fontSize: 12.5, color: MUTED }}>{t("Geen lessen vandaag.", "No classes today.")}</div>
                        : todayClasses.map((c) => {
                            const cnt = enrollCounts ? (enrollCounts[c.id] || 0) : null; const cap = c.capacity || null;
                            const full = cap != null && cnt != null && cnt >= cap;
                            const warn = cap != null && cnt != null && !full && cnt / cap >= 0.8;
                            const pillBg = full ? (color + "22") : warn ? "rgba(245,158,11,0.15)" : "rgba(52,211,153,0.14)";
                            const pillCol = full ? color : warn ? AMBER : SAGE2;
                            return (
                              <div key={c.id} style={{ display: "flex", alignItems: "center", gap: 12, padding: "11px 2px", borderBottom: `1px solid ${LINE}` }}>
                                <div style={{ ...disp, fontWeight: 800, fontSize: 12, width: 42 }}>{c.start_time}</div>
                                <div style={{ flex: 1, fontSize: 13, fontWeight: 600 }}>{c.name}</div>
                                {cap != null && cnt != null
                                  ? <span style={{ fontSize: 11, fontWeight: 700, borderRadius: 20, padding: "3px 10px", background: pillBg, color: pillCol }}>{full ? cnt + "/" + cap + " " + t("vol", "full") : cnt + "/" + cap}</span>
                                  : <span style={{ fontSize: 11, color: MUTED }}>{c.start_time}</span>}
                              </div>
                            );
                          })}
                    </div>
                  )}

                  {isOwner && on("team") && coaches && coaches.length > 0 && (
                    <div style={card}>
                      {cardHead("Team", coaches.length + " " + t("coaches", "coaches"))}
                      {coaches.map((c) => (
                        <div key={c.id} style={{ display: "flex", alignItems: "center", gap: 11, padding: "10px 2px", borderBottom: `1px solid ${LINE}` }}>
                          <div style={{ width: 30, height: 30, borderRadius: "50%", background: "#2a333f", display: "grid", placeItems: "center", fontSize: 11, fontWeight: 700, color: "#cfd5de" }}>{(c.display_name || "?").slice(0, 2).toUpperCase()}</div>
                          <div style={{ flex: 1, fontSize: 13, fontWeight: 600 }}>{c.display_name || t("Coach", "Coach")}<div style={{ fontSize: 11, color: MUTED }}>{c.is_owner ? t("Eigenaar", "Owner") : t("Coach", "Coach")}</div></div>
                          <span style={{ fontSize: 11, fontWeight: 700, borderRadius: 20, padding: "3px 10px", background: "rgba(52,211,153,0.14)", color: SAGE2 }}>{t("actief", "active")}</span>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              </div>

              {/* recente activiteit */}
              {canSee("members") && on("activity") && (() => {
                const feed = activityFeed();
                if (!feed.length) return null;
                const kindIcon = { new: "members", active: "wave", pt: "pt" };
                const kindCol = { new: color, active: "#60A5FA", pt: "#34D399" };
                return (
                  <div style={card}>
                    {cardHead(t("Recente activiteit", "Recent activity"), t("laatste gebeurtenissen", "latest events"))}
                    <div style={{ display: "grid", gap: 2 }}>
                      {feed.map((e, i) => (
                        <div key={i} style={{ display: "flex", alignItems: "center", gap: 12, padding: "11px 2px", borderTop: i ? `1px solid ${LINE}` : "none" }}>
                          <div style={{ width: 30, height: 30, borderRadius: 8, background: (kindCol[e.kind] || color) + "22", display: "grid", placeItems: "center", color: kindCol[e.kind] || color, flexShrink: 0 }}>{ICON[kindIcon[e.kind]] && ICON[kindIcon[e.kind]]({ col: kindCol[e.kind] || color })}</div>
                          <div style={{ flex: 1, minWidth: 0 }}>
                            <div style={{ fontSize: 13, color: PAPER }}><span style={{ fontWeight: 700 }}>{e.name}</span> <span style={{ color: MUTED }}>— {e.action}</span></div>
                          </div>
                          {e.chip != null && <span style={{ fontSize: 11, fontWeight: 700, borderRadius: 20, padding: "3px 10px", background: (e.chipCol || MUTED) + "22", color: e.chipCol || MUTED, textTransform: "capitalize", flexShrink: 0 }}>{e.chip}</span>}
                          <span style={{ fontSize: 11.5, color: MUTED, whiteSpace: "nowrap", flexShrink: 0, minWidth: 70, textAlign: "right" }}>{relTime(e.ts)}</span>
                        </div>
                      ))}
                    </div>
                  </div>
                );
              })()}
            </>
          );
        })()}

        {current === "members" && (<>
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
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap", alignItems: "center" }}>
            <input style={{ ...input, flex: 1, minWidth: 160 }} value={newName} onChange={(e) => setNewName(e.target.value)} onKeyDown={(e) => { if (e.key === "Enter") addMember(); }} placeholder={t("Naam van het lid", "Member name")} />
            <select value={newTier} onChange={(e) => setNewTier(e.target.value)} style={{ ...input, width: "auto", appearance: "auto", WebkitAppearance: "auto", padding: "11px 12px", cursor: "pointer", textTransform: "capitalize" }}>
              <option value="basis">{t("Basis", "Basis")}</option>
              <option value="pro">Pro</option>
            </select>
            <div onClick={addMember} style={{ cursor: busy ? "default" : "pointer", opacity: busy ? 0.7 : 1, background: color, color: "#fff", padding: "11px 18px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13.5, letterSpacing: 0.3, whiteSpace: "nowrap" }}>{t("Aanmaken", "Create")}</div>
          </div>
          <div style={{ fontSize: 11, color: MUTED, marginTop: 7, lineHeight: 1.5 }}>{t("basis = voeding + rooster · pro = ook persoonlijke PT", "basis = nutrition + schedule · pro = also personal PT")}</div>
          <div style={{ fontSize: 11.5, color: MUTED, marginTop: 10, lineHeight: 1.5 }}>{t("Deel de join-link + code met je lid:", "Share the join link + code with your member:")} <span style={{ color: PAPER }}>{joinUrl}</span></div>
          {err && <div style={{ fontSize: 12, color: EMBER_SOFT, marginTop: 8 }}>{err}</div>}
        </div>

        {/* AI-ledenimport */}
        <div style={card}>
          <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 6 }}>
            <span style={{ color }}>{ICON.members && ICON.members({ col: color })}</span>
            <div style={{ ...sectionTitle, color, margin: 0 }}>{t("Leden importeren", "Import members")}</div>
          </div>

          {!imp && !impResults && (
            <>
              <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.55, marginBottom: 12 }}>
                {t("Upload een CSV- of Excel-lijst met je leden. We herkennen de koppen automatisch en jij controleert de koppeling voordat we de codes aanmaken.",
                   "Upload a CSV or Excel list of your members. We recognise the headers automatically and you confirm the mapping before we generate the codes.")}
              </div>
              <label style={{ display: "inline-flex", alignItems: "center", gap: 9, cursor: "pointer", background: color, color: "#fff", padding: "11px 18px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13.5, letterSpacing: 0.3 }}>
                {UPLOAD_ICON}
                {t("Kies CSV / Excel", "Choose CSV / Excel")}
                <input type="file" accept=".csv,.xlsx,.xls,text/csv,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" style={{ display: "none" }} onChange={(e) => { onImportFile(e.target.files && e.target.files[0]); e.target.value = ""; }} />
              </label>
            </>
          )}

          {imp && !impResults && (() => {
            const preview = buildImportRows();
            const opts = imp.headers.map((h, i) => ({ i, label: h || t("(kolom ", "(column ") + (i + 1) + ")" }));
            const mapSel = (field, label, hint) => (
              <div style={{ display: "grid", gap: 4 }}>
                <div style={{ fontSize: 11, ...disp, fontWeight: 700, color: MUTED, letterSpacing: 0.3 }}>{label} {hint && <span style={{ fontWeight: 400, textTransform: "none" }}>· {hint}</span>}</div>
                <select value={imp.map[field]} onChange={(e) => setImpMap(field, parseInt(e.target.value, 10))} style={{ ...input, appearance: "auto" }}>
                  <option value={-1}>{t("— niet gebruiken —", "— don't use —")}</option>
                  {opts.map((o) => <option key={o.i} value={o.i}>{o.label}</option>)}
                </select>
              </div>
            );
            return (
              <>
                <div style={{ fontSize: 12, color: MUTED, marginBottom: 12 }}>{t("Bestand", "File")}: <span style={{ color: PAPER }}>{imp.fileName}</span> · {imp.rows.length} {t("rijen", "rows")}</div>
                <div style={{ display: "grid", gridTemplateColumns: isWide ? "1fr 1fr" : "1fr", gap: 10, marginBottom: 14 }}>
                  {mapSel("name", t("Naam", "Name"), t("volledige naam", "full name"))}
                  {mapSel("tier", "Tier", t("basis/pro, optioneel", "basis/pro, optional"))}
                  {mapSel("first", t("Voornaam", "First name"), t("als geen volledige naam", "if no full name"))}
                  {mapSel("last", t("Achternaam", "Last name"), t("als geen volledige naam", "if no full name"))}
                </div>

                <div style={{ fontSize: 11.5, ...disp, fontWeight: 700, color: MUTED, letterSpacing: 0.3, marginBottom: 6 }}>{t("Voorbeeld", "Preview")} · {preview.length} {t("leden", "members")}</div>
                {preview.length === 0
                  ? <div style={{ fontSize: 12.5, color: EMBER_SOFT, marginBottom: 12 }}>{t("Geen namen gevonden — kies de juiste kolom hierboven.", "No names found — pick the right column above.")}</div>
                  : <div style={{ display: "grid", gap: 4, marginBottom: 14, maxHeight: 170, overflowY: "auto" }}>
                      {preview.slice(0, 20).map((p, i) => (
                        <div key={i} style={{ display: "flex", justifyContent: "space-between", gap: 10, background: INK, border: `1px solid ${LINE}`, borderRadius: 7, padding: "7px 11px", fontSize: 13 }}>
                          <span style={{ color: PAPER }}>{p.display_name}</span>
                          <span style={{ ...disp, fontWeight: 700, fontSize: 11, color: MUTED, textTransform: "capitalize" }}>{p.tier}</span>
                        </div>
                      ))}
                      {preview.length > 20 && <div style={{ fontSize: 11.5, color: MUTED, padding: "2px 2px" }}>+ {preview.length - 20} {t("meer…", "more…")}</div>}
                    </div>}

                {impErr && <div style={{ fontSize: 12.5, color: EMBER_SOFT, marginBottom: 10 }}>{impErr}</div>}
                <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
                  <div onClick={() => { if (!impBusy && preview.length) runImport(); }} style={{ cursor: impBusy || !preview.length ? "default" : "pointer", opacity: impBusy || !preview.length ? 0.6 : 1, background: color, color: "#fff", padding: "11px 18px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13.5 }}>
                    {impBusy ? t("Bezig…", "Working…") : t("Importeer", "Import") + " " + preview.length + " " + t("leden", "members")}
                  </div>
                  <div onClick={resetImport} style={{ cursor: "pointer", padding: "11px 16px", borderRadius: 8, border: `1px solid ${LINE}`, color: MUTED, ...disp, fontWeight: 700, fontSize: 13 }}>{t("Annuleer", "Cancel")}</div>
                </div>
              </>
            );
          })()}

          {impResults && (
            <>
              <div style={{ fontSize: 14, color: PAPER, marginBottom: 4 }}>
                <strong style={{ color }}>{impResults.created}</strong> {t("van", "of")} {impResults.total} {t("leden aangemaakt.", "members created.")}
              </div>
              <div style={{ fontSize: 11.5, color: MUTED, marginBottom: 12 }}>{t("Codes zijn nu zichtbaar — deel ze met je leden (daarna niet meer te zien).", "Codes are visible now — share them with your members (hidden afterwards).")}</div>
              <div style={{ display: "grid", gap: 4, marginBottom: 14, maxHeight: 240, overflowY: "auto" }}>
                {impResults.results.map((x, i) => (
                  <div key={i} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", gap: 10, background: INK, border: `1px solid ${x.ok ? LINE : EMBER_SOFT}`, borderRadius: 7, padding: "8px 11px" }}>
                    <span style={{ color: PAPER, fontSize: 13 }}>{x.display_name}</span>
                    {x.ok
                      ? <span style={{ ...disp, fontWeight: 800, fontSize: 14, letterSpacing: 3, color }}>{x.code}</span>
                      : <span style={{ fontSize: 11.5, color: EMBER_SOFT }}>{t("mislukt", "failed")}</span>}
                  </div>
                ))}
              </div>
              <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
                <div onClick={downloadImportCodes} style={{ cursor: "pointer", display: "inline-flex", alignItems: "center", gap: 8, background: color, color: "#fff", padding: "11px 18px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13.5 }}>{DOWNLOAD_ICON} {t("Download codes (CSV)", "Download codes (CSV)")}</div>
                <div onClick={resetImport} style={{ cursor: "pointer", padding: "11px 16px", borderRadius: 8, border: `1px solid ${LINE}`, color: MUTED, ...disp, fontWeight: 700, fontSize: 13 }}>{t("Nieuwe import", "New import")}</div>
              </div>
            </>
          )}
        </div>

        {/* leden-lijst */}
        <div style={card}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 12, flexWrap: "wrap" }}>
            <div style={{ ...sectionTitle, color, margin: 0 }}>{t("Leden", "Members")} {members ? "(" + members.length + ")" : ""}</div>
            <div style={{ flex: 1 }} />
            <div style={{ display: "flex", alignItems: "center", gap: 8, background: INK, border: `1px solid ${LINE}`, borderRadius: 9, padding: "8px 11px", minWidth: 180 }}>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke={MUTED} strokeWidth="2" strokeLinecap="round"><circle cx="11" cy="11" r="7" /><path d="M21 21l-4-4" /></svg>
              <input value={memberQuery} onChange={(e) => setMemberQuery(e.target.value)} placeholder={t("Zoek lid…", "Search member…")} style={{ border: "none", outline: "none", background: "transparent", color: PAPER, fontSize: 13, width: "100%", fontFamily: "Inter, sans-serif" }} />
              {memberQuery && <span onClick={() => setMemberQuery("")} style={{ cursor: "pointer", color: MUTED, fontSize: 15, lineHeight: 1 }}>×</span>}
            </div>
          </div>
          {!members ? <div style={{ fontSize: 13, color: MUTED }}>{t("Laden…", "Loading…")}</div>
            : members.length === 0 ? <div style={{ fontSize: 13, color: MUTED, lineHeight: 1.5 }}>{t("Nog geen leden. Voeg je eerste lid toe.", "No members yet. Add your first one.")}</div>
            : (() => {
            const q = memberQuery.trim().toLowerCase();
            const shown = q ? members.filter((m) => (m.display_name || "").toLowerCase().includes(q)) : members;
            if (!shown.length) return <div style={{ fontSize: 13, color: MUTED }}>{t("Geen leden gevonden voor", "No members found for")} “{memberQuery}”.</div>;
            return (
            <div style={{ display: "grid", gap: 8 }}>
              {shown.map((m) => {
                const adh = m.progress && m.progress.adherence != null ? Math.round(m.progress.adherence) : null;
                const attention = adh != null && adh < 50;
                const pro = (m.member_tier || "pro") === "pro";
                return (
                  <div key={m.id} style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 10, position: "relative" }}>
                    <div style={{ display: "flex", alignItems: "center", gap: 10, padding: "11px 12px" }}>
                      <div style={{ flex: 1, minWidth: 0 }}>
                        <div style={{ ...disp, fontWeight: 700, fontSize: 14.5 }}>{m.display_name || t("Naamloos", "Unnamed")}{(m.coach_note || m.calc_override) ? <span style={{ color, fontSize: 13, marginLeft: 6 }}>•</span> : null}</div>
                        <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{t("Laatst actief", "Last active")}: {fmtDate(m.progress && m.progress.last_active)}</div>
                      </div>
                      <div style={{ textAlign: "right" }}>
                        <div style={{ ...disp, fontWeight: 700, fontSize: 14, color: adh == null ? MUTED : attention ? EMBER_SOFT : SAGE }}>{adh == null ? "—" : adh + "%"}</div>
                        <div style={{ fontSize: 10, color: MUTED }}>{t("adherentie", "adherence")}</div>
                      </div>
                      {plans && plans.length > 0 && (
                        <select value={m.plan_id || ""} onChange={(e) => assignPlan(m, e.target.value)} style={{ ...input, width: "auto", appearance: "auto", padding: "6px 9px", fontSize: 12.5 }}>
                          <option value="">{t("Geen abo", "No plan")}</option>
                          {plans.map((p) => <option key={p.id} value={p.id}>{p.name}</option>)}
                        </select>
                      )}
                      <div onClick={() => setRowMenu(rowMenu === m.id ? null : m.id)} title={t("Beheer", "Manage")} style={{ cursor: "pointer", fontSize: 18, lineHeight: 1, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "4px 11px" }}>⋯</div>
                    </div>
                    {rowMenu === m.id && (
                      <>
                        <div onClick={() => setRowMenu(null)} style={{ position: "fixed", inset: 0, zIndex: 28 }} />
                        <div style={{ position: "absolute", right: 10, top: 48, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, overflow: "hidden", zIndex: 29, minWidth: 180, boxShadow: "0 12px 34px rgba(0,0,0,.4)" }}>
                          {[
                            [t("Code resetten", "Reset code"), () => resetCode(m), false],
                            ...(!m.plan_id ? [[(t("Tier: ", "Tier: ") + (m.member_tier || "pro")), () => toggleTier(m), false]] : []),
                            ...(!m.plan_id && classes && classes.length > 0 ? [[t("Lessen", "Classes"), () => openMemberClasses(m), false]] : []),
                            [m.coach_note ? t("Notitie •", "Note •") : t("Notitie", "Note"), () => openMemberNote(m), false],
                            [m.calc_override ? t("Formule •", "Formula •") : t("Formule", "Formula"), () => openMemberFormula(m), false],
                            [t("Verwijderen", "Delete"), () => deleteMember(m), true],
                          ].map(([lbl, fn, danger], i) => (
                            <div key={i} onClick={() => { fn(); setRowMenu(null); }} style={{ cursor: "pointer", padding: "10px 14px", fontSize: 13, color: danger ? EMBER_SOFT : PAPER, borderBottom: `1px solid ${LINE}` }}>{lbl}</div>
                          ))}
                        </div>
                      </>
                    )}
                    {openNote === m.id && (
                      <div style={{ padding: "0 12px 12px" }}>
                        <textarea value={noteText} onChange={(e) => setNoteText(e.target.value)} placeholder={t("Notitie over dit lid…", "Note about this member…")} rows={3} style={{ ...input, resize: "vertical", minHeight: 64, fontFamily: "Inter, sans-serif" }} />
                        <div style={{ display: "flex", gap: 8, marginTop: 8, alignItems: "center" }}>
                          {srSupported && (
                            <div onClick={dictate} title={t("Inspreken", "Dictate")} style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 6, fontSize: 12.5, color: dictating ? color : MUTED, border: `1px solid ${dictating ? color : LINE}`, borderRadius: 7, padding: "7px 11px" }}>
                              <span style={{ width: 9, height: 9, borderRadius: "50%", background: dictating ? color : MUTED, display: "inline-block" }} />{dictating ? t("Luistert…", "Listening…") : t("Inspreken", "Dictate")}
                            </div>
                          )}
                          <div style={{ flex: 1 }} />
                          <div onClick={() => saveNote(m)} style={{ cursor: "pointer", background: color, color: "#fff", padding: "8px 16px", borderRadius: 7, ...disp, fontWeight: 700, fontSize: 12.5 }}>{noteBusy ? t("Opslaan…", "Saving…") : t("Opslaan", "Save")}</div>
                        </div>
                      </div>
                    )}
                    {openFormula === m.id && (
                      <div style={{ padding: "0 12px 12px" }}>
                        <div style={{ fontSize: 11, color: MUTED, marginBottom: 7, lineHeight: 1.5 }}>{t("Leeg = standaardformule van de sportschool. Alleen voor dit lid.", "Empty = gym's default formula. For this member only.")}</div>
                        <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 8 }}>
                          {[["Eiwit g/kg", "Protein g/kg", "protein_g_per_kg"], ["Vet g/kg", "Fat g/kg", "fat_g_per_kg"], ["Afvallen %", "Cut %", "cut_pct"], ["Aankomen %", "Gain %", "gain_pct"]].map(([nl, en, key]) => (
                            <div key={key}>
                              <div style={{ fontSize: 11, color: MUTED, marginBottom: 3 }}>{t(nl, en)}</div>
                              <input style={input} type="number" step="0.1" value={fo[key]} onChange={(e) => setFo((f) => ({ ...f, [key]: e.target.value }))} placeholder={t("standaard", "default")} />
                            </div>
                          ))}
                        </div>
                        <div onClick={() => saveMemberFormula(m)} style={{ cursor: "pointer", background: color, color: "#fff", padding: "8px 0", borderRadius: 7, textAlign: "center", ...disp, fontWeight: 700, fontSize: 12.5, marginTop: 8 }}>{t("Formule opslaan", "Save formula")}</div>
                      </div>
                    )}
                    {openClasses === m.id && classes && (
                      <div style={{ padding: "0 12px 12px", display: "grid", gap: 6 }}>
                        {classes.length === 0 ? <div style={{ fontSize: 12, color: MUTED }}>{t("Nog geen lessen.", "No classes yet.")}</div>
                          : classes.map((c) => (
                            <label key={c.id} style={{ display: "flex", alignItems: "center", gap: 8, cursor: "pointer", fontSize: 12.5, color: PAPER }}>
                              <input type="checkbox" checked={sel.includes(c.id)} onChange={() => toggleSel(c.id)} />
                              <span>{DAY_LBL(c.day_of_week)} {c.start_time} · {c.name}</span>
                            </label>
                          ))}
                        <div onClick={() => saveMemberClasses(m)} style={{ cursor: "pointer", background: color, color: "#fff", padding: "8px 0", borderRadius: 7, textAlign: "center", ...disp, fontWeight: 700, fontSize: 12.5, marginTop: 4 }}>{t("Lestoegang opslaan", "Save class access")}</div>
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
          ); })()}
        </div>

        </>)}

        {current === "classes" && (<>
        {/* Groepsrooster (lessen) */}
        <div style={card}>
          <div style={{ ...sectionTitle, color, marginBottom: 10 }}>{editClassId ? t("Les bewerken", "Edit class") : t("Lesrooster", "Class schedule")}</div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap", alignItems: "center" }}>
            <input style={{ ...input, flex: 1, minWidth: 140 }} value={cName} onChange={(e) => setCName(e.target.value)} placeholder={t("Les (bv. HYROX, HIIT)", "Class (e.g. HYROX, HIIT)")} />
            <select style={{ ...input, width: "auto", appearance: "auto" }} value={cDay} onChange={(e) => setCDay(e.target.value)}>
              {[1, 2, 3, 4, 5, 6, 0].map((d) => <option key={d} value={d}>{(lang === "nl" ? ["zondag", "maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag"] : ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])[d]}</option>)}
            </select>
            <input style={{ ...input, width: 110 }} type="time" value={cTime} onChange={(e) => setCTime(e.target.value)} />
            <input style={{ ...input, width: 70 }} type="number" value={cDur} onChange={(e) => setCDur(e.target.value)} placeholder={t("min", "min")} />
            <input style={{ ...input, width: 80 }} type="number" value={cCap} onChange={(e) => setCCap(e.target.value)} placeholder={t("max pers", "max")} />
            <div onClick={addClass} style={{ cursor: cBusy ? "default" : "pointer", opacity: cBusy ? 0.7 : 1, background: color, color: "#fff", padding: "11px 16px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.3, whiteSpace: "nowrap" }}>{cBusy ? t("Opslaan…", "Saving…") : editClassId ? t("Opslaan", "Save") : t("Toevoegen", "Add")}</div>
            {editClassId && <div onClick={resetClassForm} style={{ cursor: "pointer", padding: "11px 14px", borderRadius: 8, border: `1px solid ${LINE}`, color: MUTED, ...disp, fontWeight: 700, fontSize: 13 }}>{t("Annuleer", "Cancel")}</div>}
          </div>
          <div style={{ marginTop: 12, display: "grid", gap: 7 }}>
            {!classes ? <div style={{ fontSize: 13, color: MUTED }}>{t("Laden…", "Loading…")}</div>
              : classes.length === 0 ? <div style={{ fontSize: 12.5, color: MUTED }}>{t("Nog geen lessen. Voeg je weeklessen toe.", "No classes yet. Add your weekly classes.")}</div>
              : classes.map((c) => (
                <div key={c.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "9px 12px", background: INK, border: `1px solid ${LINE}`, borderRadius: 10 }}>
                  <div style={{ ...disp, fontWeight: 700, fontSize: 12.5, color, minWidth: 64, textTransform: "capitalize" }}>{(lang === "nl" ? ["zo", "ma", "di", "wo", "do", "vr", "za"] : ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"])[c.day_of_week]} {c.start_time}</div>
                  <div style={{ flex: 1, minWidth: 0, ...disp, fontWeight: 600, fontSize: 14 }}>{c.name}</div>
                  {c.duration_min ? <div style={{ fontSize: 11.5, color: MUTED }}>{c.duration_min} min</div> : null}
                  {c.capacity != null ? <div style={{ fontSize: 11.5, color: MUTED }}>max {c.capacity}</div> : null}
                  <div onClick={() => editClass(c)} style={{ cursor: "pointer", fontSize: 11.5, color: editClassId === c.id ? color : MUTED, border: `1px solid ${editClassId === c.id ? color : LINE}`, borderRadius: 7, padding: "5px 11px", ...disp, fontWeight: 700 }}>{t("Bewerken", "Edit")}</div>
                  <div onClick={() => delClass(c.id)} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "5px 9px" }}>{t("Verwijderen", "Delete")}</div>
                </div>
              ))}
          </div>
          <div style={{ fontSize: 11, color: MUTED, marginTop: 9, lineHeight: 1.5 }}>{t("Stel per lid in welke lessen in hun abo zitten (knop \"Lessen\" bij het lid).", "Set per member which classes are in their plan (the \"Classes\" button on each member).")}</div>
        </div>

        </>)}

        {current === "pt" && (<>
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

        </>)}

        {current === "formula" && (<>
        {/* Rekenformule + juridisch akkoord */}
        <div style={card}>
          <div style={{ ...sectionTitle, color, marginBottom: 10 }}>{t("Rekenformule", "Calculation formula")}</div>
          {termsOk === null ? (
            <div style={{ fontSize: 13, color: MUTED }}>{t("Laden…", "Loading…")}</div>
          ) : !termsOk ? (
            <div>
              <div style={{ fontSize: 12.5, color: PAPER, lineHeight: 1.55, marginBottom: 12 }}>
                {t("Je kunt de rekenformule voor jouw leden aanpassen. De sportschool is zelf verantwoordelijk voor de ingestelde waarden en geeft advies volgens de geldende wetgeving — geen schadelijk of medisch advies. HybridFuel levert alleen het gereedschap.", "You can adjust the calculation formula for your members. The gym is responsible for the values it sets and advises in line with applicable law — no harmful or medical advice. HybridFuel only provides the tool.")}
              </div>
              <label style={{ display: "flex", gap: 8, alignItems: "flex-start", cursor: "pointer", fontSize: 12.5, color: PAPER, marginBottom: 12 }}>
                <input type="checkbox" checked={termsCheck} onChange={(e) => setTermsCheck(e.target.checked)} style={{ marginTop: 2 }} />
                <span>{t("Ik ga akkoord namens de sportschool.", "I agree on behalf of the gym.")}</span>
              </label>
              <div onClick={acceptTerms} style={{ cursor: termsCheck ? "pointer" : "default", opacity: termsCheck ? 1 : 0.5, background: color, color: "#fff", padding: "11px 0", borderRadius: 8, textAlign: "center", ...disp, fontWeight: 700, fontSize: 13.5 }}>{t("Akkoord & formule instellen", "Agree & set formula")}</div>
            </div>
          ) : (
            <div>
              <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10 }}>
                {[["Eiwit (g/kg)", "Protein (g/kg)", pPerKg, setPPerKg, "0.1"], ["Vet (g/kg)", "Fat (g/kg)", fPerKg, setFPerKg, "0.1"], ["Afvallen (%)", "Cut (%)", cutPct, setCutPct, "1"], ["Aankomen (%)", "Gain (%)", gainPct, setGainPct, "1"]].map(([nl, en, val, set, step], i) => (
                  <div key={i}>
                    <div style={{ fontSize: 11.5, color: MUTED, marginBottom: 4 }}>{t(nl, en)}</div>
                    <input style={input} type="number" step={step} value={val} onChange={(e) => set(e.target.value)} />
                  </div>
                ))}
              </div>
              <div onClick={saveFormula} style={{ cursor: calcBusy ? "default" : "pointer", opacity: calcBusy ? 0.7 : 1, background: color, color: "#fff", padding: "11px 0", borderRadius: 8, textAlign: "center", ...disp, fontWeight: 700, fontSize: 13.5, marginTop: 12 }}>{calcBusy ? t("Opslaan…", "Saving…") : t("Formule opslaan", "Save formula")}</div>
              {calcMsg && <div style={{ fontSize: 12, color: SAGE, marginTop: 8 }}>{calcMsg}</div>}
              <div style={{ fontSize: 11, color: MUTED, marginTop: 9, lineHeight: 1.5 }}>{t("BMR (Mifflin-St Jeor), activiteitsfactoren en de veiligheidsvloer blijven vast. Alleen deze waarden passen de ledenberekening aan.", "BMR (Mifflin-St Jeor), activity factors and the safety floor stay fixed. Only these values adjust the member calculation.")}</div>
            </div>
          )}
        </div>

        </>)}

        {current === "branding" && (<>
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
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 16 }}>
            {(() => { const base = THEME_TEMPLATES[tpl] || THEME_TEMPLATES.dark; return (
              <div style={{ width: 34, height: 34, borderRadius: 8, background: base.ink, border: `1px solid ${base.line}`, position: "relative", flexShrink: 0 }}>
                <div style={{ position: "absolute", right: 4, bottom: 4, width: 10, height: 10, borderRadius: "50%", background: accent }} />
              </div>
            ); })()}
            <select value={tpl} onChange={(e) => setTpl(e.target.value)} style={{ ...input, width: "auto", minWidth: 180, appearance: "auto", WebkitAppearance: "auto", cursor: "pointer" }}>
              {Object.keys(THEME_TEMPLATES).map((k) => {
                const nm = { dark: t("Donker", "Dark"), light: t("Licht", "Light"), slate: t("Leisteen", "Slate"), sand: t("Zand", "Sand") }[k] || k;
                return <option key={k} value={k}>{nm}</option>;
              })}
            </select>
          </div>

          <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 6 }}>{t("Accentkleur (knoppen & accenten)", "Accent color (buttons & accents)")}</div>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 16 }}>
            <input type="color" value={accent} onChange={(e) => setAccent(e.target.value)} style={{ width: 46, height: 38, border: `1px solid ${LINE}`, borderRadius: 8, background: INK, cursor: "pointer", padding: 2 }} />
            <input value={accent} onChange={(e) => setAccent(e.target.value)} style={{ ...input, width: 130 }} />
          </div>

          <div onClick={saveBrand} style={{ cursor: brandBusy ? "default" : "pointer", opacity: brandBusy ? 0.7 : 1, background: accent, color: "#fff", padding: "11px 0", borderRadius: 8, textAlign: "center", ...disp, fontWeight: 700, fontSize: 13.5, letterSpacing: 0.3 }}>{brandBusy ? t("Opslaan…", "Saving…") : t("Huisstijl opslaan", "Save branding")}</div>
          {brandMsg && <div style={{ fontSize: 12, color: SAGE, marginTop: 8 }}>{brandMsg}</div>}
        </div>
        </>)}

        {current === "plans" && (<>
          <div style={card}>
            <div style={{ ...sectionTitle, color, marginBottom: 10 }}>{t("Abonnement toevoegen", "Add plan")}</div>
            <div style={{ display: "grid", gap: 8 }}>
              <input style={input} value={pName} onChange={(e) => setPName(e.target.value)} placeholder={t("Naam (bv. Onbeperkt, Basic, HYROX-only)", "Name (e.g. Unlimited, Basic)")} />
              <label style={{ display: "flex", alignItems: "center", gap: 8, cursor: "pointer", fontSize: 13, color: PAPER }}>
                <input type="checkbox" checked={pPt} onChange={(e) => setPPt(e.target.checked)} /> {t("Persoonlijke PT inbegrepen", "Personal PT included")}
              </label>
              <div style={{ fontSize: 11.5, color: MUTED }}>{t("Welke lessen zitten in dit abo:", "Which classes are included:")}</div>
              {(classes || []).length === 0
                ? <div style={{ fontSize: 12, color: MUTED }}>{t("Voeg eerst lessen toe (tab Lessen).", "Add classes first (Classes tab).")}</div>
                : <MultiPick options={(classes || []).map((cl) => ({ id: cl.id, label: DAY_LBL(cl.day_of_week) + " " + cl.start_time + " · " + cl.name }))} selected={pClassIds} onToggle={(id) => togglePermIn(pClassIds, setPClassIds, id)} placeholder={t("Kies lessen (leeg = alle)…", "Pick classes (empty = all)…")} color={color} />}
              <div onClick={addPlan} style={{ cursor: planBusy ? "default" : "pointer", opacity: planBusy ? 0.7 : 1, background: color, color: "#fff", padding: "11px 0", borderRadius: 8, textAlign: "center", ...disp, fontWeight: 700, fontSize: 13.5, marginTop: 4 }}>{planBusy ? t("Opslaan…", "Saving…") : t("Abonnement opslaan", "Save plan")}</div>
              <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5 }}>{t("Daarna kies je per lid alleen nog het abo (tab Leden) — de lessen + PT-toegang volgen automatisch.", "Then just pick a plan per member (Members tab) — classes + PT access follow automatically.")}</div>
            </div>
          </div>
          <div style={card}>
            <div style={{ ...sectionTitle, color, marginBottom: 12 }}>{t("Abonnementen", "Plans")} {plans ? "(" + plans.length + ")" : ""}</div>
            {!plans ? <div style={{ fontSize: 13, color: MUTED }}>{t("Laden…", "Loading…")}</div>
              : plans.length === 0 ? <div style={{ fontSize: 12.5, color: MUTED }}>{t("Nog geen abonnementen.", "No plans yet.")}</div>
              : (
                <div style={{ display: "grid", gap: 8 }}>
                  {plans.map((p) => (
                    <div key={p.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "11px 12px", background: INK, border: `1px solid ${LINE}`, borderRadius: 10 }}>
                      <div style={{ flex: 1, minWidth: 0 }}>
                        <div style={{ ...disp, fontWeight: 700, fontSize: 14.5 }}>{p.name}</div>
                        <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{p.class_ids == null ? t("alle lessen", "all classes") : (p.class_ids.length + " " + t("lessen", "classes"))}{p.pt_included ? " · " + t("incl. PT", "incl. PT") : ""}</div>
                      </div>
                      <div onClick={() => delPlan(p.id)} style={{ cursor: "pointer", fontSize: 11.5, color: EMBER_SOFT, border: `1px solid ${LINE}`, borderRadius: 7, padding: "5px 9px" }}>{t("Verwijderen", "Delete")}</div>
                    </div>
                  ))}
                </div>
              )}
          </div>
        </>)}

        {current === "team" && isOwner && (
          <>
          <div style={card}>
            <div style={{ ...sectionTitle, color, marginBottom: 10 }}>{t("Coach toevoegen", "Add coach")}</div>
            <div style={{ display: "grid", gap: 8 }}>
              <input style={input} value={ncName} onChange={(e) => setNcName(e.target.value)} placeholder={t("Naam", "Name")} />
              <input style={input} type="email" value={ncEmail} onChange={(e) => setNcEmail(e.target.value)} placeholder={t("E-mail", "Email")} />
              <input style={input} type="text" value={ncPass} onChange={(e) => setNcPass(e.target.value)} placeholder={t("Tijdelijk wachtwoord (min. 8)", "Temporary password (min. 8)")} />
              <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{t("Rechten (wat deze coach mag beheren):", "Permissions (what this coach can manage):")}</div>
              <MultiPick options={MODS.map((m) => ({ id: m, label: LABEL[m] || m }))} selected={ncPerms} onToggle={(m) => togglePermIn(ncPerms, setNcPerms, m)} placeholder={t("Kies rechten…", "Pick permissions…")} color={color} />
              <div onClick={addCoach} style={{ cursor: teamBusy ? "default" : "pointer", opacity: teamBusy ? 0.7 : 1, background: color, color: "#fff", padding: "11px 0", borderRadius: 8, textAlign: "center", ...disp, fontWeight: 700, fontSize: 13.5, marginTop: 4 }}>{teamBusy ? t("Aanmaken…", "Creating…") : t("Coach aanmaken", "Create coach")}</div>
              {teamMsg && <div style={{ fontSize: 12, color: SAGE, marginTop: 4 }}>{teamMsg}</div>}
            </div>
          </div>

          <div style={card}>
            <div style={{ ...sectionTitle, color, marginBottom: 12 }}>{t("Team", "Team")} {coaches ? "(" + coaches.length + ")" : ""}</div>
            {!coaches ? <div style={{ fontSize: 13, color: MUTED }}>{t("Laden…", "Loading…")}</div>
              : (
              <div style={{ display: "grid", gap: 8 }}>
                {coaches.map((c) => (
                  <div key={c.id} style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 10, position: "relative" }}>
                    <div style={{ display: "flex", alignItems: "center", gap: 10, padding: "11px 12px" }}>
                      <div style={{ flex: 1, minWidth: 0 }}>
                        <div style={{ ...disp, fontWeight: 700, fontSize: 14.5 }}>{c.display_name || t("Coach", "Coach")}</div>
                        <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{c.is_owner ? t("Eigenaar · alle rechten", "Owner · all access") : (Array.isArray(c.perms) && c.perms.length ? c.perms.map((p) => LABEL[p] || p).join(", ") : t("geen rechten", "no access"))}</div>
                      </div>
                      {!c.is_owner && (
                        <div onClick={() => setRowMenu(rowMenu === c.id ? null : c.id)} title={t("Instellingen", "Settings")} style={{ cursor: "pointer", fontSize: 18, lineHeight: 1, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "4px 11px" }}>⋯</div>
                      )}
                    </div>
                    {rowMenu === c.id && (
                      <>
                        <div onClick={() => setRowMenu(null)} style={{ position: "fixed", inset: 0, zIndex: 28 }} />
                        <div style={{ position: "absolute", right: 10, top: 46, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, overflow: "hidden", zIndex: 29, minWidth: 180, boxShadow: "0 12px 34px rgba(0,0,0,.4)" }}>
                          {[
                            [t("Bewerken", "Edit"), () => openCoachEdit(c), false],
                            [t("Rechten", "Permissions"), () => openCoachPerms(c), false],
                            [t("Verwijderen", "Delete"), () => removeCoach(c), true],
                          ].map(([lbl, fn, danger], i) => (
                            <div key={i} onClick={() => { fn(); setRowMenu(null); }} style={{ cursor: "pointer", padding: "10px 14px", fontSize: 13, color: danger ? EMBER_SOFT : PAPER, borderBottom: `1px solid ${LINE}` }}>{lbl}</div>
                          ))}
                        </div>
                      </>
                    )}
                    {openEdit === c.id && (
                      <div style={{ padding: "0 12px 14px", display: "grid", gap: 10 }}>
                        <div style={{ display: "grid", gap: 4 }}>
                          <div style={{ fontSize: 11, ...disp, fontWeight: 700, color: MUTED, letterSpacing: .3 }}>{t("Naam", "Name")}</div>
                          <input style={input} value={edName} onChange={(e) => setEdName(e.target.value)} placeholder={t("Naam", "Name")} />
                        </div>
                        <div style={{ display: "grid", gap: 4 }}>
                          <div style={{ fontSize: 11, ...disp, fontWeight: 700, color: MUTED, letterSpacing: .3 }}>{t("E-mail (leeg = niet wijzigen)", "Email (empty = keep)")}</div>
                          <input style={input} type="email" value={edEmail} onChange={(e) => setEdEmail(e.target.value)} placeholder={t("nieuw@e-mail.nl", "new@email.com")} autoCapitalize="none" autoCorrect="off" />
                        </div>
                        <div style={{ display: "grid", gap: 4 }}>
                          <div style={{ fontSize: 11, ...disp, fontWeight: 700, color: MUTED, letterSpacing: .3 }}>{t("Nieuw wachtwoord (leeg = niet wijzigen)", "New password (empty = keep)")}</div>
                          <div style={{ position: "relative" }}>
                            <input style={{ ...input, paddingRight: 44 }} type={edShow ? "text" : "password"} value={edPass} onChange={(e) => setEdPass(e.target.value)} placeholder="••••••••" autoComplete="new-password" />
                            <div onClick={() => setEdShow((v) => !v)} title={edShow ? t("Verbergen", "Hide") : t("Tonen", "Show")} style={{ position: "absolute", right: 8, top: "50%", transform: "translateY(-50%)", cursor: "pointer", color: MUTED, display: "grid", placeItems: "center", width: 28, height: 28 }}>
                              {edShow ? EYE_OFF : EYE_ON}
                            </div>
                          </div>
                        </div>
                        {edPass && (
                          <div style={{ display: "grid", gap: 4 }}>
                            <div style={{ fontSize: 11, ...disp, fontWeight: 700, color: MUTED, letterSpacing: .3 }}>{t("Bevestig wachtwoord", "Confirm password")}</div>
                            <input style={input} type={edShow ? "text" : "password"} value={edPass2} onChange={(e) => setEdPass2(e.target.value)} placeholder="••••••••" autoComplete="new-password" />
                          </div>
                        )}
                        <div onClick={() => saveCoachEdit(c)} style={{ cursor: "pointer", background: color, color: "#fff", padding: "10px 0", borderRadius: 8, textAlign: "center", ...disp, fontWeight: 700, fontSize: 13 }}>{t("Opslaan", "Save")}</div>
                        {editMsg && <div style={{ fontSize: 11.5, color: editMsg === t("Opgeslagen.", "Saved.") ? SAGE : EMBER_SOFT }}>{editMsg}</div>}
                      </div>
                    )}
                    {openPerms === c.id && (
                      <div style={{ padding: "0 12px 12px", display: "grid", gap: 8 }}>
                        <MultiPick options={MODS.map((m) => ({ id: m, label: LABEL[m] || m }))} selected={permSel} onToggle={(m) => togglePermIn(permSel, setPermSel, m)} placeholder={t("Kies rechten…", "Pick permissions…")} color={color} />
                        <div onClick={() => saveCoachPerms(c)} style={{ cursor: "pointer", background: color, color: "#fff", padding: "8px 0", borderRadius: 7, textAlign: "center", ...disp, fontWeight: 700, fontSize: 12.5 }}>{t("Rechten opslaan", "Save permissions")}</div>
                      </div>
                    )}
                  </div>
                ))}
              </div>
            )}
          </div>
          </>
        )}
      </div>
      </div>
    </div>
  );
}
