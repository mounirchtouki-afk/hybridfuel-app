import React, { useState, useEffect, useCallback } from "react";
import { INK, INK2, PAPER, MUTED, LINE, disp, sectionTitle } from "../shared.js";
import { supabase } from "../supabaseClient.js";

const DAYS = {
  nl: ["Zondag", "Maandag", "Dinsdag", "Woensdag", "Donderdag", "Vrijdag", "Zaterdag"],
  en: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
};

// Eerstvolgende datum (vandaag of later) met de gegeven weekdag → "YYYY-MM-DD".
function nextOccur(dow) {
  const d = new Date(); d.setHours(0, 0, 0, 0);
  const diff = (dow - d.getDay() + 7) % 7;
  d.setDate(d.getDate() + diff);
  return d.toISOString().slice(0, 10);
}

// Leden-weergave van het groepsrooster: alleen de lessen die het lid mag bezoeken
// (class_access; null = alle), met inschrijven + capaciteit. Geen boeking-economie verder.
export default function GymClasses({ lang, color, classAccess, session }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const [classes, setClasses] = useState(null);
  const [enroll, setEnroll] = useState({});     // key `${class_id}|${date}` -> {count, mine}
  const [busy, setBusy] = useState("");
  const c = color || "#E11D48";
  const uid = session && session.user && session.user.id;

  const load = useCallback(async () => {
    if (!supabase) { setClasses([]); return; }
    try {
      const { data } = await supabase.from("org_classes").select("id,org_id,name,day_of_week,start_time,duration_min,capacity").order("day_of_week", { ascending: true }).order("start_time", { ascending: true });
      let rows = data || [];
      if (Array.isArray(classAccess)) { const allow = new Set(classAccess); rows = rows.filter((r) => allow.has(r.id)); }
      const withDate = rows.map((r) => ({ ...r, occur: nextOccur(r.day_of_week) }));
      setClasses(withDate);
      const ids = withDate.map((r) => r.id);
      if (ids.length) {
        const { data: en } = await supabase.from("class_enrollments").select("class_id,occur_date,member_user_id").in("class_id", ids);
        const map = {};
        withDate.forEach((r) => { map[r.id + "|" + r.occur] = { count: 0, mine: false }; });
        (en || []).forEach((e) => { const k = e.class_id + "|" + e.occur_date; if (!map[k]) map[k] = { count: 0, mine: false }; map[k].count += 1; if (e.member_user_id === uid) map[k].mine = true; });
        setEnroll(map);
      } else setEnroll({});
    } catch (e) { setClasses([]); }
  }, [classAccess, uid]);

  useEffect(() => { load(); }, [load]);

  async function toggleEnroll(r) {
    if (!supabase || !uid) return;
    const key = r.id + "|" + r.occur;
    const st = enroll[key] || { count: 0, mine: false };
    const full = r.capacity != null && st.count >= r.capacity;
    setBusy(key);
    try {
      if (st.mine) {
        await supabase.from("class_enrollments").delete().eq("class_id", r.id).eq("occur_date", r.occur).eq("member_user_id", uid);
      } else {
        if (full) { setBusy(""); return; }
        await supabase.from("class_enrollments").insert({ org_id: r.org_id, class_id: r.id, occur_date: r.occur, member_user_id: uid });
      }
      await load();
    } catch (e) {}
    setBusy("");
  }

  if (!classes || classes.length === 0) return null;

  const order = [1, 2, 3, 4, 5, 6, 0];
  const byDay = {};
  classes.forEach((r) => { (byDay[r.day_of_week] = byDay[r.day_of_week] || []).push(r); });
  const fmtDate = (s) => { try { return new Date(s + "T00:00:00").toLocaleDateString(lang === "nl" ? "nl-NL" : "en-GB", { day: "numeric", month: "short" }); } catch (e) { return s; } };

  return (
    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 14, marginBottom: 14 }}>
      <div style={{ ...sectionTitle, color: c, marginBottom: 10 }}>{t("Lesrooster", "Class schedule")}</div>
      <div style={{ display: "grid", gap: 10 }}>
        {order.filter((d) => byDay[d]).map((d) => (
          <div key={d}>
            <div style={{ fontSize: 11, color: MUTED, letterSpacing: 1, textTransform: "uppercase", ...disp, fontWeight: 700, marginBottom: 5 }}>{DAYS[lang === "nl" ? "nl" : "en"][d]}</div>
            <div style={{ display: "grid", gap: 6 }}>
              {byDay[d].map((r) => {
                const st = enroll[r.id + "|" + r.occur] || { count: 0, mine: false };
                const full = r.capacity != null && st.count >= r.capacity && !st.mine;
                return (
                  <div key={r.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "9px 12px", background: INK, border: `1px solid ${st.mine ? c : LINE}`, borderRadius: 10 }}>
                    <div style={{ ...disp, fontWeight: 700, fontSize: 13.5, color: c, minWidth: 48 }}>{r.start_time}</div>
                    <div style={{ flex: 1, minWidth: 0 }}>
                      <div style={{ ...disp, fontWeight: 600, fontSize: 14 }}>{r.name}</div>
                      <div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{fmtDate(r.occur)}{r.capacity != null ? " · " + st.count + "/" + r.capacity : ""}</div>
                    </div>
                    {full
                      ? <div style={{ fontSize: 11.5, color: MUTED, ...disp, fontWeight: 700, padding: "6px 11px" }}>{t("Vol", "Full")}</div>
                      : <div onClick={() => toggleEnroll(r)} style={{ cursor: busy ? "default" : "pointer", opacity: busy === r.id + "|" + r.occur ? 0.6 : 1, fontSize: 11.5, ...disp, fontWeight: 700, padding: "6px 11px", borderRadius: 7, background: st.mine ? "transparent" : c, color: st.mine ? MUTED : "#fff", border: `1px solid ${st.mine ? LINE : c}` }}>{st.mine ? t("Uitschrijven", "Leave") : t("Inschrijven", "Join")}</div>}
                  </div>
                );
              })}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
