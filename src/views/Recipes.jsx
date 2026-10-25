import React, { useState } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, sectionTitle, chipS } from "../shared.js";
import { RECIPES } from "../recipes.js";

const T = {
  title: { nl: "Recepten", en: "Recipes" },
  sub: { nl: "Kok-gemaakt en doorgerekend. Tik een recept open voor de ingrediënten.", en: "Chef-made and macro-counted. Tap a recipe for the ingredients." },
  all: { nl: "Alles", en: "All" },
  breakfast: { nl: "Ontbijt", en: "Breakfast" },
  lunch: { nl: "Lunch", en: "Lunch" },
  dinner: { nl: "Diner", en: "Dinner" },
  snack: { nl: "Snack", en: "Snack" },
  ingredients: { nl: "Ingrediënten", en: "Ingredients" },
};

const TYPE_ORDER = ["breakfast", "lunch", "dinner", "snack"];

export default function Recipes({ lang }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const [filter, setFilter] = useState("all");
  const [open, setOpen] = useState(null);

  const list = RECIPES.filter((r) => filter === "all" || r.type === filter);

  return (
    <div style={{ display: "grid", gap: 16 }}>
      <div>
        <div style={sectionTitle}>{t("title")}</div>
        <div style={{ fontSize: 12, color: MUTED, marginTop: 5, lineHeight: 1.5 }}>{t("sub")}</div>
      </div>

      <div style={{ display: "flex", flexWrap: "wrap", gap: 7 }}>
        {["all", ...TYPE_ORDER].map((f) => (
          <div key={f} onClick={() => setFilter(f)} style={chipS(filter === f)}>{t(f === "all" ? "all" : f)}</div>
        ))}
      </div>

      <div style={{ display: "grid", gap: 14 }}>
        {list.map((r) => {
          const isOpen = open === r.id;
          const m = r.macros;
          return (
            <div key={r.id} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, overflow: "hidden" }}>
              <div onClick={() => setOpen(isOpen ? null : r.id)} style={{ cursor: "pointer" }}>
                <div style={{ position: "relative", width: "100%", aspectRatio: "1 / 1", background: INK }}>
                  <img src={`/recipes/${r.id}.jpg`} alt={r.name[lang]} loading="lazy" style={{ width: "100%", height: "100%", objectFit: "cover", display: "block" }} />
                  <div style={{ position: "absolute", inset: 0, background: "linear-gradient(180deg, transparent 45%, rgba(10,10,10,0.9) 100%)" }} />
                  <div style={{ position: "absolute", left: 14, right: 14, bottom: 12 }}>
                    <div style={{ display: "inline-block", fontSize: 9.5, color: INK, background: EMBER, borderRadius: 5, padding: "2px 7px", letterSpacing: 0.5, fontWeight: 700, ...disp, marginBottom: 6 }}>{r.goal[lang]}</div>
                    <div style={{ ...disp, fontWeight: 600, fontSize: 19, letterSpacing: 0.3, color: PAPER, textShadow: "0 2px 8px rgba(0,0,0,.6)" }}>{r.name[lang]}</div>
                  </div>
                </div>
                <div style={{ display: "flex", gap: 0, borderTop: `1px solid ${LINE}` }}>
                  {[[m.kcal, "kcal", EMBER], [m.p + "g", "P", PAPER], [m.c + "g", "C", EMBER_SOFT], [m.f + "g", "F", SAGE]].map(([v, k, c], i) => (
                    <div key={k} style={{ flex: 1, textAlign: "center", padding: "9px 4px", borderLeft: i ? `1px solid ${LINE}` : "none" }}>
                      <div style={{ ...disp, fontSize: 15, fontWeight: 600, color: c }}>{v}</div>
                      <div style={{ fontSize: 9, color: MUTED, letterSpacing: 1, textTransform: "uppercase" }}>{k}</div>
                    </div>
                  ))}
                </div>
              </div>
              {isOpen && (
                <div style={{ padding: "12px 14px 14px", borderTop: `1px solid ${LINE}` }}>
                  <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600, marginBottom: 7 }}>{t("ingredients")}</div>
                  <div style={{ display: "grid", gap: 6 }}>
                    {r.ing.map((x, i) => (
                      <div key={i} style={{ display: "flex", justifyContent: "space-between", fontSize: 13, color: PAPER }}>
                        <span>{x[lang]}</span>
                        <span style={{ color: MUTED }}>{x.g}{typeof x.g === "number" ? "g" : ""}</span>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
