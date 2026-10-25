// Supabase-client. URL + publieke (anon/publishable) key komen uit env-vars.
// Zet in Vercel (en lokaal in .env) :
//   VITE_SUPABASE_URL       = https://tkmyjpsmdijaalwgzqdy.supabase.co
//   VITE_SUPABASE_ANON_KEY  = sb_publishable_...   (publiek, veilig in de browser)
// Ontbreekt de key, dan is supabase null en werkt de app gewoon verder zonder login.
import { createClient } from "@supabase/supabase-js";

const url = import.meta.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co";
const key = import.meta.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";

export const supaReady = !!(url && key);
export const supabase = supaReady ? createClient(url, key, { auth: { persistSession: true, autoRefreshToken: true } }) : null;
