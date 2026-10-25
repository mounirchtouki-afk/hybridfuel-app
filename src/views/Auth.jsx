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

  const shell = (children) => (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.6)", zIndex: 60, display: "flex", alignItems: "flex-end", justifyContent: "center" }}>
      <div onClick={(e) => e.stopPropagation()} style={{ background: INK, borderTop: `1px solid ${LINE}`, borderRadius: "18px 18px 0 0", width: "100%", maxWidth: 480, maxHeight: "88vh", overflowY: "auto", padding: 20, boxShadow: "0 -10px 40px rgba(0,0,0,.5)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
          <div style={sectionTitle}>{t("account")}</div>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 22, lineHeight: 1 }}>×</div>
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
          <span style={{ ...disp, fontSize: 13, fontWeight: 700, color: tier && tier !== "free" ? EMBER : MUTED, textTransform: "uppercase", letterSpacing: 1 }}>{tier || "free"}</span>
        </div>
        <button onClick={logout} style={{ ...ghostBtn, width: "100%" }}>{t("logout")}</button>
      </div>
    );
  }

  return shell(
    <div>
      <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.5, marginBottom: 14 }}>{t("intro")}</div>
      <div style={{ display: "inline-flex", gap: 4, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4, marginBottom: 14 }}>
        {[["login", t("login")], ["signup", t("signup")]].map(([id, lbl]) => (
          <div key={id} onClick={() => { setMode(id); setErr(""); setMsg(""); }} style={{ padding: "8px 18px", borderRadius: 7, background: mode === id ? EMBER : "transparent", color: mode === id ? INK : PAPER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5, cursor: "pointer" }}>{lbl}</div>
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
