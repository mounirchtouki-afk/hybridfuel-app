import React, { useState, useEffect } from "react";
import { INK, INK2, PAPER, MUTED, LINE, disp, applyOrgTheme } from "../shared.js";
import { supabase } from "../supabaseClient.js";

// Branded code-login voor sportschool-leden. Leden openen /join/<slug>, voeren hun
// code in (geen e-mail) en komen in de app. White-label: logo + merkkleur van de org.
export default function Join({ slug, lang }) {
  const [brand, setBrand] = useState(null);     // {name, brand_color, logo_url}
  const [notFound, setNotFound] = useState(false);
  const [code, setCode] = useState("");
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");

  const t = (nl, en) => (lang === "nl" ? nl : en);

  useEffect(() => {
    let alive = true;
    fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "branding", slug }) })
      .then((r) => r.ok ? r.json() : Promise.reject())
      .then((d) => { if (alive) { setBrand(d); applyOrgTheme(d.theme || { template: "dark", accent: d.brand_color }); } })
      .catch(() => { if (alive) setNotFound(true); });
    return () => { alive = false; applyOrgTheme(null); };
  }, [slug]);

  const color = (brand && brand.brand_color) || "#E11D48";

  async function submit() {
    const c = code.trim().toUpperCase();
    if (!c) return;
    setBusy(true); setErr("");
    try {
      const r = await fetch("/api/gym", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ action: "login", orgSlug: slug, code: c }) });
      const d = await r.json().catch(() => ({}));
      if (r.status === 429) { setErr(t("Te veel pogingen. Wacht even.", "Too many attempts. Please wait.")); setBusy(false); return; }
      if (!r.ok || !d.access_token) { setErr(t("Onjuiste code. Vraag je coach om een nieuwe.", "Invalid code. Ask your coach for a new one.")); setBusy(false); return; }
      // Sessie zetten; de app-listener pakt 'm op en laadt de app.
      if (supabase) { await supabase.auth.setSession({ access_token: d.access_token, refresh_token: d.refresh_token }); }
      try { sessionStorage.removeItem("hf_demo"); } catch (e) {}
      // kleine delay zodat de auth-state doorkomt
      setTimeout(() => { try { window.location.href = "/"; } catch (e) {} }, 300);
    } catch (e) { setErr(t("Er ging iets mis. Probeer opnieuw.", "Something went wrong. Try again.")); setBusy(false); }
  }

  const wrap = { minHeight: "100vh", background: INK, color: PAPER, fontFamily: "Inter, sans-serif", display: "flex", alignItems: "center", justifyContent: "center", padding: 20 };
  const card = { width: "100%", maxWidth: 380, background: INK2, border: `1px solid ${LINE}`, borderRadius: 18, padding: 26, textAlign: "center" };

  if (notFound) {
    return (
      <div style={wrap}><div style={card}>
        <div style={{ ...disp, fontSize: 20, fontWeight: 700, marginBottom: 8 }}>{t("Sportschool niet gevonden", "Gym not found")}</div>
        <div style={{ fontSize: 13, color: MUTED, lineHeight: 1.5 }}>{t("Controleer de link die je van je sportschool kreeg.", "Check the link your gym gave you.")}</div>
      </div></div>
    );
  }

  return (
    <div style={wrap}>
      <div style={card}>
        {brand && brand.logo_url
          ? <img src={brand.logo_url} alt={brand.name} style={{ maxHeight: 54, maxWidth: 200, objectFit: "contain", marginBottom: 14 }} />
          : <div style={{ ...disp, fontSize: 24, fontWeight: 800, letterSpacing: 0.3, marginBottom: 14, color }}>{(brand && brand.name) || " "}</div>}
        <div style={{ ...disp, fontSize: 18, fontWeight: 700, marginBottom: 4 }}>{t("Log in met je code", "Log in with your code")}</div>
        <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 18, lineHeight: 1.5 }}>{t("Je kreeg een persoonlijke code van je coach.", "Your coach gave you a personal code.")}</div>
        <input
          value={code}
          onChange={(e) => setCode(e.target.value.toUpperCase())}
          onKeyDown={(e) => { if (e.key === "Enter") submit(); }}
          placeholder={t("JOUW CODE", "YOUR CODE")}
          autoCapitalize="characters"
          style={{ width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "14px", fontSize: 20, letterSpacing: 4, textAlign: "center", borderRadius: 10, outline: "none", ...disp, fontWeight: 700, marginBottom: 12, boxSizing: "border-box" }}
        />
        <div onClick={() => { if (!busy) submit(); }} style={{ cursor: busy ? "default" : "pointer", opacity: busy ? 0.7 : 1, background: color, color: "#fff", padding: "14px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.6, textTransform: "uppercase" }}>
          {busy ? t("Bezig…", "Loading…") : t("Inloggen", "Log in")}
        </div>
        {err && <div style={{ fontSize: 12.5, color: "#FB7185", marginTop: 12, lineHeight: 1.4 }}>{err}</div>}
        <div style={{ fontSize: 10.5, color: MUTED, marginTop: 20, letterSpacing: 0.3 }}>Powered by HybridFuel</div>
      </div>
    </div>
  );
}
