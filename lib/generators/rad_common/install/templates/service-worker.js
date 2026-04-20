const PENDING_NAV_CACHE = 'rad-pending-navigation';
const PENDING_NAV_KEY = '/__rad_pending_notification_url';

self.addEventListener('push', (event) => {
  const data = event.data ? event.data.json() : {};
  const title = data.title || 'New Notification';
  const options = {
    body: data.body || '',
    icon: '/apple-touch-icon.png',
    tag: data.tag || 'notification',
    data: { url: data.url || '/' },
    requireInteraction: false,
    renotify: false
  };

  event.waitUntil(self.registration.showNotification(title, options));
});

self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  const url = event.notification.data?.url || '/';

  event.waitUntil((async () => {
    await stashPendingUrl(url);

    const windowClients = await clients.matchAll({ type: 'window', includeUncontrolled: true });

    if (windowClients.length > 0) {
      const client = windowClients[0];
      await client.focus();
      client.postMessage({ type: 'check_pending_navigation' });
      return;
    }

    if (clients.openWindow) {
      return clients.openWindow(url);
    }
  })());
});

async function stashPendingUrl(url) {
  const cache = await caches.open(PENDING_NAV_CACHE);
  await cache.put(
    new Request(PENDING_NAV_KEY),
    new Response(url, { headers: { 'Content-Type': 'text/plain' } })
  );
}

self.addEventListener('install', () => {
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(clients.claim());
});
