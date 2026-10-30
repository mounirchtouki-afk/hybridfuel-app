import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.hybridfuelco.app',
  appName: 'HybridFuelCo',
  webDir: 'dist',

  // De app serveert nu de gebundelde assets (offline-capabel + store-vriendelijk,
  // i.p.v. de live site in een shell). De /api-calls zijn via src/apiBase.js
  // absoluut gemaakt voor de native build (VITE_API_BASE), en CapacitorHttp stuurt
  // de requests via de native laag zodat er geen CORS nodig is. Zie CAPACITOR.md.
  plugins: {
    CapacitorHttp: {
      enabled: true,
    },
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
