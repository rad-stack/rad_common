import bootstrap from 'bootstrap';

export class Toast {
  static success(title, message, time = 5000, url = null, element = null) {
    const toastElement = element || document.querySelector('#toast-stream-container .toast');
    const toastHeader = toastElement.querySelector('.toast-header');
    toastHeader.classList.remove('toast-error');
    toastHeader.classList.add('toast-success');
    Toast.display(title, message, time, 'polite', 'status', url, toastElement);
  }

  static error(title, message, time = 5000, url = null, element = null) {
    const toastElement = element || document.querySelector('#toast-stream-container .toast');
    const toastHeader = toastElement.querySelector('.toast-header');
    toastHeader.classList.remove('toast-success');
    toastHeader.classList.add('toast-error');
    Toast.display(title, message, time, 'assertive', 'alert', url, toastElement);
  }

  static display(title, message, time = 5000, politeness = 'polite', alertType = 'alert', url = null, toastElement = null) {
    if (!toastElement) {
      toastElement = document.querySelector('#toast-stream-container .toast');
    }

    const linkElement = toastElement.querySelector('.toast-header a');
    if (url && linkElement) {
      linkElement.setAttribute('href', url);
      linkElement.classList.remove('d-none');
    } else if (linkElement) {
      linkElement.classList.add('d-none');
    }

    const titleElement = toastElement.querySelector('.toast-header h5');
    const messageElement = toastElement.querySelector('.toast-body .lead');

    if (titleElement) titleElement.innerHTML = title;
    if (messageElement) messageElement.innerHTML = message;

    if (time === 0) {
      toastElement.setAttribute('data-bs-autohide', 'false');
    } else {
      toastElement.setAttribute('data-bs-delay', time);
    }
    toastElement.setAttribute('aria-live', politeness);
    toastElement.setAttribute('role', alertType);

    const toast = new bootstrap.Toast(toastElement);
    toast.show();
  }
}
