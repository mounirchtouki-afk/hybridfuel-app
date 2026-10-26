import React, { useState, useRef } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, disp, num, input, label, sectionTitle, primaryBtn, ghostBtn, load, save, genSteps, macroLetters, gShow, gStore, wUnit } from "../shared.js";
import { supabase } from "../supabaseClient.js";
import Products from "./Products.jsx";

const T = {
  title: { nl: "Recept maken", en: "Create recipe" },
  name: { nl: "Naam van het recept", en: "Recipe name" },
  namePh: { nl: "bijv. Kip-rijst bowl", en: "e.g. chicken rice bowl" },
  type: { nl: "Soort", en: "Type" },
  breakfast: { nl: "Ontbijt", en: "Breakfast" },
  lunch: { nl: "Lunch", en: "Lunch" },
  dinner: { nl: "Diner", en: "Dinner" },
  snack: { nl: "Snack", en: "Snack" },
  photo: { nl: "Foto", en: "Photo" },
  addPhoto: { nl: "Foto maken / uploaden", en: "Take / upload photo" },
  changePhoto: { nl: "Foto wijzigen", en: "Change photo" },
  ingredients: { nl: "Ingrediënten", en: "Ingredients" },
  addIngr: { nl: "+ Ingrediënt (scan / product)", en: "+ Ingredient (scan / product)" },
  noIngr: { nl: "Voeg ingrediënten toe — de voedingswaarde wordt automatisch berekend.", en: "Add ingredients — nutrition is calculated automatically." },
  steps: { nl: "Bereidingswijze", en: "Preparation" },
  stepsPh: { nl: "Beschrijf de stappen…", en: "Describe the steps…" },
  genSteps: { nl: "⚡ Genereer uit ingrediënten", en: "⚡ Generate from ingredients" },
  total: { nl: "Totaal", en: "Total" },
  saveBtn: { nl: "Recept opslaan", en: "Save recipe" },
  cancel: { nl: "Annuleren", en: "Cancel" },
  g: { nl: "g", en: "g" },
};

