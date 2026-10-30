// Backend base-URL.
// Web-build: leeg => relatieve /api-calls (werkt op elke origin, incl. Vercel previews).
// Native build (Capacitor): zet VITE_API_BASE op de live backend, zodat /api de
// Vercel-functies bereikt. Zie CAPACITOR.md.
export const API_BASE = import.meta.env.VITE_API_BASE || "";
export const apiUrl = (path) => API_BASE + path;
