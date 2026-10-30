import { Capacitor } from "@capacitor/core";

// Native-only initialisatie: statusbalk netjes zetten zodat de app-header niet
// onder de klok/batterij valt, en de splash verbergen zodra de app staat.
// Op web doet dit niets.
export async function initNative() {
  if (!Capacitor.isNativePlatform()) return;

  try {
    const { StatusBar, Style } = await import("@capacitor/status-bar");
    // Moderne Android (API 35+) dwingt edge-to-edge af: de webview tekent onder
    // de statusbalk. We omarmen dat (overlay true) en vangen de hoogte op met
    // env(safe-area-inset-top) in de header-CSS. Style.Dark = lichte iconen.
    await StatusBar.setOverlaysWebView({ overlay: true });
    await StatusBar.setStyle({ style: Style.Dark });
  } catch (e) {
    console.warn("[native] statusbar init", e);
  }

  try {
    const { SplashScreen } = await import("@capacitor/splash-screen");
    await SplashScreen.hide();
  } catch (e) {}
}
