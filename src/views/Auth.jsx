import React, { useState } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, disp, input, label, sectionTitle, primaryBtn, ghostBtn } from "../shared.js";
import { supabase, supaReady } from "../supabaseClient.js";

const T = {
  account: { nl: "Account", en: "Account" },
  login: { nl: "Inloggen", en: "Log in" },
  signup: { nl: "Account maken", en: "Sign up" },
  email: { nl: "E-mail", en: "Email" },
  pw: { nl: "Wachtwoord", en: "Password" },
  loginBtn: { nl: "Inloggen", en: "Log in" },
  signupBtn: { nl: "Account aanmaken", en: "Create account" },
  busy: { nl: "Bezig…", en: "Working…" },
  loggedInAs: { nl: "Ingelogd als", en: "Logged in as" },
  logout: { nl: "Uitloggen", en: "Log out" },
  checkMail: { nl: "Check je inbox om je account te bevestigen. Daarna kun je inloggen.", en: "Check your inbox to confirm your account, then log in." },
  switchToSignup: { nl: "Nog geen account? Maak er een.", en: "No account yet? Create one." },
  switchToLogin: { nl: "Al een account? Log in.", en: "Already have an account? Log in." },
  intro: { nl: "Maak een account om je plannen, tracker en recepten op al je apparaten te bewaren.", en: "Create an account to keep your plans, tracker and recipes across all your devices." },
  notReady: { nl: "De accountkoppeling is nog niet actief.", en: "Account connection is not active yet." },
  tier: { nl: "Abonnement", en: "Plan" },
  close: { nl: "Sluiten", en: "Close" },
  upgradeTitle: { nl: "Kies je abonnement", en: "Choose your plan" },
  month: { nl: "Maand", en: "Monthly" },
  year: { nl: "Jaar", en: "Yearly" },
  perMo: { nl: "/mnd", en: "/mo" },
  perYr: { nl: "/jr", en: "/yr" },
  freeMonths: { nl: "2 maanden gratis", en: "2 months free" },
  basisName: { nl: "Basis", en: "Basic" },
  proName: { nl: "Pro", en: "Pro" },
  basisFeat: { nl: "Weekplan in de app · tracker · water · boodschappen", en: "Weekly plan in-app · tracker · water · shopping list" },
  proFeat: { nl: "Alles van Basis + zelf aanpassen · eigen producten · barcode-scan", en: "Everything in Basic + customise · own products · barcode scan" },
  choose: { nl: "Kiezen", en: "Choose" },
  popular: { nl: "Populair", en: "Popular" },
  manage: { nl: "Beheer abonnement", en: "Manage subscription" },
  active: { nl: "Actief", en: "Active" },
  notConfigured: { nl: "Afrekenen is nog niet actief. Probeer later opnieuw.", en: "Checkout isn't live yet. Try again later." },
};

const PRICE = {
  basis: { month: "€9,95", year: "€99,50" },
  pro: { month: "€14,95", year: "€149,50" },
};

