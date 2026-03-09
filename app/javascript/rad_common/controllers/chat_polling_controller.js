import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = { url: String };

  connect() {
    this.submitBtn = document.getElementById('chat-submit-btn');
    this.offcanvasElement = this.element.closest('.offcanvas');

    if (this.isOffcanvasVisible()) {
      this.submitBtn.disabled = true;
      this.poll();
    } else {
      this.waitForOffcanvas();
    }
  }

  isOffcanvasVisible() {
    return this.offcanvasElement?.classList?.contains('show');
  }

  waitForOffcanvas() {
    if (this.offcanvasElement) {
      this.offcanvasElement.addEventListener('shown.bs.offcanvas', () => {
        this.submitBtn.disabled = true;
        this.poll();
      }, { once: true });
    }
  }

  async poll() {
    if (!this.isOffcanvasVisible()) {
      return;
    }

    try {
      const response = await fetch(this.urlValue, { headers: { 'Accept': 'application/json' } });
      const data = await response.json();

      if (data.status === 'processing') {
        setTimeout(() => this.poll(), 1000);
      } else {
        this.element.src = this.urlValue;
        this.submitBtn.disabled = false;
      }
    } catch {
      this.submitBtn.disabled = false;
    }
  }
}
