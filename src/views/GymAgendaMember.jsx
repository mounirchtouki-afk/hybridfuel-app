import React, { useState, useEffect } from "react";
import { INK, INK2, PAPER, MUTED, LINE, disp, sectionTitle, icsDataUrl, googleCalUrl } from "../shared.js";
import { supabase } from "../supabaseClient.js";

// Leden-weergave van de PT-agenda: toont komende sessies (groep + eigen).
// RLS filtert server-side; we tonen alleen wat het lid mag zien.
export default function GymAgendaMember({ lang, color }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const [sessions, setSessions] = useState(null);
  const c = color || "#E11D48";

  useEffect(() => {
    let alive = true;
    (async () => {
      if (!supabase) { if (alive) setSessions([]); return; }
      try {
        const { data } = await supabase.from("org_sessions")
          .select("id,title,starts_at,note,duration_min")
          .gte("starts_at", new Date(Date.now() - 36e5).toISOString())
          .order("starts_at", { ascending: true })
          .limit(6);
        if (alive) setSessions(data || []);
      } catch (e) { if (alive) setSessions([]); }
    })();
    return () => { alive = false; };
  }, []);

  if (!sessions || sessions.length === 0) return null; // niets te tonen → geen lege kaart

  const fmtWhen = (s) => { try { return new Date(s).toLocaleString(lang === "nl" ? "nl-NL" : "en-GB", { weekday: "short", day: "numeric", month: "short", hour: "2-digit", minute: "2-digit" }); } catch (e) { return s; } };

  return (
    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 14, marginBottom: 14 }}>
      <div style={{ ...sectionTitle, color: c, marginBottom: 10 }}>{t("Jouw sessies", "Your sessions")}</div>
      <div style={{ display: "grid", gap: 8 }}>
        {sessions.map((s) => (
          <div key={s.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "10px 12px", background: INK, border: `1px solid ${LINE}`, borderRadius: 10 }}>
            <div style={{ width: 8, height: 8, borderRadius: "50%", background: c, flexShrink: 0 }} />
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ ...disp, fontWeight: 700, fontSize: 14 }}>{s.title}</div>
              <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2 }}>{fmtWhen(s.starts_at)}{s.note ? " · " + s.note : ""}</div>
            </div>
            <a href={icsDataUrl({ title: s.title, startsAt: s.starts_at, durationMin: s.duration_min, note: s.note, id: s.id })} download={(s.title || "sessie").replace(/[^a-z0-9]+/gi, "-").toLowerCase() + ".ics"} style={{ textDecoration: "none", flexShrink: 0, fontSize: 11.5, color: c, border: `1px solid ${c}`, borderRadius: 7, padding: "6px 10px", ...disp, fontWeight: 700, whiteSpace: "nowrap" }}>{t("Zet in agenda", "Add to calendar")}</a>
          </div>
        ))}
      </div>
    </div>
  );
}
