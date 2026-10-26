import React, { useState } from "react";
import { INK, INK2, EMBER, PAPER, MUTED, LINE, disp } from "./shared.js";

// Inline-uitklappende dropdowns (geen overlay → klikt niet weg op mobiel en knipt niet).
const trigger = (open) => ({ display: "flex", justifyContent: "space-between", alignItems: "center", background: INK, border: `1px solid ${open ? EMBER : LINE}`, borderRadius: 9, padding: "11px 13px", cursor: "pointer", boxSizing: "border-box" });
const panel = { background: INK2, border: `1px solid ${LINE}`, borderTop: "none", borderRadius: "0 0 9px 9px", marginTop: -2, overflow: "hidden" };
const rowS = (on) => ({ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "11px 13px", cursor: "pointer", borderTop: `1px solid ${LINE}`, background: on ? "rgba(225,29,72,0.10)" : "transparent", fontSize: 14, color: PAPER, fontWeight: on ? 600 : 500 });

export function Dropdown({ value, onChange, options, placeholder }) {
  const [open, setOpen] = useState(false);
  const sel = options.find((o) => o.id === value);
  return (
    <div>
      <div onClick={() => setOpen(!open)} style={trigger(open)}>
        <span style={{ color: sel ? PAPER : MUTED, fontSize: 14, fontWeight: 600 }}>{sel ? sel.label : (placeholder || "Kies…")}</span>
        <span style={{ color: EMBER, fontSize: 11, transition: "transform .15s", transform: open ? "rotate(180deg)" : "none" }}>▼</span>
      </div>
      {open && (
        <div style={panel}>
          {options.map((o) => (
            <div key={o.id} onClick={() => { onChange(o.id); setOpen(false); }} style={rowS(o.id === value)}>
              <span>{o.label}</span>{o.id === value && <span style={{ color: EMBER, fontWeight: 800 }}>✓</span>}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

export function MultiDropdown({ values, onChange, options, placeholder }) {
  const [open, setOpen] = useState(false);
  const toggle = (id) => onChange(values.includes(id) ? values.filter((x) => x !== id) : [...values, id]);
  const txt = values.length ? options.filter((o) => values.includes(o.id)).map((o) => o.label).join(", ") : (placeholder || "Kies…");
  return (
    <div>
      <div onClick={() => setOpen(!open)} style={trigger(open)}>
        <span style={{ color: values.length ? PAPER : MUTED, fontSize: 14, fontWeight: 600, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap", marginRight: 8 }}>{txt}</span>
        <span style={{ color: EMBER, fontSize: 11, flexShrink: 0, transition: "transform .15s", transform: open ? "rotate(180deg)" : "none" }}>▼</span>
      </div>
      {open && (
        <div style={panel}>
          {options.map((o) => {
            const on = values.includes(o.id);
            return (
              <div key={o.id} onClick={() => toggle(o.id)} style={rowS(on)}>
                <span>{o.label}</span>
                <span style={{ width: 19, height: 19, borderRadius: 5, border: `2px solid ${on ? EMBER : MUTED}`, background: on ? EMBER : "transparent", display: "flex", alignItems: "center", justifyContent: "center", color: INK, fontSize: 12, fontWeight: 800, flexShrink: 0 }}>{on ? "✓" : ""}</span>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
