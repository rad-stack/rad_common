const PENDING_NAV_CACHE = 'rad-pending-navigation';
const PENDING_NAV_KEY = '/__rad_pending_notification_url';

console.log('[PushNotification] module loaded');

export class PushNotificationClient {
  static setup() {
    console.log('[PushNotification] setup() called');
    if (!('serviceWorker' in navigator)) {
      console.log('[PushNotification] serviceWorker not supported');
      return;
    }
    if (this.initialized) {
      console.log('[PushNotification] already initialized');
      return;
    }
    this.initialized = true;

    this.dumpSwLogHistory();
    this.consumePendingNavigation();
    this.consumeActiveNotifications();

    navigator.serviceWorker.addEventListener('message', (event) => {
      if (event.data?.type === 'sw_log') {
        console.log('[SW-via-client]', event.data.message);
        return;
      }
      console.log('[PushNotification] SW message received:', event.data);
      if (event.data?.type === 'check_pending_navigation') {
        this.consumePendingNavigation();
      }
    });

    document.addEventListener('visibilitychange', () => {
      if (document.visibilityState === 'visible') {
        this.dumpSwLogHistory();
        this.consumePendingNavigation();
        this.consumeActiveNotifications();
      }
    });

    console.log('[PushNotification] listeners registered');
  }

  static async dumpSwLogHistory() {
    try {
      if (!('caches' in window)) return;
      const cache = await caches.open('rad-sw-logs');
      const response = await cache.match('/__rad_sw_logs');
      if (!response) {
        console.log('[SW-history] (empty)');
        return;
      }
      const logs = await response.json();
      console.log('[SW-history]', logs.length, 'entries:');
      logs.forEach((l) => console.log(`  ${l.timestamp} v=${l.version} ${l.message}`));
      await cache.delete('/__rad_sw_logs');
    } catch (e) {
      console.error('[PushNotification] dumpSwLogHistory failed:', e);
    }
  }

  static async consumePendingNavigation() {
    console.log('[PushNotification] consumePendingNavigation() called');
    try {
      if (!('caches' in window)) return;

      const cache = await caches.open(PENDING_NAV_CACHE);
      const response = await cache.match(PENDING_NAV_KEY);
      if (!response) {
        console.log('[PushNotification] No pending URL in cache');
        return;
      }

      const url = await response.text();
      await cache.delete(PENDING_NAV_KEY);
      console.log('[PushNotification] Pending URL:', url, 'current:', window.location.href);

      this.navigateTo(url);
    } catch (e) {
      console.error('[PushNotification] consumePendingNavigation failed:', e);
    }
  }

  static async consumeActiveNotifications() {
    console.log('[PushNotification] consumeActiveNotifications() called');
    try {
      const registration = await navigator.serviceWorker.ready;
      if (!registration.getNotifications) {
        console.log('[PushNotification] getNotifications unavailable');
        return;
      }

      const notifications = await registration.getNotifications();
      console.log('[PushNotification] active notifications:', notifications.length);

      for (const notification of notifications) {
        const url = notification.data?.url;
        if (url) {
          console.log('[PushNotification] found active notification with url:', url);
          notification.close();
          this.navigateTo(url);
          return;
        }
      }
    } catch (e) {
      console.error('[PushNotification] consumeActiveNotifications failed:', e);
    }
  }

  static navigateTo(url) {
    if (!url) return;
    if (url === window.location.href) {
      console.log('[PushNotification] Already at target URL, skipping');
      return;
    }
    console.log('[PushNotification] Navigating to', url);
    window.location.href = url;
  }
}

if (typeof window !== 'undefined') {
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => PushNotificationClient.setup());
  } else {
    PushNotificationClient.setup();
  }
}
