import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.hybridfuelco.app',
  appName: 'HybridFuelCo',
  webDir: 'dist',

  // Eerste werkende build laadt de live app. Alle /api-calls in de app zijn
  // relatief, dus zo werken ze meteen (zelfde origin als app.hybridfuelco.com).
  // Voor een store-klare, offline-capabele build (en Apple-richtlijn 4.2) stappen
  // we later over op gebundelde assets: verwijder dit server-blok en maak de
  // /api-calls absoluut. Zie CAPACITOR.md.
  server: {
    url: 'https://app.hybridfuelco.com',
    cleartext: false,
  },

  plugins: {
    PushNotifications: {
      presentationOptions: ['badge', 'sound', 'alert'],
    },
    SplashScreen: {
      backgroundColor: '#0A0A0A',
      showSpinner: false,
    },
  },
};

export default config;
