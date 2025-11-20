import * as Sentry from '@sentry/browser';

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  integrations: [Sentry.browserTracingIntegration()],
  tracesSampleRate: process.env.NODE_ENV == 'production' ? 0.1 : 1.0,
});


export class SentryTest {
  static setup() {
    const sentryTest = document.querySelector('[href="/sentry_tests/new"]');
    if (sentryTest) {
      sentryTest.addEventListener('click', function (e) {
        setTimeout(() => {
          throw new Error('Sentry Test Error (JS)');
        });
      });
    }
  }
}
