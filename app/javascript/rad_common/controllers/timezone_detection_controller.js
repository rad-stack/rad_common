import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    const tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
    this.persist(tz).finally(() => this.element.remove());
  }

  async persist(tz) {
    await fetch('/set_js_timezone', {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({ timezone: tz })
    });
  }
}
