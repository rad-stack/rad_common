import bootstrap from 'bootstrap';

export class Toast {
  static success(title, message, time = 5000) {
    const toastHeader = document.querySelector('#toast-nav .toast-header');
    toastHeader.classList.remove('toast-error');
    toastHeader.classList.add('toast-success');
    Toast.display(title, message, time, 'polite', 'status');
  }

  static error(title, message, time = 5000) {
    const toastHeader = document.querySelector('#toast-nav .toast-header');
    toastHeader.classList.remove('toast-success');
    toastHeader.classList.add('toast-error');
    Toast.display(title, message, time, 'assertive', 'alert');
  }

  static display(title, message, time = 5000, politeness = 'polite', alertType = 'alert') {
    document.getElementById('toast-nav-title').innerHTML = title;
    document.getElementById('toast-nav-message').innerHTML = message;

    const toastElement = document.querySelector('#toast-nav .toast');
    toastElement.setAttribute('aria-polite', politeness);
    toastElement.setAttribute('aria-alert', alertType);
    toastElement.setAttribute('data-delay', time.toString());

    const toast = new bootstrap.Toast(toastElement);
    toast.show();
  }
}
