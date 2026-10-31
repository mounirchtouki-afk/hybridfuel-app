import React, { useState, useEffect, useRef } from "react";
import QRCode from "qrcode";
import { INK2, EMBER, PAPER, MUTED, LINE, disp } from "../shared.js";
import { apiUrl } from "../apiBase";

// Dynamische toegangs-QR: haalt elke minuut een nieuw, kortlevend ondertekend
// token op en toont het als QR. Een deur-scanner valideert het via /api/access-verify.
export default function AccessQR({ lang, session }) {
  const [src, setSrc] = useState("");
  const [err, setErr] = useState("");
  const timer = useRef(null);
  const t = (nl, en) => (lang === "nl" ? nl : en);

  async function refresh() {
    if (!session) { setErr(t("Log in om je toegangs-QR te zien.", "Log in to see your access QR.")); setSrc(""); return; }
    try {
      const r = await fetch(apiUrl("/api/access-token"), {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ authToken: session.access_token }),
      });
      const d = await r.json().catch(() => ({}));
      if (!d || !d.token) {
        setErr(d && d.error === "not_configured"
          ? t("Toegang is nog niet ingesteld op de server.", "Access isn't configured on the server yet.")
          : t("Toegang nog niet beschikbaar.", "Access not available yet."));
        setSrc("");
        return;
      }
      setErr("");
      const url = await QRCode.toDataURL(d.token, { margin: 1, width: 560, color: { dark: "#0A0A0A", light: "#ffffff" } });
      setSrc(url);
    } catch (e) {
      setErr(t("Kon de QR niet laden.", "Couldn't load the QR."));
    }
  }

  useEffect(() => {
    refresh();
    timer.current = setInterval(refresh, 60000); // ververst elke 60s (token is 90s geldig)
    return () => { if (timer.current) clearInterval(timer.current); };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [session]);

  return (
    <div style={{ padding: "18px 16px", color: PAPER }}>
      <div style={{ ...disp, fontWeight: 700, fontSize: 20, letterSpacing: 0.3 }}>{t("Toegang", "Access")}</div>
      <div style={{ fontSize: 13, color: MUTED, marginTop: 4, marginBottom: 18, lineHeight: 1.5 }}>
        {t("Scan deze QR bij de deur. Hij ververst automatisch, voor je veiligheid.",
           "Scan this QR at the door. It refreshes automatically, for your security.")}
      </div>

      {err ? (
        <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 18, fontSize: 13.5, color: MUTED, lineHeight: 1.6 }}>{err}</div>
      ) : (
        <div style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 14, marginTop: 8 }}>
          <div style={{ background: "#fff", padding: 18, borderRadius: 20, boxShadow: "0 12px 34px rgba(225,29,72,0.28)" }}>
            {src
              ? <img src={src} alt="Access QR" style={{ width: 236, height: 236, display: "block" }} />
              : <div style={{ width: 236, height: 236, display: "flex", alignItems: "center", justifyContent: "center", color: "#999", fontSize: 13 }}>…</div>}
          </div>
          <div style={{ fontSize: 11.5, color: MUTED, letterSpacing: 0.5 }}>
            <span style={{ display: "inline-block", width: 7, height: 7, borderRadius: "50%", background: EMBER, marginRight: 7, verticalAlign: "middle" }} />
            {t("Ververst elke minuut", "Refreshes every minute")}
          </div>
        </div>
      )}
    </div>
  );
}
