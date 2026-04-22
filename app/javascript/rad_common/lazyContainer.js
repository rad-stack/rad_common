import { Turbo } from '@hotwired/turbo-rails';

const bootstrap = require('bootstrap');

export class LazyContainer {
  static open({ url, type = 'modal', title = null, subtitle = null, size = null, width = null, containerId = null, frameId = null }) {
    const resolvedContainerId = containerId || (type === 'modal' ? 'global-lazy-modal' : 'global-lazy-offcanvas');
    const element = document.getElementById(resolvedContainerId);
    if (!element) return null;

    const resolvedFrameId = frameId || element.dataset.lazyContainerFrameValue || 'global-lazy-content';
    const container = new LazyContainer(element, { type, frameId: resolvedFrameId });
    container.open({ url, title, subtitle, size, width });
    return container;
  }

  constructor(element, { type, frameId }) {
    this.element = element;
    this.type = type;
    this.frameId = frameId;
  }

  open({ url, title = null, subtitle = null, size = null, width = null }) {
    this.applySizing({ size, width });

    const shownEvent = this.type === 'modal' ? 'shown.bs.modal' : 'shown.bs.offcanvas';
    const handler = () => {
      this.loadContent({ url, title, subtitle });
      this.element.removeEventListener(shownEvent, handler);
    };
    this.element.addEventListener(shownEvent, handler);

    this.show();
  }

  applySizing({ size, width }) {
    if (this.type === 'modal' && size) {
      const dialog = this.element.querySelector('[data-lazy-container-target="dialog"]');
      if (dialog) {
        dialog.classList.remove('modal-sm', 'modal-md', 'modal-lg', 'modal-xl');
        if (size !== 'md') {
          dialog.classList.add(`modal-${size}`);
        }
      }
    } else if (this.type === 'offcanvas' && width) {
      this.element.classList.remove('w-25', 'w-50', 'w-75', 'w-100');
      this.element.classList.add(width);
    }
  }

  loadContent({ url, title = null, subtitle = null }) {
    const bodyTarget = this.element.querySelector('[data-lazy-container-target="body"]');
    if (!bodyTarget) return;

    bodyTarget.innerHTML = `<turbo-frame id="${this.frameId}"></turbo-frame>`;

    if (title) {
      const titleTarget = this.element.querySelector('[data-lazy-container-target="title"]');
      if (titleTarget) titleTarget.textContent = title;
    }

    const subtitleTarget = this.element.querySelector('[data-lazy-container-target="subtitle"]');
    if (subtitleTarget) {
      if (subtitle) {
        subtitleTarget.textContent = subtitle;
        subtitleTarget.style.display = '';
      } else {
        subtitleTarget.style.display = 'none';
      }
    }

    const frame = document.getElementById(this.frameId);
    if (frame) {
      frame.innerHTML = LazyContainer.spinnerHTML();
    }

    Turbo.visit(url, { frame: this.frameId });
  }

  clearContent() {
    const frame = document.getElementById(this.frameId);
    if (frame) {
      frame.innerHTML = LazyContainer.spinnerHTML();
    }

    const bodyTarget = this.element.querySelector('[data-lazy-container-target="body"]');
    if (bodyTarget) {
      bodyTarget.innerHTML = '';
    }
  }

  show() {
    if (this.type === 'modal') {
      bootstrap.Modal.getOrCreateInstance(this.element).show();
    } else if (this.type === 'offcanvas') {
      bootstrap.Offcanvas.getOrCreateInstance(this.element).show();
    }
  }

  static spinnerHTML() {
    return `
      <div class="d-flex justify-content-center align-items-center h-100">
        <div class="spinner-border" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
      </div>
    `;
  }
}
