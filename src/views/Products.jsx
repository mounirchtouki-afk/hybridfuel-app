import React, { useState, useEffect, useRef } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, disp, num, input, label, sectionTitle, primaryBtn, ghostBtn, load, save, macroLetters } from "../shared.js";
import { supabase } from "../supabaseClient.js";

const T = {
  title: { nl: "Mijn producten", en: "My products" },
  intro: { nl: "Scan een barcode of voeg handmatig toe. Je producten worden per categorie geordend.", en: "Scan a barcode or add manually. Your products are grouped by category." },
  name: { nl: "Naam", en: "Name" },
  brand: { nl: "Merk (optioneel)", en: "Brand (optional)" },
  per100: { nl: "Per 100 g/ml", en: "Per 100 g/ml" },
  kcal: { nl: "kcal", en: "kcal" },
  prot: { nl: "Eiwit", en: "Protein" },
  carb: { nl: "Koolh.", en: "Carbs" },
  fat: { nl: "Vet", en: "Fat" },
  add: { nl: "Product toevoegen", en: "Add product" },
  empty: { nl: "Nog geen producten. Scan of voeg je eerste toe.", en: "No products yet. Scan or add your first." },
  noResult: { nl: "Geen product gevonden voor deze zoekopdracht.", en: "No product matches your search." },
  pick: { nl: "Kies", en: "Pick" },
  namePh: { nl: "bijv. Skyr naturel", en: "e.g. plain skyr" },
  scanBtn: { nl: "Scannen", en: "Scan" },
  manualBtn: { nl: "Handmatig", en: "Manual" },
  scanning: { nl: "Richt op de barcode…", en: "Point at the barcode…" },
  cancel: { nl: "Annuleren", en: "Cancel" },
  manualCode: { nl: "Of typ de barcode", en: "Or type the barcode" },
  lookup: { nl: "Zoek", en: "Look up" },
  looking: { nl: "Zoeken…", en: "Looking up…" },
  notFound: { nl: "Niet gevonden — vul de waarden zelf in.", en: "Not found — enter the values yourself." },
  found: { nl: "Gevonden! Controleer en voeg toe.", en: "Found! Check and add." },
  camErr: { nl: "Camera niet beschikbaar. Typ de barcode.", en: "Camera unavailable. Type the barcode." },
  scanErr: { nl: "Scanner kon niet laden. Typ de barcode.", en: "Scanner failed to load. Type the barcode." },
  searchPh: { nl: "Zoek in je producten…", en: "Search your products…" },
  catLabel: { nl: "Categorie", en: "Category" },
  catAuto: { nl: "Automatisch (op naam)", en: "Automatic (by name)" },
  editTitle: { nl: "Product bewerken", en: "Edit product" },
  save: { nl: "Opslaan", en: "Save" },
  editProp: { nl: "Aangepast — je plan is bijgewerkt op de gekoppelde items.", en: "Updated — your plan was refreshed on the linked items." },
};

