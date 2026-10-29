import React, { useState, useEffect } from "react";
import { INK, INK2, PAPER, MUTED, LINE, SAGE, EMBER_SOFT, disp, sectionTitle, applyOrgTheme, THEME_TEMPLATES } from "../shared.js";
import { supabase } from "../supabaseClient.js";

// Coach-dashboard: verschijnt als een ingelogde gebruiker de rol 'coach' heeft.
// Toont de leden + voortgang, en laat de coach leden aanmaken (met code) + code resetten.
export default function CoachDash({ session, org, isOwner, perms, lang, onLogout }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const color = (org && org.brand_color) || "#E11D48";
  const token = session && session.access_token;
  // Altijd een VERS access-token ophalen (het vastgelegde token kan verlopen zijn → 401).
  async function freshToken() {
    try { const { data } = await supabase.auth.getSession(); return (data && data.session && data.session.access_token) || token; } catch (e) { return token; }
  }

  // Modules (datagedreven/uitbreidbaar). De org heeft een beschikbare set (superuser-gestuurd);
  // de eigenaar ziet alles + Team, een coach alleen z'n toegewezen rechten.
  const MODS = (org && org.enabled_modules && org.enabled_modules.length) ? org.enabled_modules : ["members", "classes", "pt", "plans", "branding", "formula"];
  const LABEL = { members: t("Leden", "Members"), classes: t("Lessen", "Classes"), pt: t("PT-agenda", "PT"), plans: t("Abonnementen", "Plans"), branding: t("Huisstijl", "Branding"), formula: t("Formule", "Formula"), team: t("Team", "Team") };
  const myTabs = isOwner ? [...MODS, "team"] : (Array.isArray(perms) ? MODS.filter((m) => perms.includes(m)) : []);
  const [active, setActive] = useState(null);
  const current = active && myTabs.includes(active) ? active : (myTabs[0] || null);

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

  // Tiers + lessen
  const [newTier, setNewTier] = useState("pro");
  const [classes, setClasses] = useState(null);
  const [cName, setCName] = useState("");
  const [cDay, setCDay] = useState("1");
  const [cTime, setCTime] = useState("");
  const [cDur, setCDur] = useState("");
  const [cCap, setCCap] = useState("");
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
  const [edPass, setEdPass] = useState("");
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
      const { data } = await supabase.from("org_members").select("id,auth_user_id,display_name,is_owner,perms").eq("role", "coach").order("is_owner", { ascending: false });
      setCoaches(data || []);
    } catch (e) { setCoaches([]); }
  }
  useEffect(() => { load(); loadSessions(); loadClasses(); loadConfig(); loadCoaches(); loadPlans(); }, []);

  const togglePermIn = (arr, setArr, p) => setArr(arr.includes(p) ? arr.filter((x) => x !== p) : [...arr, p]);
  async function addCoach() {
    const email = ncEmail.trim().toLowerCase();
    if (!email || ncPass.length < 8 || teamBusy) { if (ncPass.length < 8) setTeamMsg(t("Wachtwoord min. 8 tekens.", "Password min. 8 chars.")); return; }
    setTeamBusy(true); setTeamMsg("");
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "addcoach", authToken: await freshToken(), email, password: ncPass, display_name: ncName.trim(), perms: ncPerms }) });
      const d = await r.json().catch(() => ({}));
      if (!r.ok) { setTeamMsg(d.error === "coach_exists_or_failed" ? t("E-mail bestaat al of ongeldig.", "Email exists or invalid.") : t("Aanmaken mislukt.", "Create failed.")); setTeamBusy(false); return; }
      setNcEmail(""); setNcPass(""); setNcName(""); setNcPerms(["members", "pt"]); setTeamBusy(false); setTeamMsg(t("Coach aangemaakt.", "Coach created.")); loadCoaches();
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
    setOpenEdit(c.id); setEdName(c.display_name || ""); setEdPass(""); setEditMsg("");
  }
  async function saveCoachEdit(c) {
    setEditMsg("");
    if (edPass && edPass.length < 8) { setEditMsg(t("Wachtwoord min. 8 tekens.", "Password min. 8 chars.")); return; }
    try {
      const payload = { action: "editcoach", authToken: await freshToken(), member_id: c.id, display_name: edName.trim() };
      if (edPass) payload.password = edPass;
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(payload) });
      if (r.ok) { setCoaches((xs) => xs.map((x) => x.id === c.id ? { ...x, display_name: edName.trim() } : x)); setEditMsg(t("Opgeslagen.", "Saved.")); setEdPass(""); }
      else setEditMsg(t("Opslaan mislukt.", "Save failed."));
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
  async function addClass() {
    const name = cName.trim();
    if (!name || !cTime || cBusy) return;
    setCBusy(true);
    try {
      const row = { org_id: org && org.id, name, day_of_week: parseInt(cDay, 10), start_time: cTime, duration_min: cDur ? parseInt(cDur, 10) : null, capacity: cCap ? parseInt(cCap, 10) : null, created_by: session && session.user && session.user.id };
      const { error } = await supabase.from("org_classes").insert(row);
      if (!error) { setCName(""); setCTime(""); setCDur(""); setCCap(""); loadClasses(); }
      setCBusy(false);
    } catch (e) { setCBusy(false); }
  }
  async function delClass(id) {
    if (!supabase) return;
    try { await supabase.from("org_classes").delete().eq("id", id); loadClasses(); } catch (e) {}
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

      {myTabs.length > 1 && (
        <div style={{ borderBottom: `1px solid ${LINE}`, background: INK, display: "flex", gap: 4, overflowX: "auto", padding: "8px 12px", WebkitOverflowScrolling: "touch" }}>
          {myTabs.map((m) => (
            <div key={m} onClick={() => setActive(m)} style={{ cursor: "pointer", whiteSpace: "nowrap", fontSize: 13, ...disp, fontWeight: 700, letterSpacing: 0.3, padding: "8px 13px", borderRadius: 8, background: current === m ? color : "transparent", color: current === m ? "#fff" : MUTED }}>{LABEL[m] || m}</div>
          ))}
        </div>
      )}

      <div style={{ maxWidth: 680, margin: "0 auto", padding: "20px 16px", display: "grid", gap: 16 }}>
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
            <div style={{ display: "inline-flex", border: `1px solid ${LINE}`, borderRadius: 8, overflow: "hidden" }}>
              {["basis", "pro"].map((tr) => (
                <div key={tr} onClick={() => setNewTier(tr)} style={{ cursor: "pointer", padding: "10px 13px", fontSize: 12.5, ...disp, fontWeight: 700, letterSpacing: 0.3, textTransform: "capitalize", background: newTier === tr ? color : "transparent", color: newTier === tr ? "#fff" : MUTED }}>{tr}</div>
              ))}
            </div>
            <div onClick={addMember} style={{ cursor: busy ? "default" : "pointer", opacity: busy ? 0.7 : 1, background: color, color: "#fff", padding: "11px 18px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13.5, letterSpacing: 0.3, whiteSpace: "nowrap" }}>{t("Aanmaken", "Create")}</div>
          </div>
          <div style={{ fontSize: 11, color: MUTED, marginTop: 7, lineHeight: 1.5 }}>{t("basis = voeding + rooster · pro = ook persoonlijke PT", "basis = nutrition + schedule · pro = also personal PT")}</div>
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
                const pro = (m.member_tier || "pro") === "pro";
                return (
                  <div key={m.id} style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 10, overflow: "hidden" }}>
                    <div style={{ display: "flex", alignItems: "center", gap: 10, padding: "11px 12px" }}>
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
                    <div style={{ display: "flex", alignItems: "center", gap: 8, padding: "0 12px 11px", flexWrap: "wrap" }}>
                      {plans && plans.length > 0 && (
                        <select value={m.plan_id || ""} onChange={(e) => assignPlan(m, e.target.value)} style={{ ...input, width: "auto", appearance: "auto", padding: "6px 9px", fontSize: 12.5 }}>
                          <option value="">{t("Geen abo", "No plan")}</option>
                          {plans.map((p) => <option key={p.id} value={p.id}>{p.name}</option>)}
                        </select>
                      )}
                      {!m.plan_id && (
                        <div onClick={() => toggleTier(m)} title={t("Tier wisselen", "Switch tier")} style={{ cursor: "pointer", fontSize: 10.5, ...disp, fontWeight: 700, letterSpacing: 0.6, textTransform: "uppercase", padding: "4px 9px", borderRadius: 6, background: pro ? color : "transparent", color: pro ? "#fff" : MUTED, border: `1px solid ${pro ? color : LINE}` }}>{m.member_tier || "pro"}</div>
                      )}
                      {!m.plan_id && classes && classes.length > 0 && (
                        <div onClick={() => openMemberClasses(m)} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "5px 9px" }}>
                          {t("Lessen", "Classes")} ({m.class_access == null ? t("alle", "all") : m.class_access.length})
                        </div>
                      )}
                      <div onClick={() => openMemberNote(m)} style={{ cursor: "pointer", fontSize: 11.5, color: m.coach_note ? color : MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "5px 9px" }}>{t("Notitie", "Note")}{m.coach_note ? " •" : ""}</div>
                      <div onClick={() => openMemberFormula(m)} style={{ cursor: "pointer", fontSize: 11.5, color: m.calc_override ? color : MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "5px 9px" }}>{t("Formule", "Formula")}{m.calc_override ? " •" : ""}</div>
                      <div style={{ flex: 1 }} />
                      <div onClick={() => deleteMember(m)} title={t("Lid verwijderen", "Delete member")} style={{ cursor: "pointer", fontSize: 11.5, color: EMBER_SOFT, border: `1px solid ${LINE}`, borderRadius: 7, padding: "5px 9px" }}>{t("Verwijderen", "Delete")}</div>
                    </div>
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
          )}
        </div>

        </>)}

        {current === "classes" && (<>
        {/* Groepsrooster (lessen) */}
        <div style={card}>
          <div style={{ ...sectionTitle, color, marginBottom: 10 }}>{t("Lesrooster", "Class schedule")}</div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap", alignItems: "center" }}>
            <input style={{ ...input, flex: 1, minWidth: 140 }} value={cName} onChange={(e) => setCName(e.target.value)} placeholder={t("Les (bv. HYROX, HIIT)", "Class (e.g. HYROX, HIIT)")} />
            <select style={{ ...input, width: "auto", appearance: "auto" }} value={cDay} onChange={(e) => setCDay(e.target.value)}>
              {[1, 2, 3, 4, 5, 6, 0].map((d) => <option key={d} value={d}>{(lang === "nl" ? ["zondag", "maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag"] : ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])[d]}</option>)}
            </select>
            <input style={{ ...input, width: 110 }} type="time" value={cTime} onChange={(e) => setCTime(e.target.value)} />
            <input style={{ ...input, width: 70 }} type="number" value={cDur} onChange={(e) => setCDur(e.target.value)} placeholder={t("min", "min")} />
            <input style={{ ...input, width: 80 }} type="number" value={cCap} onChange={(e) => setCCap(e.target.value)} placeholder={t("max pers", "max")} />
            <div onClick={addClass} style={{ cursor: cBusy ? "default" : "pointer", opacity: cBusy ? 0.7 : 1, background: color, color: "#fff", padding: "11px 16px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.3, whiteSpace: "nowrap" }}>{t("Toevoegen", "Add")}</div>
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
              <div style={{ display: "flex", gap: 7, flexWrap: "wrap" }}>
                {(classes || []).length === 0 ? <div style={{ fontSize: 12, color: MUTED }}>{t("Voeg eerst lessen toe (tab Lessen).", "Add classes first (Classes tab).")}</div>
                  : (classes || []).map((cl) => (
                    <div key={cl.id} onClick={() => togglePermIn(pClassIds, setPClassIds, cl.id)} style={{ cursor: "pointer", fontSize: 12, ...disp, fontWeight: 700, padding: "6px 11px", borderRadius: 7, border: `1px solid ${pClassIds.includes(cl.id) ? color : LINE}`, background: pClassIds.includes(cl.id) ? color : "transparent", color: pClassIds.includes(cl.id) ? "#fff" : MUTED }}>{cl.name}</div>
                  ))}
              </div>
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
              <div style={{ display: "flex", gap: 7, flexWrap: "wrap" }}>
                {MODS.map((m) => (
                  <div key={m} onClick={() => togglePermIn(ncPerms, setNcPerms, m)} style={{ cursor: "pointer", fontSize: 12, ...disp, fontWeight: 700, padding: "6px 11px", borderRadius: 7, border: `1px solid ${ncPerms.includes(m) ? color : LINE}`, background: ncPerms.includes(m) ? color : "transparent", color: ncPerms.includes(m) ? "#fff" : MUTED }}>{LABEL[m] || m}</div>
                ))}
              </div>
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
                  <div key={c.id} style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 10, overflow: "hidden" }}>
                    <div style={{ display: "flex", alignItems: "center", gap: 10, padding: "11px 12px" }}>
                      <div style={{ flex: 1, minWidth: 0 }}>
                        <div style={{ ...disp, fontWeight: 700, fontSize: 14.5 }}>{c.display_name || t("Coach", "Coach")}</div>
                        <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{c.is_owner ? t("Eigenaar · alle rechten", "Owner · all access") : (Array.isArray(c.perms) && c.perms.length ? c.perms.map((p) => LABEL[p] || p).join(", ") : t("geen rechten", "no access"))}</div>
                      </div>
                      {!c.is_owner && <div onClick={() => openCoachEdit(c)} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "5px 9px" }}>{t("Bewerk", "Edit")}</div>}
                      {!c.is_owner && <div onClick={() => openCoachPerms(c)} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 7, padding: "5px 9px" }}>{t("Rechten", "Perms")}</div>}
                      {!c.is_owner && <div onClick={() => removeCoach(c)} style={{ cursor: "pointer", fontSize: 11.5, color: EMBER_SOFT, border: `1px solid ${LINE}`, borderRadius: 7, padding: "5px 9px" }}>{t("Verwijderen", "Delete")}</div>}
                    </div>
                    {openEdit === c.id && (
                      <div style={{ padding: "0 12px 12px", display: "grid", gap: 8 }}>
                        <input style={input} value={edName} onChange={(e) => setEdName(e.target.value)} placeholder={t("Naam", "Name")} />
                        <input style={input} type="text" value={edPass} onChange={(e) => setEdPass(e.target.value)} placeholder={t("Nieuw wachtwoord (leeg = niet wijzigen)", "New password (empty = keep)")} />
                        <div onClick={() => saveCoachEdit(c)} style={{ cursor: "pointer", background: color, color: "#fff", padding: "8px 0", borderRadius: 7, textAlign: "center", ...disp, fontWeight: 700, fontSize: 12.5 }}>{t("Opslaan", "Save")}</div>
                        {editMsg && <div style={{ fontSize: 11.5, color: SAGE }}>{editMsg}</div>}
                      </div>
                    )}
                    {openPerms === c.id && (
                      <div style={{ padding: "0 12px 12px" }}>
                        <div style={{ display: "flex", gap: 7, flexWrap: "wrap", marginBottom: 8 }}>
                          {MODS.map((m) => (
                            <div key={m} onClick={() => togglePermIn(permSel, setPermSel, m)} style={{ cursor: "pointer", fontSize: 12, ...disp, fontWeight: 700, padding: "6px 11px", borderRadius: 7, border: `1px solid ${permSel.includes(m) ? color : LINE}`, background: permSel.includes(m) ? color : "transparent", color: permSel.includes(m) ? "#fff" : MUTED }}>{LABEL[m] || m}</div>
                          ))}
                        </div>
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
  );
}
