// Cloud-sync voor de data die nog localStorage-only was: kalender-afwijkingen,
// trainingslogs en het trainingsweekschema. Volgt de klant zo over apparaten.
//
// Werking (bewust simpel + veilig):
//  - We "patchen" localStorage.setItem/removeItem één keer. Elke wijziging aan een
//    gevolgde sleutel wordt fire-and-forget naar Supabase (tabel app_kv) geschreven.
//  - Bij login halen we alle gevolgde sleutels op en zetten ze in localStorage.
//  - Bestaat de tabel/opslag niet (of geen sessie): alle calls falen stil → no-op,
//    de app werkt exact zoals voorheen (localStorage). Volledig backward compatible.
//  - Geen push-loop: de pull schrijft via de ORIGINELE setItem, niet de gepatchte.
import { supabase } from "./supabaseClient.js";

const PREFIXES = ["hf_dayover_", "hf_workouts_", "hf_trainover_"];
const KEYS = ["hf_trainplan", "hf_planned"];
function tracked(k) {
  return typeof k === "string" && (KEYS.includes(k) || PREFIXES.some((p) => k.startsWith(p)));
}

let _sess = null;
let _patched = false;
let _origSet = null;

function uid() { return _sess && _sess.user && _sess.user.id; }

function pushRaw(k, vStr) {
  const id = uid();
  if (!id || !supabase) return;
  let v;
  try { v = JSON.parse(vStr); } catch (e) { v = vStr; }
  try {
    supabase.from("app_kv")
      .upsert({ user_id: id, k, v, updated_at: new Date().toISOString() }, { onConflict: "user_id,k" })
      .then(() => {}, () => {});
  } catch (e) {}
}

function delKey(k) {
  const id = uid();
  if (!id || !supabase) return;
  try {
    supabase.from("app_kv").delete().eq("user_id", id).eq("k", k).then(() => {}, () => {});
  } catch (e) {}
}

// Zet de huidige sessie en patcht localStorage één keer. Elke keer aanroepen bij
// een sessiewisseling is veilig (werkt de sessie bij, patcht niet opnieuw).
export function initCloudSync(session) {
  _sess = session || null;
  if (_patched || typeof window === "undefined" || !window.localStorage) return;
  _patched = true;
  try {
    _origSet = localStorage.setItem.bind(localStorage);
    const origRem = localStorage.removeItem.bind(localStorage);
    localStorage.setItem = function (k, v) { _origSet(k, v); if (tracked(k)) pushRaw(k, v); };
    localStorage.removeItem = function (k) { origRem(k); if (tracked(k)) delKey(k); };
  } catch (e) { _patched = false; }
}

// Haal bij login alle gevolgde sleutels op en schrijf ze in localStorage.
// Schrijft via de originele setItem zodat er geen push terug naar de cloud gebeurt.
export async function pullAll(session) {
  if (!session || !supabase) return;
  try {
    const { data } = await supabase.from("app_kv").select("k,v").eq("user_id", session.user.id);
    if (!data || !data.length) return;
    const put = _origSet || localStorage.setItem.bind(localStorage);
    data.forEach((row) => {
      if (tracked(row.k) && row.v != null) {
        try { put(row.k, JSON.stringify(row.v)); } catch (e) {}
      }
    });
  } catch (e) {}
}