const CATS = {
  meat: { nl: "Vlees & vis", en: "Meat & fish" },
  dairy: { nl: "Zuivel", en: "Dairy" },
  grain: { nl: "Granen & brood", en: "Grains & bread" },
  veg: { nl: "Groente & fruit", en: "Veg & fruit" },
  nuts: { nl: "Noten & zaden", en: "Nuts & seeds" },
  snack: { nl: "Snacks & repen", en: "Snacks & bars" },
  drink: { nl: "Dranken", en: "Drinks" },
  supp: { nl: "Supplementen", en: "Supplements" },
  sauce: { nl: "Sauzen & kruiden", en: "Sauces & spices" },
  other: { nl: "Overig", en: "Other" },
};
const CAT_ORDER = ["meat", "dairy", "grain", "veg", "nuts", "snack", "drink", "supp", "sauce", "other"];
function catOf(name) {
  const n = (name || "").toLowerCase();
  if (/\bbar\b|reep|repen|snack|chip|cookie|koek|chocola|candy|crisp|wafer/.test(n)) return "snack";
  if (/whey|protein|cre[a]?tine|eiwitpoeder|supplement|vitamin|collage|pre.?workout|\bgel\b|electrolyte|elektrolyt|bcaa/.test(n)) return "supp";
  if (/water|cola|juice|\bsap\b|drink|coffee|koffie|thee|\btea\b|smoothie|shake|limonade|frisdrank|fris\b/.test(n)) return "drink";
  if (/milk|yog|yoghurt|yogurt|quark|skyr|cheese|cottage|cream|butter|melk|kwark|kaas|room|boter/.test(n)) return "dairy";
  if (/chicken|beef|turkey|pork|steak|mince|\begg|tofu|tempeh|salmon|tuna|fish|shrimp|prawn|\bcod\b|\bham\b|bacon|\bkip|rund|gehakt|biefstuk|\bei\b|eieren|zalm|tonijn|\bvis\b|garnaal|worst|kalkoen/.test(n)) return "meat";
  if (/nut\b|nuts|peanut|almond|cashew|seed|zaden|noot|noten|pinda|amandel|walnoot|\bchia\b|lijnzaad/.test(n)) return "nuts";
  if (/rice|pasta|bread|\boat|potato|quinoa|couscous|noodle|tortilla|wrap|flour|cereal|cracker|rijst|brood|havermout|aardappel|noedel|meel|ontbijtgran/.test(n)) return "grain";
  if (/oil|sauce|spice|\bsalt|pepper|honey|vinegar|stock|broth|syrup|\bjam\b|herb|olie|saus|kruid|zout|peper|honing|azijn|bouillon|stroop|specerij/.test(n)) return "sauce";
  if (/apple|banana|berry|berries|spinach|broccoli|pepper|onion|garlic|tomato|carrot|courgette|zucchini|cucumber|lettuce|avocado|lemon|lime|mushroom|kale|\bveg|fruit|appel|banaan|\bbes|spinazie|paprika|\bui\b|knoflook|tomaat|wortel|komkommer|\bsla\b|citroen|champignon|groente/.test(n)) return "veg";
  return "other";
}

const ZXING_SRC = "https://cdn.jsdelivr.net/npm/@zxing/library@0.21.3/umd/index.min.js";
function loadZxing() {
  return new Promise((resolve, reject) => {
    if (window.ZXing) return resolve(window.ZXing);
    const s = document.createElement("script");
    s.src = ZXING_SRC; s.async = true;
    s.onload = () => window.ZXing ? resolve(window.ZXing) : reject(new Error("no zxing"));
    s.onerror = () => reject(new Error("load"));
    document.head.appendChild(s);
  });
}

const BarcodeIcon = ({ c }) => (
  <svg width="18" height="18" viewBox="0 0 24 24" fill={c} aria-hidden="true">
    <rect x="3" y="5" width="1.7" height="14" /><rect x="6" y="5" width="1" height="14" /><rect x="8.5" y="5" width="2" height="14" /><rect x="12" y="5" width="1" height="14" /><rect x="14.6" y="5" width="1.7" height="14" /><rect x="17.6" y="5" width="1" height="14" /><rect x="20" y="5" width="1.4" height="14" />
  </svg>
);
const PlusIcon = ({ c }) => (
  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="2.2" strokeLinecap="round"><path d="M12 5v14M5 12h14" /></svg>
);

