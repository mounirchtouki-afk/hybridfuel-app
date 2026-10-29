import React, { useState, useEffect } from "react";
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
  manage: { nl: "Facturen bekijken", en: "View invoices" },
  active: { nl: "Actief", en: "Active" },
  notConfigured: { nl: "Afrekenen is nog niet actief. Probeer later opnieuw.", en: "Checkout isn't live yet. Try again later." },
  forgot: { nl: "Wachtwoord vergeten?", en: "Forgot password?" },
  resetTitle: { nl: "Wachtwoord resetten", en: "Reset password" },
  resetBtn: { nl: "Stuur reset-link", en: "Send reset link" },
  resetSent: { nl: "Reset-link verstuurd. Check je inbox.", en: "Reset link sent. Check your inbox." },
  backToLogin: { nl: "Terug naar inloggen", en: "Back to log in" },
  newsletter: { nl: "Houd me op de hoogte (tips & nieuws)", en: "Keep me posted (tips & news)" },
  newsletterLbl: { nl: "Nieuwsbrief", en: "Newsletter" },
  nameLbl: { nl: "Naam", en: "Name" },
  namePh: { nl: "Je naam (voor je dashboard)", en: "Your name (for your dashboard)" },
  nameSavedTxt: { nl: "Opgeslagen ✓", en: "Saved ✓" },
  setNewPw: { nl: "Nieuw wachtwoord instellen", en: "Set a new password" },
  newPwPh: { nl: "Nieuw wachtwoord", en: "New password" },
  save: { nl: "Opslaan", en: "Save" },
  pwChanged: { nl: "Wachtwoord gewijzigd.", en: "Password changed." },
  settings: { nl: "Instellingen", en: "Settings" },
  changeEmail: { nl: "E-mail wijzigen", en: "Change email" },
  changePw: { nl: "Wachtwoord wijzigen", en: "Change password" },
  newEmailPh: { nl: "Nieuw e-mailadres", en: "New email" },
  emailChangeSent: { nl: "Bevestig via de link in je nieuwe inbox.", en: "Confirm via the link in your new inbox." },
  delAccount: { nl: "Account verwijderen", en: "Delete account" },
  delConfirm: { nl: "Weet je het zeker? Dit verwijdert je account en alle data definitief.", en: "Are you sure? This permanently deletes your account and all data." },
  delYes: { nl: "Ja, verwijder alles", en: "Yes, delete everything" },
  cancel: { nl: "Annuleren", en: "Cancel" },
  deleting: { nl: "Verwijderen…", en: "Deleting…" },
  delErr: { nl: "Verwijderen lukte niet. Probeer het later opnieuw.", en: "Couldn't delete your account. Please try again later." },
};

const PRICE = {
  basis: { month: "€9,95", year: "€99,50" },
  pro: { month: "€14,95", year: "€149,50" },
};

