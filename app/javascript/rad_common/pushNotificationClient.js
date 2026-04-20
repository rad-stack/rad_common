const PENDING_NAV_CACHE = 'rad-pending-navigation';
const PENDING_NAV_KEY = '/__rad_pending_notification_url';

export class PushNotificationClient {
  static setup() {
    if (!('serviceWorker' in navigator)) return;
    if (this.initialized) return;
    this.initialized = true;

    this.consumePendingNavigation();

    navigator.serviceWorker.addEventListener('message', (event) => {
      if (event.data?.type === 'check_pending_navigation') {
        this.consumePendingNavigation();
      }
    });

    document.addEventListener('visibilitychange', () => {
      if (document.visibilityState === 'visible') {
        this.consumePendingNavigation();
      }
    });
  }

  static async consumePendingNavigation() {
    if (!('caches' in window)) return;

    try {
      const cache = await caches.open(PENDING_NAV_CACHE);
      const response = await cache.match(PENDING_NAV_KEY);
      if (!response) return;

      const url = await response.text();
      await cache.delete(PENDING_NAV_KEY);

      if (url) {
        window.location.href = url;
      }
    } catch (e) {
      // swallow
    }
  }
}
