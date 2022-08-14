require('trix');
require('@rails/actiontext');
require('chosen-js/chosen.jquery.min');

import 'trix/dist/trix.css';
import 'rad_common_js/src/css/actiontext.scss';
import 'bootstrap-select/dist/css/bootstrap-select.min.css';
import 'jquery-ui/themes/base/all.css';
import 'tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.min.css';
import 'rad_common_js/src/css/rad_common/jquery-ui-overrides.scss';
import 'rad_common_js/src/css/bootstrap_and_overrides.scss';
import 'rad_common_js/src/css/main.css.scss';
import '@fortawesome/fontawesome-free/css/all';
import 'chosen-js/chosen.min.css';

import { RadCommon } from 'rad_common_js/src/radCommon';
RadCommon.setup();

$(document).ready(function() {
    $('.rad-chosen').chosen({
        allow_single_deselect: true,
        no_results_text: 'No matching records found',
        width: '100%'
    });
})

import './app_specific.js'
