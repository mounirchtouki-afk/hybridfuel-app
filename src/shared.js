// Gedeelde huisstijl-tokens, stijlhelpers en kleine utils.
// Eén bron van waarheid zodat App én de losse views er identiek uitzien.

export const INK = "#0A0A0A", INK2 = "#161616", EMBER = "#E11D48", EMBER_SOFT = "#FB7185",
  PAPER = "#F4F4F4", MUTED = "#8C8C8C", LINE = "#242424", SAGE = "#B5B5B5";

export const disp = { fontFamily: "Oswald, sans-serif" };
export const num = (v, d = 0) => { const n = parseFloat(v); return isNaN(n) ? d : n; };

export const WD = {
  nl: ["Ma", "Di", "Wo", "Do", "Vr", "Za", "Zo"],
  en: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
};
// JS getDay(): 0=zo..6=za  ->  onze index 0=ma..6=zo
export const jsDayToIdx = (d) => (d === 0 ? 6 : d - 1);

export const label = { fontFamily: "Inter, sans-serif", fontSize: 11, letterSpacing: 1, textTransform: "uppercase", color: MUTED, marginBottom: 6, display: "block", fontWeight: 600 };
export const input = { width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "11px 12px", fontFamily: "Inter, sans-serif", fontSize: 14, borderRadius: 8, outline: "none", boxSizing: "border-box" };
export const card = { background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16 };
export const sectionTitle = { ...disp, fontSize: 15, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, color: EMBER };

export const chipS = (on) => ({ padding: "7px 12px", borderRadius: 20, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.14)" : "transparent", fontSize: 12.5, fontWeight: 600, cursor: "pointer", color: on ? PAPER : MUTED });
export const segS = (on) => ({ flex: 1, textAlign: "center", padding: "9px 4px", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.12)" : "transparent", fontSize: 12, fontWeight: 600, cursor: "pointer", color: on ? PAPER : MUTED });
export const primaryBtn = { width: "100%", background: EMBER, color: PAPER, border: "none", padding: "13px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 1, textTransform: "uppercase", cursor: "pointer" };
export const ghostBtn = { background: "transparent", color: EMBER, border: `1px solid ${EMBER}`, padding: "11px 18px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.3, cursor: "pointer" };

// localStorage helpers (nooit crashen)
export const load = (k, d) => { try { const v = JSON.parse(localStorage.getItem(k)); return v == null ? d : v; } catch (e) { return d; } };
export const save = (k, v) => { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} };

export const todayISO = () => { const d = new Date(); return d.getFullYear() + "-" + String(d.getMonth() + 1).padStart(2, "0") + "-" + String(d.getDate()).padStart(2, "0"); };
export const fmtDate = (iso, lang) => {
  try { const [y, m, d] = iso.split("-").map(Number); return new Date(y, m - 1, d).toLocaleDateString(lang === "nl" ? "nl-NL" : "en-GB", { day: "numeric", month: "short" }); }
  catch (e) { return iso; }
};