export default function RecipeBuilder({ lang, session, units, onClose, onSaved }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const ml = macroLetters(lang);
  const cloud = !!(session && supabase);
  const [name, setName] = useState("");
  const [type, setType] = useState("dinner");
  const [steps, setSteps] = useState("");
  const [photo, setPhoto] = useState("");
  const [ings, setIngs] = useState([]);
  const [showPick, setShowPick] = useState(false);
  const [busy, setBusy] = useState(false);
  const fileRef = useRef(null);

  function handlePhoto(file) {
    if (!file) return;
    const reader = new FileReader();
    reader.onload = (e) => {
      const img = new Image();
      img.onload = () => {
        const max = 720; let w = img.width, h = img.height;
        if (w > h && w > max) { h = Math.round(h * max / w); w = max; }
        else if (h > max) { w = Math.round(w * max / h); h = max; }
        try {
          const c = document.createElement("canvas"); c.width = w; c.height = h;
          c.getContext("2d").drawImage(img, 0, 0, w, h);
          setPhoto(c.toDataURL("image/jpeg", 0.7));
        } catch (err) { setPhoto(e.target.result); }
      };
      img.src = e.target.result;
    };
    reader.readAsDataURL(file);
  }

  function addFromProduct(p) {
    const g = 100, p1 = p.per_100 || {};
    const calc = (k) => Math.round(num(p1[k]) * g / 100);
    setIngs((a) => [...a, { name: p.name, grams: g, per100: p1, kcal: calc("kcal"), p: calc("p"), c: calc("c"), f: calc("f") }]);
    setShowPick(false);
  }
  function setGrams(i, g) {
    setIngs((a) => a.map((x, j) => {
      if (j !== i) return x;
      const p1 = x.per100; if (!p1) return { ...x, grams: g };
      const calc = (k) => Math.round(num(p1[k]) * num(g) / 100);
      return { ...x, grams: g, kcal: calc("kcal"), p: calc("p"), c: calc("c"), f: calc("f") };
    }));
  }
  function delIng(i) { setIngs((a) => a.filter((_, j) => j !== i)); }

  const macros = ings.reduce((a, x) => ({ kcal: a.kcal + num(x.kcal), p: a.p + num(x.p), c: a.c + num(x.c), f: a.f + num(x.f) }), { kcal: 0, p: 0, c: 0, f: 0 });

  async function doSave() {
    if (!name.trim() || !ings.length) return;
    setBusy(true);
    const ingredients = ings.map((x) => ({ name: x.name, grams: num(x.grams), kcal: num(x.kcal), p: num(x.p), c: num(x.c), f: num(x.f) }));
    const rec = { name: name.trim(), type, ingredients, macros, image_url: photo || null, steps: steps.trim() || null };
    try {
      if (cloud) {
        const { data } = await supabase.from("recipes").insert({ user_id: session.user.id, ...rec, is_system: false }).select("id,name,type,ingredients,macros,image_url,steps").single();
        if (data) onSaved && onSaved(data);
      } else {
        const row = { id: "l" + Date.now(), ...rec };
        const all = load("hf_recipes", []); const next = [...all, row]; save("hf_recipes", next);
        onSaved && onSaved(row);
      }
      onClose();
    } catch (e) { setBusy(false); }
  }

  return (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 66, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ position: "relative", background: INK, border: `1px solid ${LINE}`, borderRadius: 20, width: "100%", maxWidth: 440, maxHeight: "90vh", overflowY: "auto", padding: 22, boxShadow: "0 24px 70px rgba(0,0,0,.65)", backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.13), transparent 58%)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 16 }}>
          <div style={sectionTitle}>{t("title")}</div>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>

        {/* Foto */}
        <div style={{ marginBottom: 14 }}>
          <input ref={fileRef} type="file" accept="image/*" capture="environment" style={{ display: "none" }} onChange={(e) => handlePhoto(e.target.files && e.target.files[0])} />
          {photo ? (
            <div style={{ position: "relative", borderRadius: 12, overflow: "hidden" }}>
              <img src={photo} alt="" style={{ width: "100%", aspectRatio: "16/9", objectFit: "cover", display: "block" }} />
              <div onClick={() => fileRef.current && fileRef.current.click()} style={{ position: "absolute", right: 10, bottom: 10, cursor: "pointer", background: "rgba(10,10,10,0.75)", border: `1px solid ${LINE}`, borderRadius: 8, padding: "6px 12px", fontSize: 12, fontWeight: 600, color: PAPER }}>{t("changePhoto")}</div>
            </div>
          ) : (
            <div onClick={() => fileRef.current && fileRef.current.click()} style={{ cursor: "pointer", border: `1px dashed ${LINE}`, borderRadius: 12, padding: "22px 0", textAlign: "center", color: EMBER, fontSize: 13, fontWeight: 600 }}>{t("addPhoto")}</div>
          )}
        </div>

        <div style={{ marginBottom: 12 }}>
          <label style={label}>{t("name")}</label>
          <input value={name} onChange={(e) => setName(e.target.value)} placeholder={t("namePh")} style={input} />
        </div>

        <label style={label}>{t("type")}</label>
        <div style={{ display: "flex", gap: 6, marginBottom: 14, flexWrap: "wrap" }}>
          {["breakfast", "lunch", "dinner", "snack"].map((ty) => (
            <div key={ty} onClick={() => setType(ty)} style={{ padding: "7px 13px", borderRadius: 8, border: `1px solid ${type === ty ? EMBER : LINE}`, background: type === ty ? "rgba(225,29,72,0.14)" : "transparent", color: type === ty ? PAPER : MUTED, fontSize: 12.5, fontWeight: 600, cursor: "pointer" }}>{t(ty)}</div>
          ))}
        </div>

        {/* Ingrediënten */}
        <div style={{ ...label, marginBottom: 8 }}>{t("ingredients")}</div>
        {!ings.length && <div style={{ fontSize: 12, color: MUTED, lineHeight: 1.5, marginBottom: 10 }}>{t("noIngr")}</div>}
        {ings.map((x, i) => (
          <div key={i} style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 8 }}>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ fontSize: 13, fontWeight: 600, color: PAPER }}>{x.name}</div>
              <div style={{ fontSize: 10.5, color: MUTED }}>{x.kcal} kcal · {x.p}{ml.p}/{x.c}{ml.c}/{x.f}{ml.f}</div>
            </div>
            <input value={gShow(x.grams, units)} onChange={(e) => setGrams(i, gStore(e.target.value, units))} inputMode="numeric" style={{ width: 56, textAlign: "right", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "6px 7px", borderRadius: 7, fontSize: 12.5, outline: "none" }} />
            <span style={{ fontSize: 11, color: MUTED }}>{wUnit(units)}</span>
            <div onClick={() => delIng(i)} style={{ cursor: "pointer", color: MUTED, fontSize: 15, padding: "0 2px" }}>×</div>
          </div>
        ))}
        <div onClick={() => setShowPick(true)} style={{ cursor: "pointer", fontSize: 12.5, color: EMBER, fontWeight: 700, margin: "4px 0 14px" }}>{t("addIngr")}</div>

        {ings.length > 0 && (
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: "10px 12px", marginBottom: 14 }}>
            <span style={{ fontSize: 11, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 600 }}>{t("total")}</span>
            <span style={{ ...disp, fontSize: 14, fontWeight: 700, color: PAPER }}>{macros.kcal} kcal · {macros.p}{ml.p}/{macros.c}{ml.c}/{macros.f}{ml.f}</span>
          </div>
        )}

        {/* Bereidingswijze */}
        <div style={{ marginBottom: 16 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
            <label style={label}>{t("steps")}</label>
            {ings.length > 0 && <span onClick={() => setSteps(genSteps(ings.map((x) => ({ name: x.name, g: x.grams })), lang))} style={{ cursor: "pointer", fontSize: 11.5, color: EMBER, fontWeight: 700, marginBottom: 6 }}>{t("genSteps")}</span>}
          </div>
          <textarea value={steps} onChange={(e) => setSteps(e.target.value)} placeholder={t("stepsPh")} rows={5} style={{ ...input, resize: "vertical", lineHeight: 1.5 }} />
        </div>

        <div style={{ display: "flex", gap: 8 }}>
          <button onClick={doSave} disabled={busy || !name.trim() || !ings.length} style={{ ...primaryBtn, flex: 1, opacity: (busy || !name.trim() || !ings.length) ? 0.6 : 1 }}>{t("saveBtn")}</button>
          <button onClick={onClose} style={{ ...ghostBtn }}>{t("cancel")}</button>
        </div>
      </div>

      {showPick && <Products lang={lang} session={session} onClose={() => setShowPick(false)} onPick={addFromProduct} />}
    </div>
  );
}
