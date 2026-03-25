const KEY_ACTIONS = new Map([
  ['ArrowDown', 'next'],
  ['ArrowUp', 'prev'],
  ['Enter', 'select'],
  ['Tab', 'select'],
  ['Escape', 'close']
]);

export default class MentionInput {
  constructor(input, dropdown, options = {}) {
    this.input = input;
    this.dropdown = dropdown;
    this.options = {
      trigger: '@',
      minChars: 2,
      debounceMs: 250,
      fetchResults: async () => [],
      onSelect: () => {},
      renderItem: (item) => item.label,
      ...options
    };

    this.state = { active: false, startPos: null, query: '' };
    this.results = [];
    this.selectedIndex = 0;
    this.mentions = new Map(); // displayText -> token
    this.debounceTimer = null;

    this.bindEvents();
  }

  // --- Event Binding ---

  bindEvents() {
    this.input.addEventListener('input', this.handleInput.bind(this));
    this.input.addEventListener('keydown', this.handleKeydown.bind(this));
    this.input.addEventListener('blur', () => setTimeout(() => this.close(), 150));
    this.dropdown.addEventListener('click', this.handleDropdownClick.bind(this));
  }

  // --- Input Handling ---

  handleInput() {
    clearTimeout(this.debounceTimer);

    const { value, selectionStart: cursor } = this.input;
    const textBefore = value.substring(0, cursor);
    const triggerPos = textBefore.lastIndexOf(this.options.trigger);

    if (triggerPos === -1 || this.isCompletedMention(textBefore, triggerPos)) {
      return this.close();
    }

    const query = textBefore.substring(triggerPos + 1);
    if (query.includes(' ') || query.includes('[')) {
      return this.close();
    }

    this.state = { active: true, startPos: triggerPos, query };

    if (query.length >= this.options.minChars) {
      this.debounceTimer = setTimeout(() => this.search(query), this.options.debounceMs);
    }
  }

  isCompletedMention(text, triggerPos) {
    const afterTrigger = text.substring(triggerPos + 1);
    for (const displayText of this.mentions.keys()) {
      const name = displayText.replace(/^@/, '');
      if (afterTrigger.startsWith(name)) return true;
    }
    return false;
  }

  // --- Keyboard Navigation ---

  handleKeydown(event) {
    if (event.key === 'Backspace' && this.handleBackspace()) {
      event.preventDefault();
      return;
    }

    if (!this.state.active || this.results.length === 0) return;

    const action = KEY_ACTIONS.get(event.key);
    if (!action) return;

    event.preventDefault();

    const actions = {
      next: () => this.navigate(1),
      prev: () => this.navigate(-1),
      select: () => this.selectCurrent(),
      close: () => this.close()
    };

    actions[action]?.();
  }

  navigate(delta) {
    this.selectedIndex = Math.max(0, Math.min(this.selectedIndex + delta, this.results.length - 1));
    this.updateSelection();
  }

  handleBackspace() {
    const { value, selectionStart: cursor } = this.input;

    for (const [displayText] of this.mentions.entries()) {
      const patterns = [displayText + ' ', displayText];
      for (const pattern of patterns) {
        const pos = value.lastIndexOf(pattern, cursor - 1);
        if (pos !== -1 && pos + pattern.length === cursor) {
          this.input.value = value.substring(0, pos) + value.substring(cursor);
          this.input.setSelectionRange(pos, pos);
          this.mentions.delete(displayText);
          return true;
        }
      }
    }
    return false;
  }

  // --- Search & Results ---

  async search(query) {
    try {
      this.results = await this.options.fetchResults(query);
      this.selectedIndex = 0;
      this.render();
    } catch (e) {
      console.error('MentionInput search error:', e);
      this.close();
    }
  }

  // --- Rendering ---

  render() {
    if (this.results.length === 0) {
      return this.close();
    }

    this.dropdown.innerHTML = this.results
      .map((item, i) => `
        <button type="button" class="mention-item${i === this.selectedIndex ? ' active' : ''}" data-index="${i}">
          ${this.options.renderItem(item)}
        </button>
      `).join('');

    this.dropdown.classList.remove('d-none');
    this.positionDropdown();
  }

  updateSelection() {
    this.dropdown.querySelectorAll('.mention-item').forEach((el, i) => {
      el.classList.toggle('active', i === this.selectedIndex);
    });
  }

  positionDropdown() {
    const rect = this.input.getBoundingClientRect();
    const dropdownHeight = this.dropdown.offsetHeight;
    const spaceAbove = rect.top;
    const showAbove = spaceAbove > dropdownHeight + 10;

    Object.assign(this.dropdown.style, {
      position: 'fixed',
      left: `${rect.left}px`,
      top: showAbove ? `${rect.top - dropdownHeight - 5}px` : `${rect.bottom + 5}px`,
      width: `${rect.width}px`
    });
  }

  // --- Selection ---

  handleDropdownClick(event) {
    const item = event.target.closest('.mention-item');
    if (item) {
      this.selectedIndex = parseInt(item.dataset.index, 10);
      this.selectCurrent();
    }
  }

  selectCurrent() {
    if (!this.results[this.selectedIndex]) return;

    const item = this.results[this.selectedIndex];
    const displayText = `@${item.label}`;
    const { value, selectionStart: cursor } = this.input;

    this.mentions.set(displayText, item.token);

    const before = value.substring(0, this.state.startPos);
    const after = value.substring(cursor);
    this.input.value = `${before}${displayText} ${after}`;

    const newPos = before.length + displayText.length + 1;
    this.input.setSelectionRange(newPos, newPos);
    this.input.focus();

    this.options.onSelect(item);
    this.close();
  }

  // --- Lifecycle ---

  close() {
    this.state = { active: false, startPos: null, query: '' };
    this.results = [];
    this.selectedIndex = 0;
    this.dropdown.classList.add('d-none');
  }

  // Convert display mentions to tokens before submit
  tokenize(text) {
    let result = text;
    const sorted = [...this.mentions.entries()].sort((a, b) => b[0].length - a[0].length);
    for (const [display, token] of sorted) {
      result = result.split(display).join(token);
    }
    this.mentions.clear();
    return result;
  }

  destroy() {
    clearTimeout(this.debounceTimer);
  }
}
