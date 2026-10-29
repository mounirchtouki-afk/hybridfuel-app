import React, { useState, useEffect } from "react";
import { INK, INK2, PAPER, MUTED, LINE, disp, sectionTitle } from "../shared.js";
import { supabase } from "../supabaseClient.js";

const DAYS = {
  nl: ["Zondag", "Maandag", "Dinsdag", "Woensdag", "Donderdag", "Vrijdag", "Zaterdag"],
  en: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
};

// Leden-weergave van het groepsrooster. Toont alleen de lessen die het lid mag bezoeken
// (class_access; null = alle). Alleen tonen — geen boeking. Volgorde: ma..zo.
export default function GymClasses({ lang, color, classAccess }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const [classes, setClasses] = useState(null);
  const c = color || "#E11D48";

  useEffect(() => {
    let alive = true;
    (async () => {
      if (!supabase) { if (alive) setClasses([]); return; }
      try {
        const { data } = await supabase.from("org_classes").select("id,name,day_of_week,start_time,duration_min").order("day_of_week", { ascending: true }).order("start_time", { ascending: true });
        let rows = data || [];
        if (Array.isArray(classAccess) && classAccess.length >= 0) {
          const allow = new Set(classAccess);
          // null = alles; lege array = niets; anders filter op toegestane lessen
          if (classAccess !== null) rows = rows.filter((r) => allow.has(r.id));
        }
        if (alive) setClasses(rows);
      } catch (e) { if (alive) setClasses([]); }
    })();
    return () => { alive = false; };
  }, [classAccess]);

  if (!classes || classes.length === 0) return null;

  // Groepeer per dag, ma..zo (1..6,0)
  const order = [1, 2, 3, 4, 5, 6, 0];
  const byDay = {};
  classes.forEach((r) => { (byDay[r.day_of_week] = byDay[r.day_of_week] || []).push(r); });

  return (
    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 14, marginBottom: 14 }}>
      <div style={{ ...sectionTitle, color: c, marginBottom: 10 }}>{t("Lesrooster", "Class schedule")}</div>
      <div style={{ display: "grid", gap: 10 }}>
        {order.filter((d) => byDay[d]).map((d) => (
          <div key={d}>
            <div style={{ fontSize: 11, color: MUTED, letterSpacing: 1, textTransform: "uppercase", ...disp, fontWeight: 700, marginBottom: 5 }}>{DAYS[lang === "nl" ? "nl" : "en"][d]}</div>
            <div style={{ display: "grid", gap: 6 }}>
              {byDay[d].map((r) => (
                <div key={r.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "9px 12px", background: INK, border: `1px solid ${LINE}`, borderRadius: 10 }}>
                  <div style={{ ...disp, fontWeight: 700, fontSize: 13.5, color: c, minWidth: 48 }}>{r.start_time}</div>
                  <div style={{ flex: 1, minWidth: 0, ...disp, fontWeight: 600, fontSize: 14 }}>{r.name}</div>
                  {r.duration_min ? <div style={{ fontSize: 11.5, color: MUTED }}>{r.duration_min} min</div> : null}
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
