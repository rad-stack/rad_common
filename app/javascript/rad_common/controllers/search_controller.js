import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['savedNameInput', 'form'];

  saveAndApplyFilters(event) {
    event.preventDefault();
    const filterName = window.prompt('Enter a filter name', '');
    if (filterName) {
      this.savedNameInputTarget.value = filterName;
      this.formTarget.classList.remove('dirty');
      this.formTarget.submit();
    } else {
      window.alert('Name was not provided, filter could not be saved.');
    }
  }
}