export default function Auth({ lang, session, tier, recovery, onClose }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const [mode, setMode] = useState("login"); // login | signup | forgot
  const [email, setEmail] = useState("");
  const [pw, setPw] = useState("");
  const [news, setNews] = useState(true);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");
  const [msg, setMsg] = useState("");
  const [billInterval, setBillInterval] = useState("month");
  const [subBusy, setSubBusy] = useState("");
  // Oude afreken-/portaalfout niet laten blijven hangen zodra de laag actief wordt.
  useEffect(() => { if (tier && tier !== "free") setErr(""); }, [tier]);
  const [panel, setPanel] = useState(""); // "" | email | pw | delete
  const [newEmail, setNewEmail] = useState("");
  const [newPw, setNewPw] = useState("");
  const [newsOn, setNewsOn] = useState(() => { try { const v = localStorage.getItem("hf_newsletter"); return v === null ? true : v === "1"; } catch (e) { return true; } });
  const [name, setName] = useState(() => (session && session.user && session.user.user_metadata && session.user.user_metadata.display_name) || (() => { try { return localStorage.getItem("hf_name") || ""; } catch (e) { return ""; } })());
  const [nameSaved, setNameSaved] = useState(false);
  async function saveName() {
    const v = name.trim();
    try { localStorage.setItem("hf_name", v); } catch (e) {}
    if (supabase && session) { try { await supabase.auth.updateUser({ data: { display_name: v } }); } catch (e) {} }
    setNameSaved(true); setTimeout(() => setNameSaved(false), 1500);
  }

  function setNewsletter(email, on) {
    try { localStorage.setItem("hf_newsletter", on ? "1" : "0"); } catch (e) {}
    fetch("/api/newsletter", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ email, on }) }).catch(() => {});
  }

  async function submit() {
    if (!supabase) return;
    setErr(""); setMsg(""); setBusy(true);
    try {
      if (mode === "forgot") {
        const { error } = await supabase.auth.resetPasswordForEmail(email.trim(), { redirectTo: window.location.origin });
        if (error) throw error;
        setMsg(t("resetSent"));
      } else if (mode === "signup") {
        const { error } = await supabase.auth.signUp({ email: email.trim(), password: pw });
        if (error) throw error;
        if (news) setNewsletter(email.trim().toLowerCase(), true);
        setMsg(t("checkMail"));
      } else {
        const { error } = await supabase.auth.signInWithPassword({ email: email.trim(), password: pw });
        if (error) throw error;
        onClose();
      }
    } catch (e) { setErr(e && e.message ? e.message : "error"); } finally { setBusy(false); }
  }
  async function logout() { try { await supabase.auth.signOut(); } catch (e) {} onClose(); }

  async function saveNewPw(closeAfter) {
    if (!newPw) return;
    setErr(""); setMsg(""); setBusy(true);
    try {
      const { error } = await supabase.auth.updateUser({ password: newPw });
      if (error) throw error;
      setNewPw(""); setMsg(t("pwChanged")); setPanel("");
      if (closeAfter) onClose();
    } catch (e) { setErr(e && e.message ? e.message : "error"); } finally { setBusy(false); }
  }
  async function saveNewEmail() {
    if (!newEmail.trim()) return;
    setErr(""); setMsg(""); setBusy(true);
    try {
      const { error } = await supabase.auth.updateUser({ email: newEmail.trim() });
      if (error) throw error;
      setNewEmail(""); setMsg(t("emailChangeSent")); setPanel("");
    } catch (e) { setErr(e && e.message ? e.message : "error"); } finally { setBusy(false); }
  }
  async function deleteAccount() {
    if (!session) return;
    setErr(""); setBusy(true);
    try {
      const r = await fetch("/api/delete-account", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ authToken: session.access_token }) });
      const d = await r.json().catch(() => ({}));
      if (!d || !d.ok) throw new Error((d && d.error) || "error");
      try { await supabase.auth.signOut(); } catch (e) {}
      try { localStorage.clear(); } catch (e) {}
      onClose();
    } catch (e) { setErr(t("delErr")); setBusy(false); }
  }

  async function upgrade(plan) {
    if (!session) return;
    setErr(""); setSubBusy(plan);
    try {
      const r = await fetch("/api/create-subscription", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ userId: session.user.id, email: session.user.email, tier: plan, interval: billInterval }) });
      const d = await r.json().catch(() => ({}));
      if (d && d.url) { window.location.href = d.url; return; }
      setErr(d && d.error === "not_configured" ? t("notConfigured") : (d && d.detail) || "error");
    } catch (e) { setErr(t("notConfigured")); } finally { setSubBusy(""); }
  }
  async function portal() {
    if (!session) return;
    setErr(""); setSubBusy("portal");
    try {
      const r = await fetch("/api/billing-portal", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ authToken: session.access_token }) });
      const d = await r.json().catch(() => ({}));
      if (d && d.url) { window.location.href = d.url; return; }
      setErr(t("notConfigured"));
    } catch (e) { setErr(t("notConfigured")); } finally { setSubBusy(""); }
  }

  const planCard = (plan) => {
    const price = PRICE[plan][billInterval];
    const popular = plan === "pro";
    return (
      <div style={{ position: "relative", background: INK2, border: `1px solid ${popular ? EMBER : LINE}`, borderRadius: 12, padding: 11, marginBottom: 8 }}>
        {popular && <div style={{ position: "absolute", top: -9, right: 12, background: EMBER, color: PAPER, fontSize: 9.5, fontWeight: 700, ...disp, letterSpacing: 0.8, textTransform: "uppercase", padding: "2px 8px", borderRadius: 5 }}>{t("popular")}</div>}
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", marginBottom: 6 }}>
          <div style={{ ...disp, fontSize: 16, fontWeight: 700, color: PAPER, textTransform: "uppercase", letterSpacing: 0.5 }}>{t(plan + "Name")}</div>
          <div style={{ ...disp, fontSize: 19, fontWeight: 700, color: popular ? EMBER : PAPER }}>{price}<span style={{ fontSize: 11, color: MUTED, fontWeight: 500 }}>{billInterval === "year" ? t("perYr") : t("perMo")}</span></div>
        </div>
        <div style={{ fontSize: 11.5, color: MUTED, lineHeight: 1.45, marginBottom: 9 }}>{t(plan + "Feat")}</div>
        <button onClick={() => upgrade(plan)} disabled={!!subBusy} style={{ ...(popular ? primaryBtn : ghostBtn), width: "100%", padding: "10px 0", opacity: subBusy ? 0.7 : 1 }}>{subBusy === plan ? t("busy") : t("choose")}</button>
      </div>
    );
  };

  const shell = (children) => (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 60, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} className="hf-modal" style={{ position: "relative", background: INK, border: `1px solid ${LINE}`, borderRadius: 20, width: "100%", maxWidth: 420, maxHeight: "90dvh", overflowY: "auto", padding: 18, boxShadow: "0 24px 70px rgba(0,0,0,.65)", backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.13), transparent 58%)" }}>
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

  const toggle = (on, onClick) => (
    <div onClick={onClick} style={{ width: 46, height: 26, borderRadius: 20, background: on ? EMBER : LINE, position: "relative", cursor: "pointer", transition: "background .2s", flexShrink: 0 }}>
      <div style={{ position: "absolute", top: 3, left: on ? 23 : 3, width: 20, height: 20, borderRadius: "50%", background: PAPER, transition: "left .2s" }} />
    </div>
  );
  const linkRow = (lbl, onClick, danger) => (
    <div onClick={onClick} style={{ cursor: "pointer", display: "flex", justifyContent: "space-between", alignItems: "center", padding: "9px 0", borderBottom: `1px solid ${LINE}`, color: danger ? EMBER_SOFT : PAPER, fontSize: 13, fontWeight: 600 }}>
      <span>{lbl}</span><span style={{ color: MUTED }}>›</span>
    </div>
  );

  if (!supaReady || !supabase) {
    return shell(<div style={{ fontSize: 13, color: MUTED, lineHeight: 1.6 }}>{t("notReady")}</div>);
  }

  // Wachtwoord-herstel: na klikken op de reset-mail landt de gebruiker hier.
  if (recovery) {
    return shell(
      <div>
        <div style={sectionTitle}>{t("setNewPw")}</div>
        <div style={{ margin: "14px 0 10px" }}>
          <label style={label}>{t("newPwPh")}</label>
          <input style={input} type="password" value={newPw} onChange={(e) => setNewPw(e.target.value)} autoComplete="new-password" />
        </div>
        <button onClick={() => saveNewPw(true)} disabled={busy} style={{ ...primaryBtn, opacity: busy ? 0.7 : 1 }}>{busy ? t("busy") : t("save")}</button>
        {err && <div style={{ fontSize: 12, color: EMBER_SOFT, marginTop: 10, lineHeight: 1.4 }}>{err}</div>}
        {msg && <div style={{ fontSize: 12.5, color: "#4ADE80", marginTop: 10 }}>{msg}</div>}
      </div>
    );
  }

  if (session) {
    return shell(
      <div>
        <div style={{ fontSize: 12, color: MUTED }}>{t("loggedInAs")}</div>
        <div style={{ ...disp, fontSize: 16, fontWeight: 600, marginTop: 2, marginBottom: 10, wordBreak: "break-all" }}>{session.user.email}</div>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "9px 12px", background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, marginBottom: 12 }}>
          <span style={{ fontSize: 12, color: MUTED }}>{t("tier")}</span>
          <span style={{ ...disp, fontSize: 13, fontWeight: 700, color: tier && tier !== "free" ? EMBER : MUTED, textTransform: "uppercase", letterSpacing: 1 }}>{tier || "free"}{tier && tier !== "free" ? " · " + t("active") : ""}</span>
        </div>

        {(!tier || tier === "free") ? (
          <div style={{ marginBottom: 10 }}>
            <div style={sectionTitle}>{t("upgradeTitle")}</div>
            <div style={{ display: "inline-flex", gap: 4, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4, margin: "8px 0 10px" }}>
              {[["month", t("month")], ["year", t("year")]].map(([id, lbl]) => (
                <div key={id} onClick={() => setBillInterval(id)} style={{ padding: "7px 16px", borderRadius: 7, background: billInterval === id ? EMBER : "transparent", color: PAPER, fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.5, cursor: "pointer" }}>{lbl}</div>
              ))}
              {billInterval === "year" && <div style={{ alignSelf: "center", fontSize: 10.5, color: EMBER_SOFT, fontWeight: 700, padding: "0 8px", ...disp, letterSpacing: 0.3 }}>{t("freeMonths")}</div>}
            </div>
            {planCard("basis")}
            {planCard("pro")}
          </div>
        ) : (
          <button onClick={portal} disabled={!!subBusy} style={{ ...ghostBtn, width: "100%", marginBottom: 16, opacity: subBusy ? 0.7 : 1 }}>{subBusy === "portal" ? t("busy") : t("manage")}</button>
        )}

        {/* Instellingen */}
        <div style={{ ...sectionTitle, marginBottom: 8 }}>{t("settings")}</div>
        <div style={{ padding: "9px 0", borderBottom: `1px solid ${LINE}` }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 6 }}>
            <span style={{ fontSize: 13, color: PAPER, fontWeight: 600 }}>{t("nameLbl")}</span>
            {nameSaved && <span style={{ fontSize: 11, color: "#4ADE80", fontWeight: 600 }}>{t("nameSavedTxt")}</span>}
          </div>
          <input value={name} onChange={(e) => setName(e.target.value)} onBlur={saveName} placeholder={t("namePh")} style={input} />
        </div>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "9px 0", borderBottom: `1px solid ${LINE}` }}>
          <span style={{ fontSize: 13, color: PAPER, fontWeight: 600 }}>{t("newsletterLbl")}</span>
          {toggle(newsOn, () => { const v = !newsOn; setNewsOn(v); setNewsletter(session.user.email, v); })}
        </div>

        {linkRow(t("changeEmail"), () => { setPanel(panel === "email" ? "" : "email"); setErr(""); setMsg(""); })}
        {panel === "email" && (
          <div style={{ padding: "10px 0 12px" }}>
            <input style={{ ...input, marginBottom: 8 }} type="email" value={newEmail} onChange={(e) => setNewEmail(e.target.value)} placeholder={t("newEmailPh")} />
            <button onClick={saveNewEmail} disabled={busy} style={{ ...primaryBtn, opacity: busy ? 0.7 : 1 }}>{busy ? t("busy") : t("save")}</button>
          </div>
        )}
        {linkRow(t("changePw"), () => { setPanel(panel === "pw" ? "" : "pw"); setErr(""); setMsg(""); })}
        {panel === "pw" && (
          <div style={{ padding: "10px 0 12px" }}>
            <input style={{ ...input, marginBottom: 8 }} type="password" value={newPw} onChange={(e) => setNewPw(e.target.value)} placeholder={t("newPwPh")} autoComplete="new-password" />
            <button onClick={() => saveNewPw(false)} disabled={busy} style={{ ...primaryBtn, opacity: busy ? 0.7 : 1 }}>{busy ? t("busy") : t("save")}</button>
          </div>
        )}
        {linkRow(t("delAccount"), () => { setPanel(panel === "delete" ? "" : "delete"); setErr(""); setMsg(""); }, true)}
        {panel === "delete" && (
          <div style={{ padding: "12px 0" }}>
            <div style={{ fontSize: 12, color: MUTED, lineHeight: 1.5, marginBottom: 12 }}>{t("delConfirm")}</div>
            <div style={{ display: "flex", gap: 8 }}>
              <button onClick={deleteAccount} disabled={busy} style={{ flex: 1, background: EMBER, color: PAPER, border: "none", padding: "12px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 13.5, letterSpacing: 0.5, cursor: "pointer", opacity: busy ? 0.7 : 1 }}>{busy ? t("deleting") : t("delYes")}</button>
              <button onClick={() => setPanel("")} style={{ ...ghostBtn }}>{t("cancel")}</button>
            </div>
          </div>
        )}

        {err && <div style={{ fontSize: 12, color: EMBER_SOFT, margin: "12px 0", lineHeight: 1.4 }}>{err}</div>}
        {msg && <div style={{ fontSize: 12.5, color: "#4ADE80", margin: "12px 0", lineHeight: 1.5 }}>{msg}</div>}
        <button onClick={logout} style={{ ...ghostBtn, width: "100%", marginTop: 12 }}>{t("logout")}</button>
      </div>
    );
  }

  // Wachtwoord vergeten
  if (mode === "forgot") {
    return shell(
      <div>
        <div style={sectionTitle}>{t("resetTitle")}</div>
        <div style={{ margin: "14px 0 10px" }}>
          <label style={label}>{t("email")}</label>
          <input style={input} type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="jij@email.com" autoComplete="email" />
        </div>
        <button onClick={submit} disabled={busy} style={{ ...primaryBtn, opacity: busy ? 0.7 : 1 }}>{busy ? t("busy") : t("resetBtn")}</button>
        {err && <div style={{ fontSize: 12, color: EMBER_SOFT, marginTop: 10, lineHeight: 1.4 }}>{err}</div>}
        {msg && <div style={{ fontSize: 12.5, color: "#4ADE80", marginTop: 10 }}>{msg}</div>}
        <div onClick={() => { setMode("login"); setErr(""); setMsg(""); }} style={{ fontSize: 12, color: MUTED, marginTop: 14, textAlign: "center", cursor: "pointer" }}>{t("backToLogin")}</div>
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
      <div style={{ marginBottom: mode === "login" ? 8 : 12 }}>
        <label style={label}>{t("pw")}</label>
        <input style={input} type="password" value={pw} onChange={(e) => setPw(e.target.value)} autoComplete={mode === "signup" ? "new-password" : "current-password"} />
      </div>
      {mode === "login" && (
        <div onClick={() => { setMode("forgot"); setErr(""); setMsg(""); }} style={{ fontSize: 12, color: MUTED, textAlign: "right", cursor: "pointer", marginBottom: 14 }}>{t("forgot")}</div>
      )}
      {mode === "signup" && (
        <div onClick={() => setNews(!news)} style={{ display: "flex", alignItems: "center", gap: 10, cursor: "pointer", marginBottom: 14 }}>
          <div style={{ width: 20, height: 20, borderRadius: 6, border: `2px solid ${news ? EMBER : MUTED}`, background: news ? EMBER : "transparent", display: "flex", alignItems: "center", justifyContent: "center", color: PAPER, fontSize: 12, fontWeight: 800, flexShrink: 0 }}>{news ? "✓" : ""}</div>
          <span style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.4 }}>{t("newsletter")}</span>
        </div>
      )}
      <button onClick={submit} disabled={busy} style={{ ...primaryBtn, opacity: busy ? 0.7 : 1 }}>{busy ? t("busy") : mode === "signup" ? t("signupBtn") : t("loginBtn")}</button>
      {err && <div style={{ fontSize: 12, color: EMBER_SOFT, marginTop: 10, lineHeight: 1.4 }}>{err}</div>}
      {msg && <div style={{ fontSize: 12.5, color: "#4ADE80", marginTop: 10, lineHeight: 1.5 }}>{msg}</div>}
      <div onClick={() => { setMode(mode === "login" ? "signup" : "login"); setErr(""); setMsg(""); }} style={{ fontSize: 12, color: MUTED, marginTop: 14, textAlign: "center", cursor: "pointer" }}>
        {mode === "login" ? t("switchToSignup") : t("switchToLogin")}
      </div>
    </div>
  );
}
