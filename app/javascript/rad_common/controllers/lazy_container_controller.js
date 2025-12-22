import { Controller } from '@hotwired/stimulus';
import { Turbo } from '@hotwired/turbo-rails';

export default class extends Controller {
  static targets = ['title', 'subtitle', 'body', 'dialog'];
  static values = { frame: String, type: String };

  connect() {
    if (this.typeValue === 'modal') {
      this.element.addEventListener('show.bs.modal', this.applySizing.bind(this));
      this.element.addEventListener('shown.bs.modal', this.loadContent.bind(this));
      this.element.addEventListener('hidden.bs.modal', this.clearContent.bind(this));
    } else if (this.typeValue === 'offcanvas') {
      this.element.addEventListener('show.bs.offcanvas', this.applySizing.bind(this));
      this.element.addEventListener('shown.bs.offcanvas', this.loadContent.bind(this));
      this.element.addEventListener('hidden.bs.offcanvas', this.clearContent.bind(this));
    }
  }

  applySizing(event) {
    const trigger = event.relatedTarget;
    if (!trigger) return;

    if (this.typeValue === 'modal') {
      const size = trigger.dataset.lazySize;
      if (size && this.hasDialogTarget) {
        this.dialogTarget.classList.remove('modal-sm', 'modal-md', 'modal-lg', 'modal-xl');
        if (size !== 'md') {
          this.dialogTarget.classList.add(`modal-${size}`);
        }
      }
    } else if (this.typeValue === 'offcanvas') {
      const width = trigger.dataset.lazyWidth;
      if (width) {
        this.element.classList.remove('w-25', 'w-50', 'w-75', 'w-100');
        this.element.classList.add(width);
      }
    }
  }

  loadContent(event) {
    const trigger = event.relatedTarget;
    if (!trigger) return;

    const url = trigger.dataset.lazyUrl;
    if (!url) return;

    this.bodyTarget.innerHTML = `<turbo-frame id="${this.frameValue}"></turbo-frame>`;

    const title = trigger.dataset.lazyTitle;
    if (title && this.hasTitleTarget) {
      this.titleTarget.textContent = title;
    }

    const subtitle = trigger.dataset.lazySubtitle;
    if (subtitle && this.hasSubtitleTarget) {
      this.subtitleTarget.textContent = subtitle;
      this.subtitleTarget.style.display = '';
    } else if (this.hasSubtitleTarget) {
      this.subtitleTarget.style.display = 'none';
    }

    const frame = document.getElementById(this.frameValue);
    if (frame) {
      frame.innerHTML = this.spinnerHTML();
    }

    Turbo.visit(url, { frame: this.frameValue });
  }

  clearContent() {
    const frame = document.getElementById(this.frameValue);
    if (frame) {
      frame.innerHTML = this.spinnerHTML();
    }
    this.bodyTarget.innerHTML = '';
  }

  spinnerHTML() {
    return `
      <div class="d-flex justify-content-center align-items-center h-100">
        <div class="spinner-border" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
      </div>
    `;
  }
}
