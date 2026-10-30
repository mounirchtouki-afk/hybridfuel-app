import React from "react";
import { createRoot } from "react-dom/client";
import CoachDash from "../src/views/CoachDash.jsx";
import { applyOrgTheme } from "../src/shared.js";

// White-label voorbeeld: licht thema + eigen accent (zoals testgym).
const ACCENT = "#15A34A";
const THEME = { template: "light", accent: ACCENT };
applyOrgTheme(THEME);

const org = { id: "org1", name: "In Shape", slug: "inshape", brand_color: ACCENT, logo_url: null, theme: THEME, enabled_modules: ["members", "classes", "pt", "plans", "branding", "formula"] };
const session = { user: { id: "owner-1" }, access_token: "tok" };

createRoot(document.getElementById("root")).render(
  <CoachDash session={session} org={org} isOwner={true} perms={["members", "classes", "pt", "plans"]} lang="nl" onLogout={() => {}} />
);
