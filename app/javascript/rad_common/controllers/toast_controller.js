import { Controller } from '@hotwired/stimulus';
import { Toast } from '../toast';

export default class extends Controller {
  static values = { successMessage: String, errorMessage: String, header: String, url: String };

  connect() {
    if (this.successMessageValue) {
      const header = this.hasHeaderValue ? this.headerValue : 'Success!';
      Toast.success(header, this.successMessageValue, 5000, this.urlValue, this.element);
    }

    if (this.errorMessageValue) {
      const header = this.hasHeaderValue ? this.headerValue : 'Error!';
      Toast.error(header, this.errorMessageValue, 10000, this.urlValue, this.element);
    }
  }
}
