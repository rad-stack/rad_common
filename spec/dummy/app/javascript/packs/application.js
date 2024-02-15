require('trix');
require('@rails/actiontext');
require.context('../images', true);

import 'trix/dist/trix.css';
import 'rad_common_js/src/css/actiontext.scss';
import 'bootstrap-select/dist/css/bootstrap-select.min.css';
import 'jquery-ui/themes/base/all.css';
import 'rad_common_js/src/css/rad_common/jquery-ui-overrides.scss';
import 'rad_common_js/src/css/bootstrap_and_overrides.scss';
import 'rad_common_js/src/css/main.css.scss';
import '@fortawesome/fontawesome-free/css/all';

import { RadCommon } from 'rad_common_js/src/radCommon';
RadCommon.setup();

import './app_specific.js';
