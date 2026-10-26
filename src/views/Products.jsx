import React, { useState, useEffect, useRef } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, disp, num, input, label, sectionTitle, primaryBtn, ghostBtn, load, save } from "../shared.js";
import { supabase } from "../supabaseClient.js";

const T = {
  title: { nl: "Mijn producten", en: "My products" },
  intro: { nl: "Eigen producten met voedingswaarden per 100 g. Scan een barcode of vul ze zelf in.", en: "Your own products with nutrition per 100 g. Scan a barcode or enter them yourself." },
  name: { nl: "Naam", en: "Name" },
  brand: { nl: "Merk (optioneel)", en: "Brand (optional)" },
  per100: { nl: "Per 100 g/ml", en: "Per 100 g/ml" },
  kcal: { nl: "kcal", en: "kcal" },
  prot: { nl: "Eiwit", en: "Protein" },
  carb: { nl: "Koolh.", en: "Carbs" },
  fat: { nl: "Vet", en: "Fat" },
  add: { nl: "Product toevoegen", en: "Add product" },
  empty: { nl: "Nog geen producten. Scan of voeg je eerste toe.", en: "No products yet. Scan or add your first." },
  pick: { nl: "Kies", en: "Pick" },
  namePh: { nl: "bijv. Skyr naturel", en: "e.g. plain skyr" },
  scan: { nl: "Scan barcode", en: "Scan barcode" },
  scanning: { nl: "Richt op de barcode…", en: "Point at the barcode…" },
  cancel: { nl: "Annuleren", en: "Cancel" },
  manual: { nl: "Of typ de barcode", en: "Or type the barcode" },
  lookup: { nl: "Zoek", en: "Look up" },
  looking: { nl: "Zoeken…", en: "Looking up…" },
  notFound: { nl: "Niet gevonden in de database — vul de waarden zelf in.", en: "Not found in the database — enter the values yourself." },
  found: { nl: "Gevonden! Controleer de waarden en voeg toe.", en: "Found! Check the values and add." },
  camErr: { nl: "Camera niet beschikbaar. Typ de barcode hieronder.", en: "Camera unavailable. Type the barcode below." },
  scanErr: { nl: "Scanner kon niet laden. Typ de barcode hieronder.", en: "Scanner failed to load. Type the barcode below." },
};

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

export default function Products({ lang, session, onClose, onPick }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const cloud = !!(session && supabase);
  const [items, setItems] = useState(() => (cloud ? [] : load("hf_products", [])));
  const [nm, setNm] = useState(""), [br, setBr] = useState(""), [bc, setBc] = useState("");
  const [kc, setKc] = useState(""), [pr, setPr] = useState(""), [cb, setCb] = useState(""), [ft, setFt] = useState("");
  const [scanning, setScanning] = useState(false);
  const [msg, setMsg] = useState("");
  const [looking, setLooking] = useState(false);
  const [manualCode, setManualCode] = useState("");
  const videoRef = useRef(null);
  const readerRef = useRef(null);

  useEffect(() => {
    let active = true;
    if (cloud) {
      supabase.from("products").select("id,name,brand,barcode,per_100").eq("user_id", session.user.id).order("name")
        .then(({ data }) => { if (active && data) setItems(data); });
    }
    return () => { active = false; stopScan(); };
  }, [session]);

  function stopScan() {
    try { if (readerRef.current) { readerRef.current.reset(); readerRef.current = null; } } catch (e) {}
    try { const v = videoRef.current; if (v && v.srcObject) { v.srcObject.getTracks().forEach((tk) => tk.stop()); v.srcObject = null; } } catch (e) {}
  }

  async function startScan() {
    setMsg(""); setScanning(true);
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
    if (cloud) {
      supabase.from("products").insert({ user_id: session.user.id, name, brand: br.trim() || null, barcode, per_100, unit: "g" }).select("id,name,brand,barcode,per_100").single()
        .then(({ data }) => { if (data) setItems((p) => [...p, data].sort((a, b) => a.name.localeCompare(b.name))); }, () => {});
    } else {
      const row = { id: "l" + Date.now(), name, brand: br.trim() || null, barcode, per_100 };
      const next = [...items, row].sort((a, b) => a.name.localeCompare(b.name));
      setItems(next); save("hf_products", next);
    }
    setNm(""); setBr(""); setBc(""); setKc(""); setPr(""); setCb(""); setFt(""); setMsg(""); setManualCode("");
  }
  function del(id) {
    const next = items.filter((x) => x.id !== id);
    setItems(next);
    if (cloud) { supabase.from("products").delete().eq("id", id).then(() => {}, () => {}); }
    else { save("hf_products", next); }
  }

  const macroIn = (val, set, ph) => <input value={val} onChange={(e) => set(e.target.value)} inputMode="numeric" placeholder={ph} style={{ ...input, textAlign: "center", padding: "9px 4px" }} />;

  return (
    <div onClick={() => { stopScan(); onClose(); }} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 65, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ position: "relative", background: INK, border: `1px solid ${LINE}`, borderRadius: 20, width: "100%", maxWidth: 440, maxHeight: "90vh", overflowY: "auto", padding: 22, boxShadow: "0 24px 70px rgba(0,0,0,.65)", backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.13), transparent 58%)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 14 }}>
          <div style={sectionTitle}>{t("title")}</div>
          <div onClick={() => { stopScan(); onClose(); }} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>
        <div style={{ fontSize: 12, color: MUTED, lineHeight: 1.5, marginBottom: 16 }}>{t("intro")}</div>

        <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 14, marginBottom: 16 }}>
          {/* Scanner */}
          {scanning ? (
            <div style={{ marginBottom: 12 }}>
              <video ref={videoRef} style={{ width: "100%", borderRadius: 10, background: "#000", aspectRatio: "4/3", objectFit: "cover" }} muted playsInline />
              <div style={{ fontSize: 11.5, color: MUTED, textAlign: "center", margin: "8px 0" }}>{t("scanning")}</div>
              <button onClick={() => { stopScan(); setScanning(false); }} style={{ ...ghostBtn, width: "100%" }}>{t("cancel")}</button>
            </div>
          ) : (
            <div style={{ display: "flex", gap: 8, marginBottom: 12 }}>
              <button onClick={startScan} style={{ ...primaryBtn, flex: 1 }}>{t("scan")}</button>
            </div>
          )}
          {/* Handmatige barcode */}
          {!scanning && (
            <div style={{ display: "flex", gap: 8, marginBottom: 12 }}>
              <input value={manualCode} onChange={(e) => setManualCode(e.target.value)} inputMode="numeric" placeholder={t("manual")} style={{ ...input, flex: 1 }} />
              <button onClick={() => manualCode.trim() && lookup(manualCode.trim())} disabled={looking} style={{ ...ghostBtn, whiteSpace: "nowrap", opacity: looking ? 0.7 : 1 }}>{looking ? t("looking") : t("lookup")}</button>
            </div>
          )}
          {msg && <div style={{ fontSize: 11.5, color: msg === t("found") ? "#4ADE80" : EMBER_SOFT, marginBottom: 12, lineHeight: 1.4 }}>{msg}</div>}

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
