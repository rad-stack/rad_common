import * as Sentry from '@sentry/browser';

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  tracesSampleRate: 0,
});


export class SentryTest {
  static setup() {
    const sentryTest = document.querySelector('[href="/sentry_tests/new"]');
    if (sentryTest) {
      sentryTest.addEventListener('click', function () {
        setTimeout(() => {
          throw new Error('Sentry Test Error (JS)');
        });
      });
    }
  }
}
