import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static classes = ['dragging'];

  connect() {
    this.draggedElement = null;
  }

  handleDragStart(event) {
    this.draggedElement = event.currentTarget;
    event.currentTarget.classList.add(this.draggingClass);
    event.dataTransfer.effectAllowed = 'move';
    event.dataTransfer.setData('text/html', event.currentTarget.innerHTML);
  }

  handleDragEnd(event) {
    event.currentTarget.classList.remove(this.draggingClass);
    this.draggedElement = null;
  }

  handleDragOver(event) {
    event.preventDefault();
    event.dataTransfer.dropEffect = 'move';

    const target = event.currentTarget;

    if (this.draggedElement && this.draggedElement !== target) {
      const rect = target.getBoundingClientRect();
      const midpoint = rect.top + rect.height / 2;
      const parent = target.parentNode;

      if (event.clientY < midpoint) {
        if (target.previousElementSibling !== this.draggedElement) {
          parent.insertBefore(this.draggedElement, target);
        }
      } else {
        if (target.nextElementSibling !== this.draggedElement) {
          parent.insertBefore(this.draggedElement, target.nextSibling);
        }
      }
    }
  }

  handleDrop(event) {
    event.preventDefault();
    event.stopPropagation();
  }
}
