import { Controller } from '@hotwired/stimulus';
import { put } from '../radFetch';

export default class extends Controller {
  connect() {
    const tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
    this.persist(tz).finally(() => this.element.remove());
  }

  async persist(tz) {
    await put('/set_js_timezone', { body: { timezone: tz } });
  }
}
