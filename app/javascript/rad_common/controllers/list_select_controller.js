import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['item'];

  select(event) {
    this.itemTargets.forEach(item => item.classList.remove('active'));
    event.currentTarget.classList.add('active');
  }
}