export default function Products({ lang, session, onClose, onPick, embedded, autoScan, onProductChange }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const ml = macroLetters(lang);
  const cloud = !!(session && supabase);
  const [items, setItems] = useState(() => (cloud ? [] : load("hf_products", [])));
  const [nm, setNm] = useState(""), [br, setBr] = useState(""), [bc, setBc] = useState("");
  const [kc, setKc] = useState(""), [pr, setPr] = useState(""), [cb, setCb] = useState(""), [ft, setFt] = useState("");
  const [cat, setCat] = useState("");
  const [adding, setAdding] = useState(false);
  const [editId, setEditId] = useState(null);
  const [propMsg, setPropMsg] = useState(false);
  const [scanning, setScanning] = useState(false);
  const [msg, setMsg] = useState("");
  const [looking, setLooking] = useState(false);
  const [manualBc, setManualBc] = useState("");
  const [q, setQ] = useState("");
  const videoRef = useRef(null);
  const readerRef = useRef(null);

  useEffect(() => {
    let active = true;
    if (cloud) {
      supabase.from("products").select("id,name,brand,barcode,per_100,category").eq("user_id", session.user.id).order("name")
        .then(({ data }) => { if (active && data) setItems(data); });
    }
    return () => { active = false; stopScan(); };
  }, [session]);

  // Vanaf de + knop: scanner direct starten.
  useEffect(() => { if (autoScan) startScan(); /* eslint-disable-next-line */ }, []);

  function stopScan() {
    try { if (readerRef.current) { readerRef.current.reset(); readerRef.current = null; } } catch (e) {}
    try { const v = videoRef.current; if (v && v.srcObject) { v.srcObject.getTracks().forEach((tk) => tk.stop()); v.srcObject = null; } } catch (e) {}
  }
  function resetForm() { setNm(""); setBr(""); setBc(""); setKc(""); setPr(""); setCb(""); setFt(""); setCat(""); setMsg(""); setManualBc(""); }
  function closeAdd() { stopScan(); setScanning(false); setAdding(false); setEditId(null); resetForm(); }
  function startEdit(it) {
    setEditId(it.id); setScanning(false); setMsg("");
    setNm(it.name || ""); setBr(it.brand || ""); setBc(it.barcode || "");
    const p = it.per_100 || {}; setKc(p.kcal != null ? p.kcal : ""); setPr(p.p != null ? p.p : ""); setCb(p.c != null ? p.c : ""); setFt(p.f != null ? p.f : "");
    setCat(it.category || ""); setAdding(true);
  }

  async function startScan() {
    setMsg(""); setAdding(true); setScanning(true);
    let ZX;
    try { ZX = await loadZxing(); } catch (e) { setMsg(t("scanErr")); setScanning(false); return; }
    try {
      const reader = new ZX.BrowserMultiFormatReader();
      readerRef.current = reader;
      await reader.decodeFromConstraints({ video: { facingMode: "environment" } }, videoRef.current, (result) => {
        if (result) { const code = result.getText(); stopScan(); setScanning(false); lookup(code); }
      });
    } catch (e) { setMsg(t("camErr")); stopScan(); setScanning(false); }
  }
  function openManual() { setAdding(true); setScanning(false); setMsg(""); }

  async function lookup(code) {
    setBc(code); setLooking(true); setMsg("");
    try {
      const r = await fetch("https://world.openfoodfacts.org/api/v2/product/" + encodeURIComponent(code) + ".json?fields=product_name,brands,nutriments");
      const j = await r.json().catch(() => ({}));
      if (j && j.status === 1 && j.product) {
        const p = j.product, n = p.nutriments || {};
        if (p.product_name) setNm(p.product_name);
        if (p.brands) setBr(String(p.brands).split(",")[0].trim());
        const g = (k) => (n[k] != null ? Math.round(num(n[k])) : "");
        setKc(g("energy-kcal_100g")); setPr(g("proteins_100g")); setCb(g("carbohydrates_100g")); setFt(g("fat_100g"));
        setMsg(t("found"));
      } else { setMsg(t("notFound")); }
    } catch (e) { setMsg(t("notFound")); } finally { setLooking(false); }
  }

  function add() {
    const name = nm.trim();
    if (!name) return;
    const per_100 = { kcal: Math.round(num(kc)), p: Math.round(num(pr)), c: Math.round(num(cb)), f: Math.round(num(ft)) };
    const barcode = bc.trim() || null;
    const category = cat || null;
    if (editId) {
      const patch = { name, brand: br.trim() || null, barcode, per_100, category };
      const next = items.map((x) => x.id === editId ? { ...x, ...patch } : x).sort((a, b) => a.name.localeCompare(b.name));
      setItems(next);
      if (cloud) supabase.from("products").update(patch).eq("id", editId).then(() => {}, () => {});
      else save("hf_products", next);
      if (onProductChange) { onProductChange({ id: editId, ...patch }); setPropMsg(true); setTimeout(() => setPropMsg(false), 2600); }
      closeAdd();
      return;
    }
    if (cloud) {
      supabase.from("products").insert({ user_id: session.user.id, name, brand: br.trim() || null, barcode, per_100, category, unit: "g" }).select("id,name,brand,barcode,per_100,category").single()
        .then(({ data }) => { if (data) setItems((p) => [...p, data].sort((a, b) => a.name.localeCompare(b.name))); }, () => {});
    } else {
      const row = { id: "l" + Date.now(), name, brand: br.trim() || null, barcode, per_100, category };
      const next = [...items, row].sort((a, b) => a.name.localeCompare(b.name));
      setItems(next); save("hf_products", next);
    }
    closeAdd();
  }
  function del(id) {
    const next = items.filter((x) => x.id !== id);
    setItems(next);
    if (cloud) { supabase.from("products").delete().eq("id", id).then(() => {}, () => {}); }
    else { save("hf_products", next); }
  }
  function setCategory(id, c) {
    const next = items.map((x) => x.id === id ? { ...x, category: c } : x);
    setItems(next);
    if (cloud) { supabase.from("products").update({ category: c }).eq("id", id).then(() => {}, () => {}); }
    else { save("hf_products", next); }
  }
  const catFor = (it) => it.category || catOf(it.name);

  const macroIn = (val, set, ph) => <input value={val} onChange={(e) => set(e.target.value)} inputMode="numeric" placeholder={ph} style={{ ...input, textAlign: "center", padding: "9px 4px" }} />;

  // Lijst filteren + per categorie groeperen
  const needle = q.trim().toLowerCase();
  const filtered = items.filter((x) => !needle || (x.name && x.name.toLowerCase().includes(needle)) || (x.brand && x.brand.toLowerCase().includes(needle)));
  const grouped = {};
  filtered.forEach((it) => { const c = catFor(it); (grouped[c] = grouped[c] || []).push(it); });

  const addCard = adding ? (
    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 14, marginBottom: 14 }}>
      {scanning && (
        <div style={{ marginBottom: 12 }}>
          <video ref={videoRef} style={{ width: "100%", borderRadius: 10, background: "#000", aspectRatio: "4/3", objectFit: "cover" }} muted playsInline />
          <div style={{ fontSize: 11.5, color: MUTED, textAlign: "center", marginTop: 8 }}>{t("scanning")}</div>
        </div>
      )}
      <div style={{ display: "flex", gap: 8, marginBottom: 12 }}>
        <input value={manualBc} onChange={(e) => setManualBc(e.target.value)} inputMode="numeric" placeholder={t("manualCode")} style={{ ...input, flex: 1 }} />
        <button onClick={() => manualBc.trim() && lookup(manualBc.trim())} disabled={looking} style={{ ...ghostBtn, whiteSpace: "nowrap", opacity: looking ? 0.7 : 1 }}>{looking ? t("looking") : t("lookup")}</button>
      </div>
      {msg && <div style={{ fontSize: 11.5, color: msg === t("found") ? "#4ADE80" : EMBER_SOFT, marginBottom: 12, lineHeight: 1.4 }}>{msg}</div>}
      <div style={{ marginBottom: 10 }}>
        <label style={label}>{t("name")}</label>
        <input value={nm} onChange={(e) => setNm(e.target.value)} placeholder={t("namePh")} style={input} />
      </div>
      <div style={{ marginBottom: 10 }}>
        <label style={label}>{t("brand")}</label>
        <input value={br} onChange={(e) => setBr(e.target.value)} style={input} />
      </div>
      <div style={{ marginBottom: 10 }}>
        <label style={label}>{t("catLabel")}</label>
        <select value={cat} onChange={(e) => setCat(e.target.value)} style={{ ...input, appearance: "auto", WebkitAppearance: "auto" }}>
          <option value="">{t("catAuto")}</option>
          {CAT_ORDER.map((c) => <option key={c} value={c}>{CATS[c][lang]}</option>)}
        </select>
      </div>
      <label style={label}>{t("per100")}</label>
      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr 1fr", gap: 7, marginBottom: 12 }}>
        <div>{macroIn(kc, setKc, "kcal")}<div style={{ fontSize: 9.5, color: MUTED, textAlign: "center", marginTop: 3 }}>{t("kcal")}</div></div>
        <div>{macroIn(pr, setPr, "g")}<div style={{ fontSize: 9.5, color: MUTED, textAlign: "center", marginTop: 3 }}>{t("prot")}</div></div>
        <div>{macroIn(cb, setCb, "g")}<div style={{ fontSize: 9.5, color: MUTED, textAlign: "center", marginTop: 3 }}>{t("carb")}</div></div>
        <div>{macroIn(ft, setFt, "g")}<div style={{ fontSize: 9.5, color: MUTED, textAlign: "center", marginTop: 3 }}>{t("fat")}</div></div>
      </div>
      <div style={{ display: "flex", gap: 8 }}>
        <button onClick={add} style={{ ...primaryBtn, flex: 1 }}>{editId ? t("save") : t("add")}</button>
        <button onClick={closeAdd} style={{ ...ghostBtn }}>{t("cancel")}</button>
      </div>
    </div>
  ) : null;

  const body = (
    <>
      {propMsg && <div style={{ fontSize: 12, color: "#4ADE80", lineHeight: 1.5, marginBottom: 12, background: "rgba(74,222,128,0.1)", border: `1px solid rgba(74,222,128,0.3)`, borderRadius: 10, padding: "9px 12px" }}>{t("editProp")}</div>}
      <div style={{ fontSize: 12, color: MUTED, lineHeight: 1.5, marginBottom: 14 }}>{t("intro")}</div>

      {/* Compacte acties */}
      {!adding && (
        <div style={{ display: "flex", gap: 8, marginBottom: 14 }}>
          <button onClick={startScan} style={{ ...primaryBtn, flex: 1, display: "inline-flex", alignItems: "center", justifyContent: "center", gap: 9, padding: "11px 0" }}><BarcodeIcon c={PAPER} />{t("scanBtn")}</button>
          <button onClick={openManual} style={{ ...ghostBtn, flex: 1, display: "inline-flex", alignItems: "center", justifyContent: "center", gap: 8, padding: "11px 0" }}><PlusIcon c={EMBER} />{t("manualBtn")}</button>
        </div>
      )}
      {addCard}

      {/* Zoeken */}
      {items.length > 0 && <input value={q} onChange={(e) => setQ(e.target.value)} placeholder={t("searchPh")} style={{ ...input, marginBottom: 14 }} />}

      {/* Lijst per categorie */}
      {!items.length && <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.6 }}>{t("empty")}</div>}
      {items.length > 0 && !filtered.length && <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.6 }}>{t("noResult")}</div>}
      {CAT_ORDER.filter((c) => grouped[c] && grouped[c].length).map((c) => (
        <div key={c} style={{ marginBottom: 14 }}>
          <div style={{ ...disp, fontSize: 11.5, fontWeight: 700, letterSpacing: 1, textTransform: "uppercase", color: EMBER, marginBottom: 6 }}>{CATS[c][lang]} <span style={{ color: MUTED, fontWeight: 400 }}>· {grouped[c].length}</span></div>
          {grouped[c].map((it) => (
            <div key={it.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "10px 0", borderBottom: `1px solid ${LINE}` }}>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ fontSize: 13.5, fontWeight: 600, color: PAPER }}>{it.name}{it.brand ? <span style={{ color: MUTED, fontWeight: 400 }}> · {it.brand}</span> : null}</div>
                <div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{(it.per_100 && it.per_100.kcal) || 0} kcal · {(it.per_100 && it.per_100.p) || 0}{ml.p}/{(it.per_100 && it.per_100.c) || 0}{ml.c}/{(it.per_100 && it.per_100.f) || 0}{ml.f} <span style={{ opacity: 0.6 }}>/100g</span></div>
              </div>
              {!onPick && <select value={catFor(it)} onChange={(e) => setCategory(it.id, e.target.value)} title={t("catLabel")} style={{ background: INK, border: `1px solid ${LINE}`, color: MUTED, borderRadius: 7, fontSize: 10.5, padding: "4px 5px", outline: "none", maxWidth: 104, appearance: "auto", WebkitAppearance: "auto", flexShrink: 0 }}>
                {CAT_ORDER.map((c) => <option key={c} value={c}>{CATS[c][lang]}</option>)}
              </select>}
              {onPick && <div onClick={() => onPick(it)} style={{ cursor: "pointer", fontSize: 12, fontWeight: 700, color: EMBER, border: `1px solid ${EMBER}`, borderRadius: 7, padding: "5px 11px", ...disp, letterSpacing: 0.3 }}>{t("pick")}</div>}
              {!onPick && <div onClick={() => startEdit(it)} title={t("editTitle")} style={{ cursor: "pointer", color: MUTED, display: "flex", padding: "0 3px" }}><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M12 20h9" /><path d="M16.5 3.5a2.1 2.1 0 013 3L7 19l-4 1 1-4z" /></svg></div>}
              <div onClick={() => del(it.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 16, padding: "0 4px" }}>×</div>
            </div>
          ))}
        </div>
      ))}
    </>
  );

  if (embedded) {
    return (
      <div style={{ display: "grid", gap: 0 }}>
        <div style={sectionTitle}>{t("title")}</div>
        <div style={{ marginTop: 14 }}>{body}</div>
      </div>
    );
  }

  return (
    <div onClick={() => { stopScan(); onClose(); }} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 65, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ position: "relative", background: INK, border: `1px solid ${LINE}`, borderRadius: 20, width: "100%", maxWidth: 440, maxHeight: "90vh", overflowY: "auto", padding: 22, boxShadow: "0 24px 70px rgba(0,0,0,.65)", backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.13), transparent 58%)" }}>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 14 }}>
        <div style={sectionTitle}>{t("title")}</div>
        <div onClick={() => { stopScan(); onClose(); }} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
      </div>
      {body}
      </div>
    </div>
  );
}
