import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = { url: String };
  static targets = ['input'];

  connect() {
    this.typing = false;
    this.timeout = null;
  }

  onInput() {
    if (this.inputTarget.value.trim() === '') {
      this.stopTyping();
      return;
    }

    if (this.typing) return;

    this.typing = true;
    this.sendRequest();

    this.timeout = setTimeout(() => {
      this.typing = false;
    }, 3000);
  }

  onBlur() {
    this.stopTyping();
  }

  stopTyping() {
    if (!this.typing) return;

    this.typing = false;
    if (this.timeout) {
      clearTimeout(this.timeout);
      this.timeout = null;
    }
    this.sendRequest(true);
  }

  sendRequest(stop = false) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content;
    const url = stop ? `${this.urlValue}?stop=true` : this.urlValue;

    fetch(url, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfToken,
        'Accept': 'text/html'
      }
    });
  }

  disconnect() {
    if (this.timeout) clearTimeout(this.timeout);
  }
}
