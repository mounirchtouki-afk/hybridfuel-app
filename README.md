# HybridFuelCo Meal Plan — van prototype naar live web-app

Een complete, veilige web-app: frontend + backend-proxy in één. De Anthropic-key
zit serverzijdig, met rate-limit. Hieronder: wat het is, en hoe je het online zet
zonder developer te zijn.

---

## Wat zit erin

```
hybridfuel-app/
├─ api/plan.js        ← de backend-proxy (key verborgen, rate-limit, prompt serverzijdig)
├─ src/App.jsx        ← de frontend (roept /api/plan aan, nooit Claude direct)
├─ src/main.jsx       ← opstartbestand
├─ index.html         ← de pagina
├─ package.json       ← dependencies
└─ vite.config.js     ← build-config
```

De frontend stuurt alleen de ingevulde velden naar `/api/plan`. De backend
berekent de macro's, bouwt de prompt, roept Claude aan met jouw key, en stuurt
het resultaat terug. Zo kan niemand via je site iets anders dan maaltijdplannen
maken, en je key is nooit zichtbaar in de browser.

---

## STAP 0 — Harde uitgavenlimiet (doe dit EERST)

Dit is je vangnet tegen een leeggetrokken saldo, los van alle code.

1. Ga naar **console.anthropic.com** → log in / maak account.
2. **Billing** → voeg een betaalmethode toe en zet een klein tegoed (bijv. €20).
3. **Usage limits** → zet een **maandelijkse spend-limiet** (bijv. €20).
   Wat er ook gebeurt, je kunt nooit meer kwijt zijn dan dat.
4. **API keys** → **Create key** → kopieer de key (begint met `sk-ant-...`).
   Bewaar 'm even veilig; je plakt 'm zo in Vercel (niet in de code).

---

## STAP 1 — Zet de code op GitHub

Vercel haalt je code van GitHub. Geen terminal nodig.

1. Maak een gratis account op **github.com**.
2. Klik **+** rechtsboven → **New repository** → naam `hybridfuel-app` → **Create**.
3. Op de nieuwe pagina: **uploading an existing file**.
4. Sleep ALLE bestanden uit de `hybridfuel-app`-map hierheen —
   **inclusief de map `api` en de map `src`** (sleep de mappen zelf mee, zodat
   de structuur klopt). **Commit changes**.

> Let op: upload NIET een `.env` of je key. Die komt alleen in Vercel (stap 2).

---

## STAP 2 — Zet 'm live op Vercel

1. Ga naar **vercel.com** → **Sign up** → kies **Continue with GitHub**.
2. **Add New… → Project** → kies je `hybridfuel-app` repo → **Import**.
3. Vercel herkent Vite automatisch. Laat de build-instellingen staan.
4. Klap **Environment Variables** open en voeg toe:
   - **Name:** `ANTHROPIC_API_KEY`
   - **Value:** je key uit stap 0 (`sk-ant-...`)
   - Klik **Add**.
5. Klik **Deploy**. Wacht ~1 minuut.
6. Je krijgt een link zoals `https://hybridfuel-app.vercel.app`.

---

## STAP 3 — Open 'm op je telefoon

1. Open de Vercel-link in je telefoonbrowser.
2. De app werkt meteen — het is een echte website.
3. Wil je 'm als "app-icoon" op je beginscherm?
   - **iPhone (Safari):** deelknop → **Zet op beginscherm**.
   - **Android (Chrome):** menu (⋮) → **Toevoegen aan startscherm**.
   Hij opent dan schermvullend, als een app.

---

## Later: echte native app

Dit web-app draait al perfect op de telefoon. Als je later een "echte" app in de
App Store / Play Store wilt, kun je deze site inpakken met bijvoorbeeld Capacitor —
maar dat is pas nodig als je push-notificaties of app-store-aanwezigheid wilt.
Begin met deze versie; die dekt 95% van de behoefte.

---

## Instellingen die je kunt bijstellen

- **Dagelijkse limiet per bezoeker:** in `api/plan.js`, bovenaan: `MAX_PER_DAY = 15`.
- **AI-model:** in `api/plan.js`, de `model`-regel. Sonnet is de balans tussen
  prijs en kwaliteit; controleer actuele modelnamen op docs.claude.com.
- **Kosten per plan:** typisch enkele centen. Met je spend-cap uit stap 0 zit je
  sowieso veilig.

---

## Veelgestelde problemen

- **"Server mist API-key":** je bent de Environment Variable in Vercel vergeten
  (stap 2.4). Toevoegen en opnieuw deployen (Deployments → … → Redeploy).
- **"Dagelijkse limiet bereikt":** de rate-limit (15/dag per bezoeker) is geraakt.
  Normaal bij testen; morgen weer, of verhoog `MAX_PER_DAY` tijdelijk.
- **"Antwoord onleesbaar":** zeldzaam; druk op RETRY. De app vraagt dagen in
  kleine stukjes op om dit te voorkomen.
```
