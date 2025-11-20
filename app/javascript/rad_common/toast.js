export class Toast {
  static success(title, message, time = 5000) {
    $('#toast-nav .toast-header').removeClass('toast-error');
    $('#toast-nav .toast-header').addClass('toast-success');
    Toast.display(title, message, time, 'polite', 'status');
  }

  static error(title, message, time = 5000) {
    $('#toast-nav .toast-header').removeClass('toast-success');
    $('#toast-nav .toast-header').addClass('toast-error');
    Toast.display(title, message, time, 'assertive', 'alert');
  }

  static display(title, message, time = 5000, politeness = 'polite', alertType = 'alert') {
    $('#toast-nav-title').html(title);
    $('#toast-nav-message').html(message);
    $('#toast-nav .toast').attr('data-delay', time);
    $('#toast-nav .toast').attr('aria-polite', politeness);
    $('#toast-nav .toast').attr('aria-alert', alertType);
    $('#toast-nav .toast').toast('show');
  }
}
