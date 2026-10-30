# Native app (Capacitor) — setup & vervolgstappen

De app is met **Capacitor 8** omgezet naar een native shell voor iOS en Android, bovenop de bestaande React/Vite-code. ~95% van de code wordt hergebruikt; dit is geen rewrite.

## Wat er nu staat (branch `capacitor-wrap`)
- `@capacitor/core` + `@capacitor/cli` + plugins: `app`, `push-notifications`, `status-bar`, `splash-screen`.
- `capacitor.config.ts` — appId `com.hybridfuelco.app`, appName `HybridFuelCo`, splash in huisstijl (#0A0A0A).
- **Android-platform** toegevoegd (`android/`) en gesynct met de build.
- npm-scripts: `cap:sync`, `cap:android`, `cap:ios`.

## Serveermodus — nu: live laden (werkt meteen)
`capacitor.config.ts` heeft nu `server.url = https://app.hybridfuelco.com`. De app laadt de live site in de native shell. **Waarom:** alle `/api/...`-calls in de code zijn relatief; zo werken ze direct zonder refactor. Nadeel: geen offline, en Apple kan een pure "web wrapper" weigeren (richtlijn 4.2).

### Vervolgstap: naar gebundelde assets (store-klaar + offline)
Voor review-vriendelijk en offline:
1. Verwijder het `server`-blok uit `capacitor.config.ts` (dan serveert Capacitor de gebundelde `dist`).
2. Maak de API-calls **absoluut**: introduceer één base-URL (bv. `const API = import.meta.env.VITE_API_BASE ?? ''`) en vervang `fetch("/api/...")` door `fetch(API + "/api/...")`. In de web-build blijft `API=''` (relatief), in de native build zet je `VITE_API_BASE=https://app.hybridfuelco.com`.
3. Zorg dat CORS op de Vercel-functies de native origin toestaat (`capacitor://localhost` op iOS, `https://localhost` op Android) — of los het op via het Capacitor-http-plugin.
Dit is bewust een aparte stap; de huidige opzet werkt al als eerste native build.

## iOS-platform (alleen op een Mac)
iOS kan niet op Linux gebouwd worden. Op een Mac met Xcode + CocoaPods:
```
npm install
npx cap add ios
npm run cap:ios      # build + sync + open Xcode
```

## Accounts (eenmalig, dit duurt even)
- **Apple Developer Program** — ~$99/jaar. Verificatie kan dagen duren; nu alvast aanvragen.
- **Google Play Console** — ~$25 eenmalig.

## Push-notificaties
`@capacitor/push-notifications` staat erin. Nog instellen:
- **Android:** Firebase-project aanmaken → `google-services.json` in `android/app/` plaatsen (FCM).
- **iOS:** APNs-key in het Apple Developer-account + Push-capability in Xcode.
- Server-kant: een endpoint dat device-tokens opslaat en pushes verstuurt (via FCM/APNs). Later koppelen aan de bestaande Make-flows.

## App-icoon & splash
Lever één icoon (1024×1024) + splash aan, dan genereren met:
```
npm i -D @capacitor/assets
npx capacitor-assets generate
```
Huisstijl: zwart `#0A0A0A`, rood accent `#E11D48`.

## Dagelijkse workflow
```
npm run cap:sync      # bouwt de web-app en synct naar de native projecten
npm run cap:android   # + opent Android Studio
npm run cap:ios       # + opent Xcode (alleen Mac)
```

## Store-submissie checklist (als het zover is)
- Icoon + splash + screenshots per device.
- Privacy-labels / Data safety invullen — **let op: gezondheidsdata krijgt extra scrutiny**.
- Privacybeleid-URL (hebben we: hybridfuelco.com/privacy.html).
- Native waarde aantonen voor Apple 4.2 (push, offline, native gevoel).
- Testbuild via TestFlight (iOS) / interne test (Play) vóór publicatie.

## White-label (later, B2B)
Dezelfde app bedient de gym-editie. Begin met één app + in-app org-branding (gym kiest huisstijl ná login). Losse apps per gym pas bij echte betalende vraag (elke gym = eigen listing + review + onderhoud).