export default function Auth({ lang, session, tier, onClose }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const [mode, setMode] = useState("login");
  const [email, setEmail] = useState("");
  const [pw, setPw] = useState("");
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");
  const [msg, setMsg] = useState("");

  async function submit() {
    if (!supabase) return;
    setErr(""); setMsg(""); setBusy(true);
    try {
      if (mode === "signup") {
        const { error } = await supabase.auth.signUp({ email: email.trim(), password: pw });
        if (error) throw error;
        setMsg(t("checkMail"));
      } else {
        const { error } = await supabase.auth.signInWithPassword({ email: email.trim(), password: pw });
        if (error) throw error;
        onClose();
      }
    } catch (e) { setErr(e && e.message ? e.message : "error"); } finally { setBusy(false); }
  }
  async function logout() { try { await supabase.auth.signOut(); } catch (e) {} onClose(); }

  const [billInterval, setBillInterval] = useState("month");
  const [subBusy, setSubBusy] = useState("");

  async function upgrade(plan) {
    if (!session) return;
    setErr(""); setSubBusy(plan);
    try {
      const r = await fetch("/api/create-subscription", {
        method: "POST", headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId: session.user.id, email: session.user.email, tier: plan, interval: billInterval }),
      });
      const d = await r.json().catch(() => ({}));
      if (d && d.url) { window.location.href = d.url; return; }
      setErr(d && d.error === "not_configured" ? t("notConfigured") : (d && d.detail) || "error");
    } catch (e) { setErr(t("notConfigured")); } finally { setSubBusy(""); }
  }
  async function portal() {
    if (!session) return;
    setErr(""); setSubBusy("portal");
    try {
      const r = await fetch("/api/billing-portal", {
        method: "POST", headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId: session.user.id }),
      });
      const d = await r.json().catch(() => ({}));
      if (d && d.url) { window.location.href = d.url; return; }
      setErr(t("notConfigured"));
    } catch (e) { setErr(t("notConfigured")); } finally { setSubBusy(""); }
  }

  const planCard = (plan) => {
    const price = PRICE[plan][billInterval];
    const popular = plan === "pro";
    return (
      <div style={{ position: "relative", background: INK2, border: `1px solid ${popular ? EMBER : LINE}`, borderRadius: 12, padding: 14, marginBottom: 10 }}>
        {popular && <div style={{ position: "absolute", top: -9, right: 12, background: EMBER, color: INK, fontSize: 9.5, fontWeight: 700, ...disp, letterSpacing: 0.8, textTransform: "uppercase", padding: "2px 8px", borderRadius: 5 }}>{t("popular")}</div>}
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", marginBottom: 6 }}>
          <div style={{ ...disp, fontSize: 16, fontWeight: 700, color: PAPER, textTransform: "uppercase", letterSpacing: 0.5 }}>{t(plan + "Name")}</div>
          <div style={{ ...disp, fontSize: 19, fontWeight: 700, color: popular ? EMBER : PAPER }}>{price}<span style={{ fontSize: 11, color: MUTED, fontWeight: 500 }}>{billInterval === "year" ? t("perYr") : t("perMo")}</span></div>
        </div>
        <div style={{ fontSize: 11.5, color: MUTED, lineHeight: 1.5, marginBottom: 12 }}>{t(plan + "Feat")}</div>
        <button onClick={() => upgrade(plan)} disabled={!!subBusy} style={{ ...(popular ? primaryBtn : ghostBtn), width: "100%", opacity: subBusy ? 0.7 : 1 }}>{subBusy === plan ? t("busy") : t("choose")}</button>
      </div>
    );
  };

  const shell = (children) => (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 60, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ position: "relative", background: INK, border: `1px solid ${LINE}`, borderRadius: 20, width: "100%", maxWidth: 420, maxHeight: "90vh", overflowY: "auto", padding: 22, boxShadow: "0 24px 70px rgba(0,0,0,.65)", backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.13), transparent 58%)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 18 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
            <div style={{ width: 28, height: 28, borderRadius: 8, background: EMBER, display: "flex", alignItems: "center", justifyContent: "center", ...disp, fontWeight: 700, color: PAPER, fontSize: 16 }}>H</div>
            <div style={sectionTitle}>{t("account")}</div>
          </div>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, lineHeight: 1, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>
        {children}
      </div>
    </div>
  );

  if (!supaReady || !supabase) {
    return shell(<div style={{ fontSize: 13, color: MUTED, lineHeight: 1.6 }}>{t("notReady")}</div>);
  }

  if (session) {
    return shell(
      <div>
        <div style={{ fontSize: 12, color: MUTED }}>{t("loggedInAs")}</div>
        <div style={{ ...disp, fontSize: 18, fontWeight: 600, marginTop: 2, marginBottom: 14, wordBreak: "break-all" }}>{session.user.email}</div>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "10px 12px", background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, marginBottom: 16 }}>
          <span style={{ fontSize: 12, color: MUTED }}>{t("tier")}</span>
          <span style={{ ...disp, fontSize: 13, fontWeight: 700, color: tier && tier !== "free" ? EMBER : MUTED, textTransform: "uppercase", letterSpacing: 1 }}>{tier || "free"}{tier && tier !== "free" ? " · " + t("active") : ""}</span>
        </div>

        {(!tier || tier === "free") ? (
          <div style={{ marginBottom: 16 }}>
            <div style={sectionTitle}>{t("upgradeTitle")}</div>
            <div style={{ display: "inline-flex", gap: 4, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4, margin: "12px 0 14px" }}>
              {[["month", t("month")], ["year", t("year")]].map(([id, lbl]) => (
                <div key={id} onClick={() => setBillInterval(id)} style={{ padding: "7px 16px", borderRadius: 7, background: billInterval === id ? EMBER : "transparent", color: PAPER, fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.5, cursor: "pointer" }}>{lbl}</div>
              ))}
              {billInterval === "year" && <div style={{ alignSelf: "center", fontSize: 10.5, color: EMBER_SOFT, fontWeight: 700, padding: "0 8px", ...disp, letterSpacing: 0.3 }}>{t("freeMonths")}</div>}
            </div>
            {planCard("basis")}
            {planCard("pro")}
          </div>
        ) : (
          <button onClick={portal} disabled={!!subBusy} style={{ ...ghostBtn, width: "100%", marginBottom: 12, opacity: subBusy ? 0.7 : 1 }}>{subBusy === "portal" ? t("busy") : t("manage")}</button>
        )}

        {err && <div style={{ fontSize: 12, color: EMBER_SOFT, marginBottom: 12, lineHeight: 1.4 }}>{err}</div>}
        <button onClick={logout} style={{ ...ghostBtn, width: "100%" }}>{t("logout")}</button>
      </div>
    );
  }

  return shell(
    <div>
      <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.5, marginBottom: 14 }}>{t("intro")}</div>
      <div style={{ display: "inline-flex", gap: 4, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4, marginBottom: 14 }}>
        {[["login", t("login")], ["signup", t("signup")]].map(([id, lbl]) => (
          <div key={id} onClick={() => { setMode(id); setErr(""); setMsg(""); }} style={{ padding: "8px 18px", borderRadius: 7, background: mode === id ? EMBER : "transparent", color: PAPER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5, cursor: "pointer" }}>{lbl}</div>
        ))}
      </div>
      <div style={{ marginBottom: 10 }}>
        <label style={label}>{t("email")}</label>
        <input style={input} type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="jij@email.com" autoComplete="email" />
      </div>
      <div style={{ marginBottom: 14 }}>
        <label style={label}>{t("pw")}</label>
        <input style={input} type="password" value={pw} onChange={(e) => setPw(e.target.value)} autoComplete={mode === "signup" ? "new-password" : "current-password"} />
      </div>
      <button onClick={submit} disabled={busy} style={{ ...primaryBtn, opacity: busy ? 0.7 : 1 }}>{busy ? t("busy") : mode === "signup" ? t("signupBtn") : t("loginBtn")}</button>
      {err && <div style={{ fontSize: 12, color: EMBER_SOFT, marginTop: 10, lineHeight: 1.4 }}>{err}</div>}
      {msg && <div style={{ fontSize: 12.5, color: "#4ADE80", marginTop: 10, lineHeight: 1.5 }}>{msg}</div>}
      <div onClick={() => { setMode(mode === "login" ? "signup" : "login"); setErr(""); setMsg(""); }} style={{ fontSize: 12, color: MUTED, marginTop: 14, textAlign: "center", cursor: "pointer" }}>
        {mode === "login" ? t("switchToSignup") : t("switchToLogin")}
      </div>
    </div>
  );
}
