import React, { useState } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, disp, label, input, card, sectionTitle, primaryBtn, ghostBtn, load, save, todayISO } from "../shared.js";

const T = {
  title: { nl: "Herinneringen", en: "Reminders" },
  intro: { nl: "Zet herinneringen aan om op koers te blijven. Werkt het best als je de app op je beginscherm zet (geïnstalleerd).", en: "Turn on reminders to stay on track. Works best with the app installed on your home screen." },
  enable: { nl: "Notificaties aanzetten", en: "Enable notifications" },
  enabled: { nl: "Notificaties staan aan ✓", en: "Notifications are on ✓" },
  denied: { nl: "Notificaties zijn geblokkeerd in je browser-instellingen. Zet ze daar aan om herinneringen te krijgen.", en: "Notifications are blocked in your browser settings. Enable them there to get reminders." },
  weighIn: { nl: "Dagelijkse weeg-herinnering", en: "Daily weigh-in reminder" },
  weighSub: { nl: "Elke ochtend even op de weegschaal.", en: "A nudge to step on the scale each morning." },
  atTime: { nl: "Om", en: "At" },
  water: { nl: "Water-herinnering (rond het middaguur)", en: "Hydration reminder (around midday)" },
  weekly: { nl: "Wekelijks: nieuw weekplan (maandag)", en: "Weekly: new week plan (Monday)" },
  test: { nl: "Stuur test-melding", en: "Send test notification" },
  iosNote: { nl: "Let op: op iPhone werken herinneringen alleen als je de app via Safari op je beginscherm hebt gezet, en zijn ze minder betrouwbaar dan op Android. Echt geplande meldingen (ook als de app dicht is) volgen later.", en: "Note: on iPhone, reminders only work if you've added the app to your home screen via Safari, and are less reliable than on Android. Fully scheduled push (even when the app is closed) comes later." },
  close: { nl: "Klaar", en: "Done" },
};

const NOTIF = {
  weighIn: { title: { nl: "Tijd om te wegen ⚖️", en: "Time to weigh in ⚖️" }, body: { nl: "Log je gewicht in HybridFuelCo — 10 seconden werk.", en: "Log your weight in HybridFuelCo — takes 10 seconds." } },
  water: { title: { nl: "Drink wat water 💧", en: "Drink some water 💧" }, body: { nl: "Blijf gehydrateerd — zeker op trainingsdagen.", en: "Stay hydrated — especially on training days." } },
  weekly: { title: { nl: "Nieuwe week 🔥", en: "New week 🔥" }, body: { nl: "Genereer je weekplan opnieuw voor deze week.", en: "Regenerate your meal plan for this week." } },
  test: { title: { nl: "HybridFuelCo", en: "HybridFuelCo" }, body: { nl: "Zo zien je herinneringen eruit. 💪", en: "This is what your reminders look like. 💪" } },
};

function notify(key, lang) {
  const title = NOTIF[key].title[lang], body = NOTIF[key].body[lang];
  try {
    if (navigator.serviceWorker && navigator.serviceWorker.ready) {
      navigator.serviceWorker.ready.then((reg) => reg.showNotification(title, { body, icon: "/icon-192.png", badge: "/icon-192.png" })).catch(() => { try { new Notification(title, { body }); } catch (e) {} });
    } else { new Notification(title, { body }); }
  } catch (e) {}
}

// Best-effort lokale planner: draait vanuit App (bij openen + interval + terugkeren).
export function checkReminders(lang) {
  try {
    if (!("Notification" in window) || Notification.permission !== "granted") return;
    const s = load("hf_reminders", {});
    const fired = load("hf_rem_fired", {});
    const now = new Date(), today = todayISO();
    const mark = (k) => { fired[k] = today; save("hf_rem_fired", fired); };
    const hhmm = String(now.getHours()).padStart(2, "0") + ":" + String(now.getMinutes()).padStart(2, "0");

    if (s.weighIn && hhmm >= (s.weighTime || "08:00") && fired["weighIn"] !== today) { notify("weighIn", lang); mark("weighIn"); }
    if (s.water && now.getHours() >= 12 && fired["water"] !== today) { notify("water", lang); mark("water"); }
    if (s.weekly && now.getDay() === 1 && now.getHours() >= 8) {
      const wk = today; if (fired["weekly"] !== wk) { notify("weekly", lang); fired["weekly"] = wk; save("hf_rem_fired", fired); }
    }
  } catch (e) {}
}

