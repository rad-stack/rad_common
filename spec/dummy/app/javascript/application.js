require('trix');
require('@rails/actiontext');

import 'rad_common_js/src/jquery';
import 'rad_common_js/src/jqueryAreYouSure';

import { RadCommon } from 'rad_common_js/src/radCommon';
RadCommon.setup();

import './app_specific.js';
import './controllers';

document.addEventListener('DOMContentLoaded', () => {
  const targetDiv = document.getElementById('needs-js-timezone');
  if (!targetDiv) return;

  const timeZone = Intl.DateTimeFormat().resolvedOptions().timeZone;

  fetch('/set_js_timezone', {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
    },
    body: JSON.stringify({ timezone: timeZone })
  });
});
