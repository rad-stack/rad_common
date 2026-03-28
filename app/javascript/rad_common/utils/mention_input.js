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
      renderItem: (item) => item.label,
      ...options
    };

    this.state = { active: false, startPos: null, query: '' };
    this.results = [];
    this.selectedIndex = 0;
    this.debounceTimer = null;

    this.bindEvents();
  }

  bindEvents() {
    this.input.addEventListener('input', this.handleInput.bind(this));
    this.input.addEventListener('keydown', this.handleKeydown.bind(this));
    this.input.addEventListener('blur', () => setTimeout(() => this.close(), 150));
    this.dropdown.addEventListener('click', this.handleDropdownClick.bind(this));
  }

  getText() {
    return this.input.textContent || '';
  }

  getCursor() {
    const selection = window.getSelection();
    if (!selection.rangeCount) return 0;

    const range = selection.getRangeAt(0);
    const preRange = range.cloneRange();
    preRange.selectNodeContents(this.input);
    preRange.setEnd(range.startContainer, range.startOffset);
    return preRange.toString().length;
  }

  handleInput() {
    clearTimeout(this.debounceTimer);

    const triggerInfo = this.findTriggerInTextNodes();
    if (!triggerInfo) return this.close();

    const { position, query } = triggerInfo;
    if (query.includes('[')) return this.close();

    this.state = { active: true, startPos: position, query };

    if (query.length >= this.options.minChars) {
      this.debounceTimer = setTimeout(() => this.search(query), this.options.debounceMs);
    }
  }

  // Find @ trigger only in text nodes, ignoring mention spans
  findTriggerInTextNodes() {
    const cursor = this.getCursor();
    let position = 0;
    let lastTriggerPos = -1;
    let lastTriggerTextPos = -1;

    for (const node of this.input.childNodes) {
      const length = node.textContent?.length || 0;

      if (node.nodeType === Node.TEXT_NODE) {
        const text = node.textContent || '';
        // Find last @ in this text node that's before cursor
        for (let i = text.length - 1; i >= 0; i--) {
          const globalPos = position + i;
          if (globalPos < cursor && text[i] === this.options.trigger) {
            if (globalPos > lastTriggerPos) {
              lastTriggerPos = globalPos;
              lastTriggerTextPos = globalPos;
            }
            break;
          }
        }
      }

      position += length;
    }

    if (lastTriggerPos === -1) return null;

    const text = this.getText();
    const query = text.substring(lastTriggerTextPos + 1, cursor);
    return { position: lastTriggerTextPos, query };
  }

  handleKeydown(event) {
    if (!this.state.active || this.results.length === 0) return;

    const action = KEY_ACTIONS.get(event.key);
    if (!action) return;

    event.preventDefault();
    event.stopImmediatePropagation();
    ({ next: () => this.navigate(1), prev: () => this.navigate(-1), select: () => this.selectCurrent(), close: () => this.close() })[action]?.();
  }

  navigate(delta) {
    this.selectedIndex = Math.max(0, Math.min(this.selectedIndex + delta, this.results.length - 1));
    this.updateSelection();
  }

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

  render() {
    if (this.results.length === 0) return this.close();

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
    const showAbove = rect.top > dropdownHeight + 10;

    Object.assign(this.dropdown.style, {
      position: 'fixed',
      left: `${rect.left}px`,
      top: showAbove ? `${rect.top - dropdownHeight - 5}px` : `${rect.bottom + 5}px`,
      width: `${rect.width}px`
    });
  }

  handleDropdownClick(event) {
    const item = event.target.closest('.mention-item');
    if (item) {
      this.selectedIndex = parseInt(item.dataset.index, 10);
      this.selectCurrent();
    }
  }

  selectCurrent() {
    const item = this.results[this.selectedIndex];
    if (!item) return;

    // Find the range from trigger to cursor and replace it with the mention
    const triggerRange = this.findRangeForTrigger();
    if (!triggerRange) return;

    // Delete the @query text
    triggerRange.deleteContents();

    // Create mention span
    const span = document.createElement('span');
    span.className = 'mention';
    span.contentEditable = 'false';
    span.textContent = `@${item.label}`;
    span.dataset.token = item.token;

    // Insert mention and a space after it
    triggerRange.insertNode(span);
    const space = document.createTextNode(' ');
    span.after(space);

    // Set cursor after the space
    const selection = window.getSelection();
    const range = document.createRange();
    range.setStart(space, 1);
    range.collapse(true);
    selection.removeAllRanges();
    selection.addRange(range);

    this.input.focus();
    this.close();
  }

  // Find the DOM range from trigger position to cursor
  findRangeForTrigger() {
    const selection = window.getSelection();
    if (!selection.rangeCount) return null;

    const cursorRange = selection.getRangeAt(0);
    let position = 0;
    let triggerNode = null;
    let triggerOffset = 0;

    // Find the node and offset where the trigger (@) is located
    for (const node of this.input.childNodes) {
      if (node.nodeType === Node.TEXT_NODE) {
        const text = node.textContent || '';
        const triggerLocalPos = this.state.startPos - position;

        if (triggerLocalPos >= 0 && triggerLocalPos < text.length) {
          triggerNode = node;
          triggerOffset = triggerLocalPos;
          break;
        }
      }
      position += node.textContent?.length || 0;
    }

    if (!triggerNode) return null;

    const range = document.createRange();
    range.setStart(triggerNode, triggerOffset);
    range.setEnd(cursorRange.startContainer, cursorRange.startOffset);
    return range;
  }

  close() {
    clearTimeout(this.debounceTimer);
    this.state = { active: false, startPos: null, query: '' };
    this.results = [];
    this.selectedIndex = 0;
    this.dropdown.classList.add('d-none');
  }

  getTokenizedText() {
    let result = '';
    for (const node of this.input.childNodes) {
      if (node.nodeType === Node.TEXT_NODE) {
        result += node.textContent;
      } else if (node.classList?.contains('mention')) {
        result += node.dataset.token || node.textContent;
      }
    }
    return result;
  }

  destroy() {
    clearTimeout(this.debounceTimer);
  }
}
