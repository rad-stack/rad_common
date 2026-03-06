import { Controller } from '@hotwired/stimulus';

const QUICK_REACTIONS = ['👍', '❤️', '😂', '😮', '😢', '🔥', '🎉', '👏'];

export default class extends Controller {
  static targets = ['picker', 'reactions'];
  static values = { url: String, messageIndex: Number };

  togglePicker() {
    document.querySelectorAll('.chat-reaction-picker:not(.d-none)').forEach(el => {
      if (el !== this.pickerTarget) el.classList.add('d-none');
    });
    this.pickerTarget.classList.toggle('d-none');
  }

  closePicker() {
    this.pickerTarget.classList.add('d-none');
  }

  react(event) {
    const emoji = event.currentTarget.dataset.emoji;
    this.closePicker();
    this.sendReaction(emoji);
  }

  async sendReaction(emoji) {
    const token = document.querySelector('meta[name="csrf-token"]')?.content;

    const response = await fetch(this.urlValue, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': token,
        'Accept': 'text/vnd.turbo-stream.html'
      },
      body: JSON.stringify({ message_index: this.messageIndexValue, emoji: emoji })
    });

    if (response.ok) {
      const html = await response.text();
      Turbo.renderStreamMessage(html);
    }
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.closePicker();
    }
  }

  connect() {
    this._outsideClick = this.closeOnOutsideClick.bind(this);
    document.addEventListener('click', this._outsideClick);
  }

  disconnect() {
    document.removeEventListener('click', this._outsideClick);
  }
}

export { QUICK_REACTIONS };
