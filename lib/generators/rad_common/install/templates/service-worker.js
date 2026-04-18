const PENDING_NAV_CACHE = 'rad-pending-navigation';
const PENDING_NAV_KEY = '/__rad_pending_notification_url';
const SW_LOG_CACHE = 'rad-sw-logs';
const SW_LOG_KEY = '/__rad_sw_logs';
const SW_VERSION = '2026-04-19-01';

async function swLog(...args) {
  const msg = args.map((a) => (typeof a === 'object' ? JSON.stringify(a) : String(a))).join(' ');
  const timestamp = new Date().toISOString();
  console.log('[SW]', msg);

  try {
    const cache = await caches.open(SW_LOG_CACHE);
    const existing = await cache.match(SW_LOG_KEY);
    let logs = [];
    if (existing) {
      logs = await existing.json();
    }
    logs.push({ timestamp, version: SW_VERSION, message: msg });
    if (logs.length > 200) logs = logs.slice(-200);
    await cache.put(SW_LOG_KEY, new Response(JSON.stringify(logs), { headers: { 'Content-Type': 'application/json' } }));
  } catch (e) {
    console.error('[SW] swLog cache write failed:', e);
  }

  try {
    const allClients = await clients.matchAll({ type: 'window', includeUncontrolled: true });
    allClients.forEach((c) => c.postMessage({ type: 'sw_log', message: msg, timestamp }));
  } catch (e) {
    // swallow
  }
}

swLog(`service worker script loaded/parsed, version=${SW_VERSION}`);

self.addEventListener('push', (event) => {
  event.waitUntil((async () => {
    await swLog('push event fired');

    let data = {};
    try {
      data = event.data ? event.data.json() : {};
      await swLog('push payload:', JSON.stringify(data));
    } catch (e) {
      await swLog('failed to parse push payload:', e.message);
    }

    const title = data.title || 'New Notification';
    const options = {
      body: data.body || '',
      icon: '/apple-touch-icon.png',
      tag: data.tag || 'notification',
      data: { url: data.url || '/' },
      requireInteraction: false,
      renotify: false
    };

    try {
      await self.registration.showNotification(title, options);
      await swLog('showNotification resolved');
    } catch (e) {
      await swLog('showNotification failed:', e.message);
    }
  })());
});

self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  const url = event.notification.data?.url || '/';

  event.waitUntil((async () => {
    await swLog('notificationclick fired, url:', url);
    await stashPendingUrl(url);

    const windowClients = await clients.matchAll({ type: 'window', includeUncontrolled: true });
    await swLog('matchAll found', windowClients.length, 'clients');
    for (let i = 0; i < windowClients.length; i++) {
      const c = windowClients[i];
      await swLog(`client[${i}]:`, c.url, 'visibility:', c.visibilityState);
    }

    if (windowClients.length > 0) {
      const client = windowClients[0];
      try {
        await client.focus();
        await swLog('focus succeeded on:', client.url);
      } catch (e) {
        await swLog('focus failed:', e.message);
      }
      client.postMessage({ type: 'check_pending_navigation' });
      await swLog('posted check_pending_navigation to client');
      return;
    }

    if (clients.openWindow) {
      try {
        const win = await clients.openWindow(url);
        await swLog('openWindow resolved:', win ? win.url : 'null');
      } catch (e) {
        await swLog('openWindow failed:', e.message);
      }
    }
  })());
});

async function stashPendingUrl(url) {
  try {
    const cache = await caches.open(PENDING_NAV_CACHE);
    await cache.put(
      new Request(PENDING_NAV_KEY),
      new Response(url, { headers: { 'Content-Type': 'text/plain' } })
    );
    await swLog('stashPendingUrl: wrote', url, 'to cache');
  } catch (e) {
    await swLog('stashPendingUrl failed:', e.message);
  }
}

self.addEventListener('install', (event) => {
  event.waitUntil((async () => {
    await swLog('install event fired');
    self.skipWaiting();
  })());
});

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    await swLog('activate event fired');
    await clients.claim();
  })());
});
