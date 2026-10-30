import React, { useState } from "react";
import { EMBER, PAPER } from "../shared.js";

// Eigen kalender in huiskleur (rood), witte body — vervangt de groene
// Android-systeemkiezer. Maandrooster, maandag-eerst. Tik op een dag = kiezen.
// Props: value (ISO "YYYY-MM-DD" of ""), onPick(iso), onClose, lang, allowClear.

const MONTHS = {
  nl: ["Januari", "Februari", "Maart", "April", "Mei", "Juni", "Juli", "Augustus", "September", "Oktober", "November", "December"],
  en: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
};
const WDS = { nl: ["M", "D", "W", "D", "V", "Z", "Z"], en: ["M", "T", "W", "T", "F", "S", "S"] };
const WDLONG = { nl: ["Zo", "Ma", "Di", "Wo", "Do", "Vr", "Za"], en: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"] };
const BTN = {
  clear: { nl: "WISSEN", en: "CLEAR" },
  cancel: { nl: "ANNULEREN", en: "CANCEL" },
  today: { nl: "VANDAAG", en: "TODAY" },
};

function iso(y, m, d) {
  return y + "-" + String(m + 1).padStart(2, "0") + "-" + String(d).padStart(2, "0");
}
function todayISO() {
  const n = new Date();
  return iso(n.getFullYear(), n.getMonth(), n.getDate());
}

export default function BrandCalendar({ value, onPick, onClose, lang = "nl", allowClear = false }) {
  const L = lang === "nl" ? "nl" : "en";
  const t = (k) => (BTN[k] ? BTN[k][L] : k);
  const base = value && /^\d{4}-\d{2}-\d{2}$/.test(value) ? value : todayISO();
  const bd = new Date(base + "T12:00:00");
  const [view, setView] = useState({ y: bd.getFullYear(), m: bd.getMonth() });

  const selIso = value && /^\d{4}-\d{2}-\d{2}$/.test(value) ? value : "";
  const tIso = todayISO();

  // Eerste dag van de maand, maandag-eerst (ma=0 ... zo=6).
  const first = new Date(view.y, view.m, 1);
  const startPad = (first.getDay() + 6) % 7;
  const daysInMonth = new Date(view.y, view.m + 1, 0).getDate();
  const cells = [];
  for (let i = 0; i < startPad; i++) cells.push(null);
  for (let d = 1; d <= daysInMonth; d++) cells.push(d);
  while (cells.length % 7 !== 0) cells.push(null);

  const headDate = selIso ? new Date(selIso + "T12:00:00") : bd;
  const headLbl = WDLONG[L][headDate.getDay()] + " " + headDate.getDate() + " " + MONTHS[L][headDate.getMonth()].slice(0, 3).toLowerCase();

  const shiftMonth = (n) => setView((v) => { const d = new Date(v.y, v.m + n, 1); return { y: d.getFullYear(), m: d.getMonth() }; });
  const pickIso = (c) => { onPick(c); onClose && onClose(); };
  const pick = (d) => pickIso(iso(view.y, view.m, d));

  const navBtn = { cursor: "pointer", width: 36, height: 36, borderRadius: "50%", display: "flex", alignItems: "center", justifyContent: "center", color: "#444", fontSize: 20, userSelect: "none" };

  return (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.6)", zIndex: 200, display: "flex", alignItems: "center", justifyContent: "center", padding: 20 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ width: "100%", maxWidth: 360, background: "#fff", borderRadius: 18, overflow: "hidden", boxShadow: "0 20px 60px rgba(0,0,0,0.5)" }}>
        {/* Rode koptekst */}
        <div style={{ background: EMBER, color: PAPER, padding: "18px 22px" }}>
          <div style={{ fontSize: 14, opacity: 0.85, fontWeight: 600 }}>{headDate.getFullYear()}</div>
          <div style={{ ...disp(), fontSize: 30, fontWeight: 700, marginTop: 2 }}>{headLbl}</div>
        </div>
        {/* Maandnavigatie */}
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "10px 14px" }}>
          <div onClick={() => shiftMonth(-1)} style={navBtn}>‹</div>
          <div style={{ fontSize: 15, fontWeight: 600, color: "#222" }}>{MONTHS[L][view.m]} {view.y}</div>
          <div onClick={() => shiftMonth(1)} style={navBtn}>›</div>
        </div>
        {/* Weekdagen */}
        <div style={{ display: "grid", gridTemplateColumns: "repeat(7,1fr)", padding: "0 10px" }}>
          {WDS[L].map((w, i) => <div key={i} style={{ textAlign: "center", fontSize: 12, color: "#999", padding: "4px 0" }}>{w}</div>)}
        </div>
        {/* Dagen */}
        <div style={{ display: "grid", gridTemplateColumns: "repeat(7,1fr)", padding: "2px 10px 10px" }}>
          {cells.map((d, i) => {
            if (!d) return <div key={i} />;
            const cur = iso(view.y, view.m, d);
            const isSel = cur === selIso;
            const isTod = cur === tIso;
            return (
              <div key={i} onClick={() => pick(d)} style={{ display: "flex", alignItems: "center", justifyContent: "center", padding: "3px 0", cursor: "pointer" }}>
                <div style={{ width: 38, height: 38, borderRadius: "50%", display: "flex", alignItems: "center", justifyContent: "center", fontSize: 15, fontWeight: isSel || isTod ? 700 : 500, background: isSel ? EMBER : "transparent", color: isSel ? "#fff" : "#222", border: !isSel && isTod ? `2px solid ${EMBER}` : "2px solid transparent" }}>{d}</div>
              </div>
            );
          })}
        </div>
        {/* Acties */}
        <div style={{ display: "flex", justifyContent: "flex-end", gap: 6, padding: "6px 14px 16px" }}>
          {allowClear && <div onClick={() => { onPick(""); onClose && onClose(); }} style={{ cursor: "pointer", color: EMBER, fontWeight: 700, fontSize: 14, padding: "8px 14px", letterSpacing: 0.5 }}>{t("clear")}</div>}
          <div onClick={() => pickIso(tIso)} style={{ cursor: "pointer", color: EMBER, fontWeight: 700, fontSize: 14, padding: "8px 14px", letterSpacing: 0.5 }}>{t("today")}</div>
          <div onClick={onClose} style={{ cursor: "pointer", color: "#666", fontWeight: 700, fontSize: 14, padding: "8px 14px", letterSpacing: 0.5 }}>{t("cancel")}</div>
        </div>
      </div>
    </div>
  );
}

function disp() { return { fontFamily: "Archivo, Inter, sans-serif" }; }
