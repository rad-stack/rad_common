import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = { vapidPublicKeyUrl: String };
  static targets = ['statusContainer', 'grantedTemplate', 'deniedTemplate', 'defaultTemplate', 'unsupportedTemplate'];

  async connect() {
    if (!this.isPushSupported()) {
      console.log('[PushSubscription] Push notifications not supported');
      this.updateStatusDisplay('unsupported');
      return;
    }

    await this.registerServiceWorker();
    await this.updateStatusFromPermission();
  }

  isPushSupported() {
    return 'serviceWorker' in navigator && 'PushManager' in window && 'Notification' in window;
  }

  async registerServiceWorker() {
    try {
      const registration = await navigator.serviceWorker.register('/service-worker.js');
      console.log('[PushSubscription] Service worker registered:', registration.scope);
    } catch (error) {
      console.error('[PushSubscription] Service worker registration failed:', error);
    }
  }

  async updateStatusFromPermission() {
    const permission = Notification.permission;

    if (permission === 'granted') {
      // Check if we have an active subscription
      const registration = await navigator.serviceWorker.ready;
      const subscription = await registration.pushManager.getSubscription();
      if (subscription) {
        this.updateStatusDisplay('granted');
      } else {
        // Permission granted but no subscription - treat as default to let user subscribe
        this.updateStatusDisplay('default');
      }
    } else if (permission === 'denied') {
      this.updateStatusDisplay('denied');
    } else {
      this.updateStatusDisplay('default');
    }
  }

  updateStatusDisplay(status) {
    if (!this.hasStatusContainerTarget) return;

    let template;
    switch (status) {
      case 'granted':
        template = this.hasGrantedTemplateTarget ? this.grantedTemplateTarget : null;
        break;
      case 'denied':
        template = this.hasDeniedTemplateTarget ? this.deniedTemplateTarget : null;
        break;
      case 'unsupported':
        template = this.hasUnsupportedTemplateTarget ? this.unsupportedTemplateTarget : null;
        break;
      default:
        template = this.hasDefaultTemplateTarget ? this.defaultTemplateTarget : null;
    }

    if (template) {
      this.statusContainerTarget.innerHTML = template.innerHTML;
    }
  }

  async requestPermission() {
    if (!this.isPushSupported()) {
      alert('Push notifications are not supported in your browser.');
      return;
    }

    const permission = await Notification.requestPermission();

    if (permission === 'granted') {
      await this.subscribeToPush();
      this.updateStatusDisplay('granted');
    } else if (permission === 'denied') {
      console.log('[PushSubscription] Notification permission denied');
      this.updateStatusDisplay('denied');
    }
  }

  async subscribeToPush() {
    try {
      const registration = await navigator.serviceWorker.ready;
      const existingSubscription = await registration.pushManager.getSubscription();

      if (existingSubscription) {
        console.log('[PushSubscription] Already subscribed');
        await this.sendSubscriptionToServer(existingSubscription);
        return;
      }

      const vapidPublicKey = await this.getVapidPublicKey();
      if (!vapidPublicKey) {
        console.error('[PushSubscription] Failed to get VAPID public key');
        return;
      }

      const subscription = await registration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: this.urlBase64ToUint8Array(vapidPublicKey)
      });

      await this.sendSubscriptionToServer(subscription);
      console.log('[PushSubscription] Subscribed successfully');
    } catch (error) {
      console.error('[PushSubscription] Subscription failed:', error);
    }
  }

  async unsubscribe() {
    try {
      const registration = await navigator.serviceWorker.ready;
      const subscription = await registration.pushManager.getSubscription();

      if (subscription) {
        const endpoint = subscription.endpoint;
        await subscription.unsubscribe();
        await this.removeSubscriptionFromServer(endpoint);
        console.log('[PushSubscription] Unsubscribed successfully');
        this.updateStatusDisplay('default');
      }
    } catch (error) {
      console.error('[PushSubscription] Unsubscribe failed:', error);
    }
  }

  async getVapidPublicKey() {
    try {
      const url = this.vapidPublicKeyUrlValue || '/push_subscriptions/vapid_public_key';
      const response = await fetch(url, {
        headers: {
          'Accept': 'application/json'
        }
      });

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }

      const data = await response.json();
      return data.vapid_public_key;
    } catch (error) {
      console.error('[PushSubscription] Failed to get VAPID public key:', error);
      return null;
    }
  }

  async sendSubscriptionToServer(subscription) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content;

    const response = await fetch('/push_subscriptions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({
        push_subscription: {
          endpoint: subscription.endpoint,
          p256dh: this.arrayBufferToBase64(subscription.getKey('p256dh')),
          auth: this.arrayBufferToBase64(subscription.getKey('auth')),
          user_agent: navigator.userAgent
        }
      })
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }
  }

  async removeSubscriptionFromServer(endpoint) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content;

    await fetch('/push_subscriptions/0', {
      method: 'DELETE',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ endpoint: endpoint })
    });
  }

  urlBase64ToUint8Array(base64String) {
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
      .replace(/-/g, '+')
      .replace(/_/g, '/');

    const rawData = atob(base64);
    const outputArray = new Uint8Array(rawData.length);

    for (let i = 0; i < rawData.length; ++i) {
      outputArray[i] = rawData.charCodeAt(i);
    }

    return outputArray;
  }

  arrayBufferToBase64(buffer) {
    const bytes = new Uint8Array(buffer);
    let binary = '';
    for (let i = 0; i < bytes.byteLength; i++) {
      binary += String.fromCharCode(bytes[i]);
    }
    return btoa(binary);
  }
}
