import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = { url: String };
  static targets = ['input'];

  connect() {
    this.typing = false;
    this.timeout = null;
  }

  onInput() {
    if (this.inputTarget.value.trim() === '') return;
    if (this.typing) return;

    this.typing = true;
    this.sendTyping();

    this.timeout = setTimeout(() => {
      this.typing = false;
    }, 3000);
  }

  sendTyping() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content;

    fetch(this.urlValue, {
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
