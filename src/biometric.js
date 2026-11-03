// Vingerafdruk-/biometrie-slot (alleen native app). Op web doet dit niets.
import { Capacitor } from "@capacitor/core";

let _plugin = null;
async function plugin() {
  if (_plugin) return _plugin;
  try { const m = await import("@aparajita/capacitor-biometric-auth"); _plugin = m.BiometricAuth; return _plugin; } catch (e) { return null; }
}

export function bioNative() {
  try { return Capacitor.isNativePlatform(); } catch (e) { return false; }
}

// Is er biometrie beschikbaar/ingesteld op het toestel?
export async function bioAvailable() {
  if (!bioNative()) return false;
  const p = await plugin();
  if (!p) return false;
  try { const r = await p.checkBiometry(); return !!(r && (r.isAvailable || r.strongBiometryIsAvailable)); } catch (e) { return false; }
}

// Vraag om vingerafdruk/gezicht; true = gelukt.
export async function bioVerify(reasonNl) {
  if (!bioNative()) return true;
  const p = await plugin();
  if (!p) return false;
  try {
    await p.authenticate({
      reason: reasonNl || "Ontgrendel de app",
      cancelTitle: "Annuleren",
      allowDeviceCredential: true,
      androidTitle: "Ontgrendelen",
      androidSubtitle: "Gebruik je vingerafdruk of gezicht",
      iosFallbackTitle: "Gebruik toegangscode",
    });
    return true;
  } catch (e) { return false; }
}
