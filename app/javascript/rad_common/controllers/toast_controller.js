import { Controller } from '@hotwired/stimulus';
import { Toast } from '../toast';

export default class extends Controller {
  static values = { successMessage: String, errorMessage: String };

  connect() {
    if (this.successMessageValue) {
      Toast.success('Success!', this.successMessageValue);
    }

    if (this.errorMessageValue) {
      Toast.error('Error!', this.errorMessageValue, 10000);
    }
  }
}
