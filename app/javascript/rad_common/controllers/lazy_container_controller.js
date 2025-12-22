import { Controller } from '@hotwired/stimulus';
import { Turbo } from '@hotwired/turbo-rails';

export default class extends Controller {
  static targets = ['title', 'subtitle'];
  static values = { frame: String, type: String };

  connect() {
    if (this.typeValue === 'modal') {
      this.element.addEventListener('shown.bs.modal', this.loadContent.bind(this));
      this.element.addEventListener('hidden.bs.modal', this.clearContent.bind(this));
    } else if (this.typeValue === 'offcanvas') {
      this.element.addEventListener('shown.bs.offcanvas', this.loadContent.bind(this));
      this.element.addEventListener('hidden.bs.offcanvas', this.clearContent.bind(this));
    }
  }

  loadContent(event) {
    const trigger = event.relatedTarget;
    if (!trigger) return;

    const url = trigger.dataset.lazyUrl;
    if (!url) return;

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
