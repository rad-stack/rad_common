import { Turbo } from '@hotwired/turbo-rails';
import * as bootstrap from 'bootstrap';
Turbo.session.drive = false;

import { Toast } from './toast.js';

document.addEventListener('turbo:frame-load', () => $('[data-toggle="tooltip"]').tooltip({ boundary: 'window' }));  
document.addEventListener('turbo:before-fetch-response', (event) => {
  if (event?.detail?.fetchResponse?.statusCode === 403) {
    event.preventDefault();
    Toast.error('Unauthorized', 'You are not authorized to perform this action.');
  }
});

Turbo.StreamActions.update_input = function () {
  this.targetElements.forEach((target) => {
    target.value = this.templateContent.textContent;
  });
};

Turbo.StreamActions.scroll_bottom = function () {
  this.targetElements.forEach((target) => {
    target.scrollTop = target.scrollHeight;
  });
};

Turbo.StreamActions.send_success_toast = function () {
  const message = this.getAttribute('message') || this.templateContent.textContent.trim();
  Toast.success('Success!', message);
};

Turbo.StreamActions.send_error_toast = function () {
  const message = this.getAttribute('message') || this.templateContent.textContent.trim();
  Toast.error('Error', message);
};

Turbo.StreamActions.hide_modal = function () {
  this.targetElements.forEach((target) => {
    const modal = bootstrap.Modal.getOrCreateInstance(target);
    modal.hide();
  });
};

Turbo.StreamActions.toggle_collapse = function() {
  const collapseId = this.getAttribute('target');
  const state = this.getAttribute('state');
  const collapseElement = document.getElementById(collapseId);

  let bsCollapse = collapseElement && bootstrap.Collapse.getInstance(collapseElement);
  if (!bsCollapse) {
    bsCollapse = new bootstrap.Collapse(collapseElement, { toggle: false });
  }

  if (state === 'show') {
    bsCollapse.show();
  } else if (state === 'hide') {
    bsCollapse.hide();
  }
};
