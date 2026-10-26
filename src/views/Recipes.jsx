import React, { useState, useEffect } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, sectionTitle, chipS, primaryBtn, load, save, macroLetters } from "../shared.js";
import { RECIPES } from "../recipes.js";
import { supabase } from "../supabaseClient.js";
import RecipeBuilder from "./RecipeBuilder.jsx";

const T = {
  title: { nl: "Recepten", en: "Recipes" },
  sub: { nl: "Kok-gemaakt en doorgerekend. Maak ook je eigen recepten aan.", en: "Chef-made and macro-counted. Create your own recipes too." },
  all: { nl: "Alles", en: "All" },
  breakfast: { nl: "Ontbijt", en: "Breakfast" },
  lunch: { nl: "Lunch", en: "Lunch" },
  dinner: { nl: "Diner", en: "Dinner" },
  snack: { nl: "Snack", en: "Snack" },
  ingredients: { nl: "Ingrediënten", en: "Ingredients" },
  steps: { nl: "Bereidingswijze", en: "Preparation" },
  mine: { nl: "Mijn recepten", en: "My recipes" },
  system: { nl: "Van ons", en: "From us" },
  create: { nl: "+ Recept maken", en: "+ Create recipe" },
};

const TYPE_ORDER = ["breakfast", "lunch", "dinner", "snack"];
const TYPE_LBL = { breakfast: T.breakfast, lunch: T.lunch, dinner: T.dinner, snack: T.snack };

