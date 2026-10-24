// /api/tracker — bouwt de volledige tracker-Excel MET het plan van de klant erin.
//
// Pakt het bestaande tracker-sjabloon van de website (met Dashboard, grafiek,
// Weight-tab en recepten), vult het weekplan + de boodschappenlijst in, en geeft
// één bestand terug. De grafiek, opmaak en formules blijven behouden (xlsx-populate
// raakt alleen de ingevulde cellen aan).

import XlsxPopulate from "xlsx-populate";

const r0 = (v) => { const n = Math.round(parseFloat(v)); return isNaN(n) ? 0 : n; };

export async function fillTracker(buf, lang, week, shopping) {
  const wb = await XlsxPopulate.fromDataAsync(buf);
  const mp = wb.sheet(lang === "nl" ? "Weekplan" : "Meal plan");
  const days = (week && Array.isArray(week.days)) ? week.days.slice(0, 7) : [];

  // Weekplan: rijen 4..31 = 7 dagen x 4 maaltijden. Alleen C..H worden aangeraakt,
  // zodat de Dag/Type-kolommen (A,B) en de sleutel-kolom (I) voor het Dashboard
  // intact blijven.
  for (let i = 0; i < 7; i++) {
    const day = days[i];
    const meals = (day && Array.isArray(day.m)) ? day.m : [];
    for (let j = 0; j < 4; j++) {
      const row = 4 + i * 4 + j;
      const meal = meals[j];
      if (meal) {
        mp.cell("C" + row).value(String(meal.n || ""));
        mp.cell("D" + row).value((meal.ing || []).map((x) => r0(x.g) + "g " + (x.n || "")).join(", "));
        mp.cell("E" + row).value(r0(meal.kcal));
        mp.cell("F" + row).value(r0(meal.p));
        mp.cell("G" + row).value(r0(meal.c));
        mp.cell("H" + row).value(r0(meal.f));
      } else {
        ["C", "D", "E", "F", "G", "H"].forEach((c) => mp.cell(c + row).value(""));
      }
    }
  }

  // Boodschappen: voorbeeldrijen wissen, dan de echte lijst neerzetten.
  const sh = wb.sheet(lang === "nl" ? "Boodschappen" : "Shopping");
  if (sh && Array.isArray(shopping)) {
    for (let row = 4; row <= 120; row++) {
      sh.cell("A" + row).value(""); sh.cell("B" + row).value(""); sh.cell("C" + row).value("");
    }
    let rr = 4;
    for (const cat of shopping) {
      const items = (cat && Array.isArray(cat.items)) ? cat.items : [];
      for (const it of items) {
        if (rr > 119) break;
        const g = r0(it.g);
        sh.cell("A" + rr).value(String(cat.n || ""));
        sh.cell("B" + rr).value(String(it.name || ""));
        sh.cell("C" + rr).value(g >= 1000 ? (g / 1000).toFixed(1) + " kg" : g + " g");
        rr++;
      }
    }
  }

  return wb.outputAsync();
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return res.status(405).json({ error: "Method not allowed" });
  }
  try {
    let body = req.body;
    if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
    const lang = (body && body.lang) === "nl" ? "nl" : "en";
    const week = body && body.week;
    if (!week || !Array.isArray(week.days) || !week.days.length) {
      return res.status(400).json({ error: "No plan provided" });
    }

    // Sjabloon van de live website halen (bevat Dashboard, grafiek, Weight, recepten).
    const tplUrl = `https://www.hybridfuelco.com/tracker-${lang}.xlsx`;
    const tr = await fetch(tplUrl);
    if (!tr.ok) return res.status(502).json({ error: "Template not reachable (" + tr.status + ")" });
    const buf = Buffer.from(await tr.arrayBuffer());

    const out = await fillTracker(buf, lang, week, Array.isArray(body.shopping) ? body.shopping : []);

    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
    res.setHeader("Content-Disposition", `attachment; filename="HybridFuelCo-Tracker-${lang.toUpperCase()}.xlsx"`);
    return res.status(200).send(Buffer.from(out));
  } catch (e) {
    return res.status(500).json({ error: "Tracker build failed", detail: String(e).slice(0, 200) });
  }
}
