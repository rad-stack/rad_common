import { Controller } from '@hotwired/stimulus';

const EMOJI_CATEGORIES = [
  {
    name: 'Smileys',
    emojis: ['😀', '😂', '🙂', '😊', '🥰', '😍', '🤔', '😢', '😡', '🤯', '😱', '🤗', '😎', '🥳', '😴', '🤮', '🤡', '😅', '🫡', '🤷']
  },
  {
    name: 'Gestures',
    emojis: ['👍', '👎', '👏', '🙌', '🤝', '✌️', '🤞', '💪', '🙏', '👋', '🫶', '🤙']
  },
  {
    name: 'Hearts',
    emojis: ['❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '💔', '💕', '💯']
  },
  {
    name: 'Objects',
    emojis: ['🔥', '⭐', '✅', '❌', '⚡', '💡', '🎉', '🎯', '🚀', '👀', '💬', '📌']
  }
];

export default class extends Controller {
  static targets = ['panel', 'input'];

  toggle() {
    this.panelTarget.classList.toggle('d-none');
  }

  close() {
    this.panelTarget.classList.add('d-none');
  }

  select(event) {
    const emoji = event.currentTarget.dataset.emoji;
    const input = this.inputTarget;
    const start = input.selectionStart;
    const end = input.selectionEnd;
    const value = input.value;

    input.value = value.slice(0, start) + emoji + value.slice(end);
    input.selectionStart = input.selectionEnd = start + emoji.length;
    input.focus();
    this.close();
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.close();
    }
  }

  connect() {
    this._outsideClick = this.closeOnOutsideClick.bind(this);
    document.addEventListener('click', this._outsideClick);
  }

  disconnect() {
    document.removeEventListener('click', this._outsideClick);
  }

  static categories = EMOJI_CATEGORIES;
}

export { EMOJI_CATEGORIES };
