// Mock-supabase voor een losse render van CoachDash (alleen om de layout te checken).
const DAY = 86400e3, HR = 36e5;
const now = Date.now();
const iso = (ms) => new Date(now + ms).toISOString();
const today = new Date().getDay();

const members = [
  { id: "m1", auth_user_id: "u1", display_name: "Sanne Jansen", active: true, created_at: iso(-46 * DAY), member_tier: "pro", plan_id: "p-pro", class_access: null, coach_note: "Let op knie", calc_override: null },
  { id: "m2", auth_user_id: "u2", display_name: "Joost de Vries", active: true, created_at: iso(-32 * DAY), member_tier: "pro", plan_id: "p-pro", class_access: null, coach_note: "", calc_override: null },
  { id: "m3", auth_user_id: "u3", display_name: "Ayoub El Idrissi", active: true, created_at: iso(-18 * DAY), member_tier: "basis", plan_id: null, class_access: null, coach_note: "", calc_override: null },
  { id: "m4", auth_user_id: "u4", display_name: "Lisa de Wit", active: true, created_at: iso(-11 * DAY), member_tier: "basis", plan_id: "p-basis", class_access: null, coach_note: "", calc_override: null },
  { id: "m5", auth_user_id: "u5", display_name: "Tom Vermeer", active: true, created_at: iso(-4 * DAY), member_tier: "pro", plan_id: null, class_access: null, coach_note: "", calc_override: null },
  { id: "m6", auth_user_id: "u6", display_name: "Noa Bakker", active: true, created_at: iso(-1 * DAY), member_tier: "basis", plan_id: "p-basis", class_access: null, coach_note: "", calc_override: null },
];
const progress = [
  { user_id: "u1", adherence: 38, last_active: iso(-2 * HR) },
  { user_id: "u2", adherence: 64, last_active: iso(-5 * DAY) },
  { user_id: "u4", adherence: 82, last_active: iso(-26 * HR) },
  { user_id: "u5", adherence: 47, last_active: iso(-1 * DAY) },
];
const coaches = [
  { id: "c-owner", auth_user_id: "owner-1", display_name: "Mounir", is_owner: true, perms: ["members", "classes", "pt", "plans", "branding", "formula"] },
  { id: "c-rick", auth_user_id: "u-rick", display_name: "Rick Visser", is_owner: false, perms: ["members", "pt", "classes"] },
  { id: "c-dina", auth_user_id: "u-dina", display_name: "Dina Bakker", is_owner: false, perms: ["classes"] },
];
const classes = [
  { id: "cl1", name: "HIIT 45", day_of_week: today, start_time: "17:30", duration_min: 45, capacity: 20 },
  { id: "cl2", name: "HYROX sim", day_of_week: today, start_time: "18:30", duration_min: 60, capacity: 18 },
  { id: "cl3", name: "Bokszak", day_of_week: today, start_time: "19:00", duration_min: 45, capacity: 16 },
  { id: "cl4", name: "Core & mobility", day_of_week: (today + 1) % 7, start_time: "20:00", duration_min: 30, capacity: 14 },
];
const enrollCounts = { cl1: 9, cl2: 15, cl3: 16, cl4: 6 };
const enrollments = []; Object.entries(enrollCounts).forEach(([cid, n]) => { for (let i = 0; i < n; i++) enrollments.push({ class_id: cid }); });
const plans = [
  { id: "p-basis", name: "Basis", pt_included: false, class_ids: ["cl1", "cl4"] },
  { id: "p-pro", name: "Pro", pt_included: true, class_ids: null },
];
const sessions = [
  { id: "s1", member_id: "m2", title: "PT Joost", starts_at: iso(4 * HR), note: "" },
  { id: "s2", member_id: "m1", title: "PT Sanne", starts_at: iso(1 * DAY + 10 * HR), note: "" },
  { id: "s3", member_id: "m5", title: "PT Tom", starts_at: iso(2 * DAY), note: "" },
];
const config = [{ terms_accepted_at: iso(-60 * DAY), calc_profile: {} }];

function rowsFor(state) {
  const { table, eqs } = state;
  if (table === "org_members") return eqs.role === "coach" ? coaches : members;
  if (table === "member_progress") return progress;
  if (table === "org_classes") return classes;
  if (table === "org_plans") return plans;
  if (table === "org_sessions") return sessions;
  if (table === "class_enrollments") return enrollments;
  if (table === "org_config") return config;
  return [];
}

function makeBuilder(table) {
  const state = { table, eqs: {} };
  const b = {
    select() { return b; }, eq(c, v) { state.eqs[c] = v; return b; }, order() { return b; },
    limit() { return b; }, gte() { return b; }, lte() { return b; },
    insert() { return b; }, update() { return b; }, delete() { return b; }, single() { state.single = true; return b; },
    then(res, rej) { const data = rowsFor(state); return Promise.resolve({ data: state.single ? (data[0] || null) : data, error: null }).then(res, rej); },
  };
  return b;
}

export const supabase = {
  from(table) { return makeBuilder(table); },
  auth: {
    getSession() { return Promise.resolve({ data: { session: { access_token: "tok", user: { id: "owner-1" } } } }); },
    refreshSession() { return Promise.resolve({ data: { session: { access_token: "tok", user: { id: "owner-1" } } } }); },
  },
};
