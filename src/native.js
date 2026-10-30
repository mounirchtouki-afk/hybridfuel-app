import { Capacitor } from "@capacitor/core";

// Native-only initialisatie: statusbalk netjes zetten zodat de app-header niet
// onder de klok/batterij valt, en de splash verbergen zodra de app staat.
// Op web doet dit niets.
export async function initNative() {
  if (!Capacitor.isNativePlatform()) return;

  try {
    const { StatusBar, Style } = await import("@capacitor/status-bar");
    // Webview onder de statusbalk laten beginnen (geen overlap).
    await StatusBar.setOverlaysWebView({ overlay: false });
    await StatusBar.setBackgroundColor({ color: "#0A0A0A" });
    // Style.Dark = donkere balk met lichte (witte) iconen.
    await StatusBar.setStyle({ style: Style.Dark });
  } catch (e) {
    console.warn("[native] statusbar init", e);
  }

  try {
    const { SplashScreen } = await import("@capacitor/splash-screen");
    await SplashScreen.hide();
  } catch (e) {}
}
