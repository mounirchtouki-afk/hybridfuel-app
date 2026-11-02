/* Boot-script, geladen vanaf 'self' zodat de strikte CSP (geen 'unsafe-inline') het toestaat.
   1) Past de gecachte org-huisstijl toe vóór de eerste paint (geen rood->klantkleur-flits).
   2) Laadt de cookie-consent alleen op web (niet in de native Capacitor-app). */
(function () {
  // 1) Pre-paint org-huisstijl.
  try {
    var raw = localStorage.getItem("hf_org_theme");
    if (raw) {
      var t = JSON.parse(raw);
      var el = document.documentElement;
      Object.keys(t).forEach(function (k) { if (t[k]) el.style.setProperty("--hf-" + k, t[k]); });
    }
  } catch (e) {}

  // 2) Cookie-consent (web-only), na DOM-ready zodat body + Capacitor klaar zijn.
  function loadConsent() {
    try {
      var native = !!(window.Capacitor && window.Capacitor.isNativePlatform && window.Capacitor.isNativePlatform());
      if (native) return;
      var s = document.createElement("script");
      s.src = "https://www.hybridfuelco.com/consent.js?v=2";
      (document.body || document.documentElement).appendChild(s);
    } catch (e) {}
  }
  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", loadConsent);
  else loadConsent();
})();
