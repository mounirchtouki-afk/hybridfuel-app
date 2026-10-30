import { Capacitor } from "@capacitor/core";
import { apiUrl } from "./apiBase";

// Registreert het toestel voor push-notificaties (FCM) op de native app.
// Op web doet dit niets (geen native platform).
export async function initPush() {
  if (!Capacitor.isNativePlatform()) return;
  try {
    const { PushNotifications } = await import("@capacitor/push-notifications");

    let perm = await PushNotifications.checkPermissions();
    if (perm.receive === "prompt" || perm.receive === "prompt-with-rationale") {
      perm = await PushNotifications.requestPermissions();
    }
    if (perm.receive !== "granted") return;

    await PushNotifications.register();

    PushNotifications.addListener("registration", (token) => {
      console.log("[push] FCM token:", token.value);
      // Optioneel: token naar de backend sturen als dat endpoint bestaat (nu guarded).
      try {
        fetch(apiUrl("/api/push-token"), {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ token: token.value, platform: Capacitor.getPlatform() }),
        }).catch(() => {});
      } catch (e) {}
    });
    PushNotifications.addListener("registrationError", (e) => console.warn("[push] registrationError", e));
    PushNotifications.addListener("pushNotificationReceived", (n) => console.log("[push] received", n));
    PushNotifications.addListener("pushNotificationActionPerformed", (a) => console.log("[push] action", a));
  } catch (e) {
    console.warn("[push] init failed", e);
  }
}
