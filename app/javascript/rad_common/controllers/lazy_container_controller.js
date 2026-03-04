import { Controller } from '@hotwired/stimulus';
import { LazyContainer } from '../lazyContainer';

export default class extends Controller {
  static targets = ['title', 'subtitle', 'body', 'dialog'];
  static values = { frame: String, type: String };

  connect() {
    this.lazyContainer = new LazyContainer(this.element, {
      type: this.typeValue,
      frameId: this.frameValue
    });

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

    this.lazyContainer.applySizing({
      size: trigger.dataset.lazySize,
      width: trigger.dataset.lazyWidth
    });
  }

  loadContent(event) {
    const trigger = event.relatedTarget;
    if (!trigger) return;

    const url = trigger.dataset.lazyUrl;
    if (!url) return;

    this.lazyContainer.loadContent({
      url,
      title: trigger.dataset.lazyTitle,
      subtitle: trigger.dataset.lazySubtitle
    });
  }

  clearContent() {
    this.lazyContainer.clearContent();
  }
}