export default function Recipes({ lang, session }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const cloud = !!(session && supabase);
  const [filter, setFilter] = useState("all");
  const [open, setOpen] = useState(null);
  const [mine, setMine] = useState(() => (cloud ? [] : load("hf_recipes", [])));
  const [build, setBuild] = useState(false);

  useEffect(() => {
    let active = true;
    if (cloud) {
      supabase.from("recipes").select("id,name,type,ingredients,macros,image_url,steps").eq("user_id", session.user.id).order("created_at", { ascending: false })
        .then(({ data }) => { if (active && data) setMine(data); });
    }
    return () => { active = false; };
  }, [session]);

  function delMine(id) {
    const next = mine.filter((r) => r.id !== id);
    setMine(next);
    if (cloud) { supabase.from("recipes").delete().eq("id", id).then(() => {}, () => {}); }
    else { save("hf_recipes", next); }
  }

  const sysList = RECIPES.filter((r) => filter === "all" || r.type === filter);
  const myList = mine.filter((r) => filter === "all" || r.type === filter);

  const macroBar = (m) => (
    <div style={{ display: "flex", gap: 0, borderTop: `1px solid ${LINE}` }}>
      {[[m.kcal, "kcal", EMBER], [(m.p || 0) + "g", macroLetters(lang).P, PAPER], [(m.c || 0) + "g", macroLetters(lang).C, EMBER_SOFT], [(m.f || 0) + "g", macroLetters(lang).F, SAGE]].map(([v, k, c], i) => (
        <div key={k} style={{ flex: 1, textAlign: "center", padding: "9px 4px", borderLeft: i ? `1px solid ${LINE}` : "none" }}>
          <div style={{ ...disp, fontSize: 15, fontWeight: 600, color: c }}>{v}</div>
          <div style={{ fontSize: 9, color: MUTED, letterSpacing: 1, textTransform: "uppercase" }}>{k}</div>
        </div>
      ))}
    </div>
  );

  return (
    <div style={{ display: "grid", gap: 16 }}>
      <div>
        <div style={sectionTitle}>{t("title")}</div>
        <div style={{ fontSize: 12, color: MUTED, marginTop: 5, lineHeight: 1.5 }}>{t("sub")}</div>
      </div>

      <button onClick={() => setBuild(true)} style={{ ...primaryBtn }}>{t("create")}</button>

      <div style={{ display: "flex", flexWrap: "wrap", gap: 7 }}>
        {["all", ...TYPE_ORDER].map((f) => (
          <div key={f} onClick={() => setFilter(f)} style={chipS(filter === f)}>{t(f === "all" ? "all" : f)}</div>
        ))}
      </div>

      {/* Mijn recepten */}
      {myList.length > 0 && (
        <div>
          <div style={{ ...disp, fontSize: 11.5, fontWeight: 700, letterSpacing: 1, textTransform: "uppercase", color: EMBER, marginBottom: 10 }}>{t("mine")}</div>
          <div style={{ display: "grid", gap: 14 }}>
            {myList.map((r) => {
              const isOpen = open === r.id;
              const m = r.macros || {};
              return (
                <div key={r.id} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, overflow: "hidden" }}>
                  <div onClick={() => setOpen(isOpen ? null : r.id)} style={{ cursor: "pointer" }}>
                    <div style={{ position: "relative", width: "100%", aspectRatio: "16 / 9", background: INK }}>
                      {r.image_url ? <img src={r.image_url} alt={r.name} style={{ width: "100%", height: "100%", objectFit: "cover", display: "block" }} />
                        : <div style={{ width: "100%", height: "100%", display: "flex", alignItems: "center", justifyContent: "center", color: LINE, ...disp, fontSize: 40 }}>{(r.name || "?").slice(0, 1).toUpperCase()}</div>}
                      <div style={{ position: "absolute", inset: 0, background: "linear-gradient(180deg, transparent 45%, rgba(10,10,10,0.9) 100%)" }} />
                      <div style={{ position: "absolute", left: 14, right: 14, bottom: 12 }}>
                        <div style={{ display: "inline-block", fontSize: 9.5, color: PAPER, background: EMBER, borderRadius: 5, padding: "2px 7px", letterSpacing: 0.5, fontWeight: 700, ...disp, marginBottom: 6 }}>{TYPE_LBL[r.type] ? TYPE_LBL[r.type][lang] : r.type}</div>
                        <div style={{ ...disp, fontWeight: 600, fontSize: 19, letterSpacing: 0.3, color: PAPER, textShadow: "0 2px 8px rgba(0,0,0,.6)" }}>{r.name}</div>
                      </div>
                    </div>
                    {macroBar(m)}
                  </div>
                  {isOpen && (
                    <div style={{ padding: "12px 14px 14px", borderTop: `1px solid ${LINE}` }}>
                      <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600, marginBottom: 7 }}>{t("ingredients")}</div>
                      <div style={{ display: "grid", gap: 6, marginBottom: r.steps ? 12 : 0 }}>
                        {(r.ingredients || []).map((x, i) => (
                          <div key={i} style={{ display: "flex", justifyContent: "space-between", fontSize: 13, color: PAPER }}>
                            <span>{x.name}</span><span style={{ color: MUTED }}>{Math.round(num(x.grams))}g</span>
                          </div>
                        ))}
                      </div>
                      {r.steps && (
                        <>
                          <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600, margin: "4px 0 7px" }}>{t("steps")}</div>
                          <div style={{ fontSize: 13, color: PAPER, lineHeight: 1.6, whiteSpace: "pre-wrap" }}>{r.steps}</div>
                        </>
                      )}
                      <div onClick={() => delMine(r.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 12, marginTop: 14, textAlign: "right" }}>×  verwijderen</div>
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Systeemrecepten */}
      <div>
        {myList.length > 0 && <div style={{ ...disp, fontSize: 11.5, fontWeight: 700, letterSpacing: 1, textTransform: "uppercase", color: MUTED, marginBottom: 10 }}>{t("system")}</div>}
        <div style={{ display: "grid", gap: 14 }}>
          {sysList.map((r) => {
            const isOpen = open === r.id;
            const m = r.macros;
            return (
              <div key={r.id} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, overflow: "hidden" }}>
                <div onClick={() => setOpen(isOpen ? null : r.id)} style={{ cursor: "pointer" }}>
                  <div style={{ position: "relative", width: "100%", aspectRatio: "1 / 1", background: `linear-gradient(135deg, ${INK2}, ${INK})` }}>
                    <div style={{ position: "absolute", inset: 0, display: "flex", alignItems: "center", justifyContent: "center", color: LINE, ...disp, fontSize: 52, fontWeight: 700 }}>{r.name[lang].slice(0, 1)}</div>
                    <img src={r.image_url || `/recipes/${r.id}.jpg`} alt={r.name[lang]} loading="lazy" onError={(e) => { e.currentTarget.style.display = "none"; }} style={{ position: "absolute", inset: 0, width: "100%", height: "100%", objectFit: "cover", display: "block" }} />
                    <div style={{ position: "absolute", inset: 0, background: "linear-gradient(180deg, transparent 45%, rgba(10,10,10,0.9) 100%)" }} />
                    <div style={{ position: "absolute", left: 14, right: 14, bottom: 12 }}>
                      <div style={{ display: "inline-block", fontSize: 9.5, color: PAPER, background: EMBER, borderRadius: 5, padding: "2px 7px", letterSpacing: 0.5, fontWeight: 700, ...disp, marginBottom: 6 }}>{r.goal[lang]}</div>
                      <div style={{ ...disp, fontWeight: 600, fontSize: 19, letterSpacing: 0.3, color: PAPER, textShadow: "0 2px 8px rgba(0,0,0,.6)" }}>{r.name[lang]}</div>
                    </div>
                  </div>
                  {macroBar(m)}
                </div>
                {isOpen && (
                  <div style={{ padding: "12px 14px 14px", borderTop: `1px solid ${LINE}` }}>
                    {r.desc && <div style={{ fontSize: 13, color: PAPER, lineHeight: 1.55, marginBottom: 12 }}>{r.desc[lang]}</div>}
                    <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600, marginBottom: 7 }}>{t("ingredients")}</div>
                    <div style={{ display: "grid", gap: 6 }}>
                      {r.ing.map((x, i) => (
                        <div key={i} style={{ display: "flex", justifyContent: "space-between", fontSize: 13, color: PAPER }}>
                          <span>{x[lang]}</span><span style={{ color: MUTED }}>{x.g}{typeof x.g === "number" ? "g" : ""}</span>
                        </div>
                      ))}
                    </div>
                    {r.steps && (r.steps[lang] || typeof r.steps === "string") && (
                      <>
                        <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600, margin: "12px 0 7px" }}>{t("steps")}</div>
                        <div style={{ fontSize: 13, color: PAPER, lineHeight: 1.6, whiteSpace: "pre-wrap" }}>{typeof r.steps === "string" ? r.steps : r.steps[lang]}</div>
                      </>
                    )}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      </div>

      {build && <RecipeBuilder lang={lang} session={session} onClose={() => setBuild(false)} onSaved={(r) => setMine((a) => [r, ...a])} />}
    </div>
  );
}
