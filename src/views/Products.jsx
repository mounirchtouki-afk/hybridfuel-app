import React, { useState, useEffect } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, disp, num, input, label, sectionTitle, primaryBtn, ghostBtn, load, save } from "../shared.js";
import { supabase } from "../supabaseClient.js";

const T = {
  title: { nl: "Mijn producten", en: "My products" },
  intro: { nl: "Eigen producten met voedingswaarden per 100 g. Gebruik ze als ingrediënt in je plan.", en: "Your own products with nutrition per 100 g. Use them as ingredients in your plan." },
  name: { nl: "Naam", en: "Name" },
  brand: { nl: "Merk (optioneel)", en: "Brand (optional)" },
  per100: { nl: "Per 100 g/ml", en: "Per 100 g/ml" },
  kcal: { nl: "kcal", en: "kcal" },
  prot: { nl: "Eiwit", en: "Protein" },
  carb: { nl: "Koolh.", en: "Carbs" },
  fat: { nl: "Vet", en: "Fat" },
  add: { nl: "Product toevoegen", en: "Add product" },
  empty: { nl: "Nog geen producten. Voeg je eerste toe.", en: "No products yet. Add your first." },
  close: { nl: "Sluiten", en: "Close" },
  pick: { nl: "Kies", en: "Pick" },
  namePh: { nl: "bijv. Skyr naturel", en: "e.g. plain skyr" },
};

export default function Products({ lang, session, onClose, onPick }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const cloud = !!(session && supabase);
  const [items, setItems] = useState(() => (cloud ? [] : load("hf_products", [])));
  const [nm, setNm] = useState("");
  const [br, setBr] = useState("");
  const [kc, setKc] = useState("");
  const [pr, setPr] = useState("");
  const [cb, setCb] = useState("");
  const [ft, setFt] = useState("");

  useEffect(() => {
    let active = true;
    if (cloud) {
      supabase.from("products").select("id,name,brand,per_100").eq("user_id", session.user.id).order("name")
        .then(({ data }) => { if (active && data) setItems(data); });
    }
    return () => { active = false; };
  }, [session]);

  function add() {
    const name = nm.trim();
    if (!name) return;
    const per_100 = { kcal: Math.round(num(kc)), p: Math.round(num(pr)), c: Math.round(num(cb)), f: Math.round(num(ft)) };
    if (cloud) {
      supabase.from("products").insert({ user_id: session.user.id, name, brand: br.trim() || null, per_100, unit: "g" }).select("id,name,brand,per_100").single()
        .then(({ data }) => { if (data) setItems((p) => [...p, data].sort((a, b) => a.name.localeCompare(b.name))); }, () => {});
    } else {
      const row = { id: "l" + Date.now(), name, brand: br.trim() || null, per_100 };
      const next = [...items, row].sort((a, b) => a.name.localeCompare(b.name));
      setItems(next); save("hf_products", next);
    }
    setNm(""); setBr(""); setKc(""); setPr(""); setCb(""); setFt("");
  }
  function del(id) {
    const next = items.filter((x) => x.id !== id);
    setItems(next);
    if (cloud) { supabase.from("products").delete().eq("id", id).then(() => {}, () => {}); }
    else { save("hf_products", next); }
  }

  const macroIn = (val, set, ph) => <input value={val} onChange={(e) => set(e.target.value)} inputMode="numeric" placeholder={ph} style={{ ...input, textAlign: "center", padding: "9px 4px" }} />;

  return (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 65, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ position: "relative", background: INK, border: `1px solid ${LINE}`, borderRadius: 20, width: "100%", maxWidth: 440, maxHeight: "90vh", overflowY: "auto", padding: 22, boxShadow: "0 24px 70px rgba(0,0,0,.65)", backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.13), transparent 58%)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 14 }}>
          <div style={sectionTitle}>{t("title")}</div>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>
        <div style={{ fontSize: 12, color: MUTED, lineHeight: 1.5, marginBottom: 16 }}>{t("intro")}</div>

        {/* Toevoegen */}
        <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 14, marginBottom: 16 }}>
          <div style={{ marginBottom: 10 }}>
            <label style={label}>{t("name")}</label>
            <input value={nm} onChange={(e) => setNm(e.target.value)} placeholder={t("namePh")} style={input} />
          </div>
          <div style={{ marginBottom: 10 }}>
            <label style={label}>{t("brand")}</label>
            <input value={br} onChange={(e) => setBr(e.target.value)} style={input} />
          </div>
          <label style={label}>{t("per100")}</label>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr 1fr", gap: 7, marginBottom: 12 }}>
            <div>{macroIn(kc, setKc, "kcal")}<div style={{ fontSize: 9.5, color: MUTED, textAlign: "center", marginTop: 3 }}>{t("kcal")}</div></div>
            <div>{macroIn(pr, setPr, "g")}<div style={{ fontSize: 9.5, color: MUTED, textAlign: "center", marginTop: 3 }}>{t("prot")}</div></div>
            <div>{macroIn(cb, setCb, "g")}<div style={{ fontSize: 9.5, color: MUTED, textAlign: "center", marginTop: 3 }}>{t("carb")}</div></div>
            <div>{macroIn(ft, setFt, "g")}<div style={{ fontSize: 9.5, color: MUTED, textAlign: "center", marginTop: 3 }}>{t("fat")}</div></div>
          </div>
          <button onClick={add} style={primaryBtn}>{t("add")}</button>
        </div>

        {/* Lijst */}
        {!items.length && <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.6 }}>{t("empty")}</div>}
        {items.map((it) => (
          <div key={it.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "11px 0", borderBottom: `1px solid ${LINE}` }}>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ fontSize: 13.5, fontWeight: 600, color: PAPER }}>{it.name}{it.brand ? <span style={{ color: MUTED, fontWeight: 400 }}> · {it.brand}</span> : null}</div>
              <div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{(it.per_100 && it.per_100.kcal) || 0} kcal · {(it.per_100 && it.per_100.p) || 0}p/{(it.per_100 && it.per_100.c) || 0}c/{(it.per_100 && it.per_100.f) || 0}f <span style={{ opacity: 0.6 }}>/100g</span></div>
            </div>
            {onPick && <div onClick={() => onPick(it)} style={{ cursor: "pointer", fontSize: 12, fontWeight: 700, color: EMBER, border: `1px solid ${EMBER}`, borderRadius: 7, padding: "5px 11px", ...disp, letterSpacing: 0.3 }}>{t("pick")}</div>}
            <div onClick={() => del(it.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 16, padding: "0 4px" }}>×</div>
          </div>
        ))}
      </div>
    </div>
  );
}
