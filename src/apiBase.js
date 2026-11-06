// Backend base-URL.
// Web-build: leeg => relatieve /api-calls (werkt op elke origin, incl. Vercel previews).
// Native build (Capacitor): zet VITE_API_BASE op de live backend, zodat /api de
// Vercel-functies bereikt. Zie CAPACITOR.md.
import { Capacitor } from "@capacitor/core";
export const API_BASE = import.meta.env.VITE_API_BASE || "";
export const apiUrl = (path) => API_BASE + path;

const IS_NATIVE = (() => { try { return Capacitor.isNativePlatform(); } catch (e) { return false; } })();

// Publiek webdomein van deze app (met gym-backend): waar /join/<slug>, wachtwoord-
// reset en de dashboard-login leven. Op native kan window.location.origin NIET
// gebruikt worden (dat is https://localhost), dus daar gebruiken we deze vaste basis.
// Zet VITE_WEB_BASE op het hoofddomein. Het coach-dashboard leeft op <WEB_BASE>/admin.
export const WEB_BASE = (import.meta.env.VITE_WEB_BASE || "https://hybridfuelco.com").replace(/\/+$/, "");
export const ADMIN_URL = WEB_BASE + "/admin";

// Gebruik dit overal waar je een deelbare/absolute web-URL nodig hebt (join-links,
// e-maillinks, reset-redirects). Web: de echte origin; native: de vaste WEB_BASE.
export const webBase = () => {
  if (!IS_NATIVE) { try { return window.location.origin; } catch (e) {} }
  return WEB_BASE;
};
