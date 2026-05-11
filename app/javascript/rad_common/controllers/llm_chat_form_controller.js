import { Controller } from '@hotwired/stimulus';
import MentionInput from '../utils/mention_input';

export default class extends Controller {
  static targets = ['currentMessage', 'form', 'mentionDropdown', 'hiddenInput'];

  static values = {
    mentionsUrl: String,
    mentionableTypes: Array
  };

  connect() {
    this.initOffcanvasScroll();
    this.initMentions();
  }

  disconnect() {
    this.mentionInput?.destroy();
  }

  // --- Initialization ---

  initOffcanvasScroll() {
    const offcanvas = document.getElementById('mallow-question-modal');
    offcanvas?.addEventListener('shown.bs.offcanvas', () => this.scrollToBottom(), { once: true });
  }

  initMentions() {
    if (!this.hasCurrentMessageTarget || !this.hasMentionDropdownTarget || !this.hasMentionsUrlValue) {
      return;
    }

    this.mentionInput = new MentionInput(
      this.currentMessageTarget,
      this.mentionDropdownTarget,
      {
        fetchResults: (query) => this.fetchMentions(query),
        renderItem: (item) => `
          <i class="fa fa-${item.icon || 'user'} me-2"></i>
          ${this.escapeHtml(item.label)}
          <small class="text-muted ms-2">${item.type}</small>
        `
      }
    );

    this.currentMessageTarget.addEventListener('keydown', (e) => this.handleKeydown(e));
    this.formTarget?.addEventListener('submit', (e) => this.handleSubmit(e));
  }

  // --- Actions ---

  handleKeydown(event) {
    if (event.key !== 'Enter') return;

    if (event.shiftKey) return;

    if (!this.mentionDropdownTarget.classList.contains('d-none')) return;

    event.preventDefault();
    this.formTarget.requestSubmit();
  }

  updateCurrentMessage(event) {
    this.hiddenInputTarget.value = event.target.innerText;
    this.formTarget.requestSubmit();
  }

  handleSubmit() {
    if (!this.mentionInput || !this.hasHiddenInputTarget) return;

    this.hiddenInputTarget.value = this.mentionInput.getTokenizedText();
    this.currentMessageTarget.innerHTML = '';
  }

  // --- Helpers ---

  scrollToBottom() {
    const container = document.getElementById('scroll-container');
    if (container) container.scrollTop = container.scrollHeight;
  }

  async fetchMentions(query) {
    const types = this.mentionableTypesValue || ['User'];
    const results = [];

    for (const type of types) {
      try {
        const url = `${this.mentionsUrlValue}?q=${encodeURIComponent(query)}&type=${encodeURIComponent(type)}`;
        const response = await fetch(url, {
          headers: { 'Accept': 'application/json', 'X-Requested-With': 'XMLHttpRequest' }
        });
        if (response.ok) {
          results.push(...await response.json());
        }
      } catch (e) {
        console.error('Error fetching mentions:', e);
      }
    }

    return results;
  }

  escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
  }
}