export default function Reminders({ lang, onClose }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const [perm, setPerm] = useState(() => (typeof Notification !== "undefined" ? Notification.permission : "unsupported"));
  const [s, setS] = useState(() => load("hf_reminders", { weighIn: false, weighTime: "08:00", water: false, weekly: false }));

  function update(next) { setS(next); save("hf_reminders", next); }
  async function enable() {
    try { const p = await Notification.requestPermission(); setPerm(p); } catch (e) {}
  }

  const Toggle = ({ on, onClick }) => (
    <div onClick={onClick} style={{ width: 44, height: 26, borderRadius: 13, background: on ? EMBER : LINE, position: "relative", cursor: "pointer", flexShrink: 0, transition: "background .15s" }}>
      <div style={{ width: 20, height: 20, borderRadius: "50%", background: PAPER, position: "absolute", top: 3, left: on ? 21 : 3, transition: "left .15s" }} />
    </div>
  );
  const Row = ({ title, sub, on, onToggle, children }) => (
    <div style={{ padding: "13px 0", borderBottom: `1px solid ${LINE}` }}>
      <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
        <div style={{ flex: 1 }}>
          <div style={{ fontSize: 13.5, fontWeight: 600 }}>{title}</div>
          {sub && <div style={{ fontSize: 11.5, color: MUTED, marginTop: 2, lineHeight: 1.4 }}>{sub}</div>}
        </div>
        <Toggle on={on} onClick={onToggle} />
      </div>
      {on && children}
    </div>
  );

  const granted = perm === "granted";

  return (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.6)", zIndex: 50, display: "flex", alignItems: "flex-end", justifyContent: "center" }}>
      <div onClick={(e) => e.stopPropagation()} style={{ background: INK, borderTop: `1px solid ${LINE}`, borderRadius: "18px 18px 0 0", width: "100%", maxWidth: 480, maxHeight: "88vh", overflowY: "auto", padding: 20, boxShadow: "0 -10px 40px rgba(0,0,0,.5)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 6 }}>
          <div style={sectionTitle}>{t("title")}</div>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 22, lineHeight: 1 }}>×</div>
        </div>
        <div style={{ fontSize: 12, color: MUTED, lineHeight: 1.5, marginBottom: 14 }}>{t("intro")}</div>

        {!granted && perm !== "denied" && perm !== "unsupported" && (
          <button onClick={enable} style={{ ...primaryBtn, marginBottom: 14 }}>{t("enable")}</button>
        )}
        {granted && <div style={{ fontSize: 12.5, color: "#4ADE80", marginBottom: 10, fontWeight: 600 }}>{t("enabled")}</div>}
        {perm === "denied" && <div style={{ fontSize: 12, color: EMBER_SOFT, marginBottom: 12, lineHeight: 1.5 }}>{t("denied")}</div>}

        <div style={{ opacity: granted ? 1 : 0.5, pointerEvents: granted ? "auto" : "none" }}>
          <Row title={t("weighIn")} sub={t("weighSub")} on={s.weighIn} onToggle={() => update({ ...s, weighIn: !s.weighIn })}>
            <div style={{ display: "flex", alignItems: "center", gap: 10, marginTop: 10 }}>
              <span style={{ fontSize: 12, color: MUTED }}>{t("atTime")}</span>
              <input type="time" value={s.weighTime || "08:00"} onChange={(e) => update({ ...s, weighTime: e.target.value })} style={{ ...input, width: 130 }} />
            </div>
          </Row>
          <Row title={t("water")} on={s.water} onToggle={() => update({ ...s, water: !s.water })} />
          <Row title={t("weekly")} on={s.weekly} onToggle={() => update({ ...s, weekly: !s.weekly })} />
        </div>

        {granted && <button onClick={() => notify("test", lang)} style={{ ...ghostBtn, width: "100%", marginTop: 14 }}>{t("test")}</button>}

        <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5, marginTop: 14, padding: "10px 12px", background: INK2, borderRadius: 10, border: `1px solid ${LINE}` }}>{t("iosNote")}</div>

        <button onClick={onClose} style={{ ...primaryBtn, marginTop: 14 }}>{t("close")}</button>
      </div>
    </div>
  );
}
