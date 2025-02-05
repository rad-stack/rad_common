import { Turbo } from '@hotwired/turbo-rails';
Turbo.session.drive = false;

import { Toast } from 'rad_common_js/src/toast.js';

document.addEventListener('turbo:frame-load', () => $('[data-toggle="tooltip"]').tooltip({ boundary: 'window' }));  
document.addEventListener('turbo:before-fetch-response', (event) => {
  if (event?.detail?.fetchResponse?.statusCode === 403) {
    event.preventDefault();
    Toast.error('Unauthorized', 'You are not authorized to perform this action.');
  }
});
