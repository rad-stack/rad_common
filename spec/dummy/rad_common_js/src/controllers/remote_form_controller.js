import { Controller } from '@hotwired/stimulus';
import { Toast } from 'rad_common_js/src/toast';

export default class extends Controller {
  static values = { successMessage: String, errorMessage: String };
  static targets = ['form'];

  connect() {
    if (this.hasSuccessMessageValue) {
      this.showToast(this.successMessageValue, true);
    } else if (this.hasErrorMessageValue) {
      this.showToast(this.errorMessageValue, false);
    }
  }

  showToast(message, success = true) {
    if (success) {
      Toast.success('Success!', message);
    } else {
      Toast.error('Error!', message);
    }
  }

  submitForm() {
    this.formTarget.requestSubmit();
  }
}
