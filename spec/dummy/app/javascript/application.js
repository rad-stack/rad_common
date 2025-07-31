require('trix');
require('@rails/actiontext');

import 'rad_common_js/src/jquery';
import 'rad_common_js/src/jqueryAreYouSure';

import { RadCommon } from 'rad_common_js/src/radCommon';
RadCommon.setup();

import 'chartkick/chart.js';
import './app_specific.js';
import './controllers';
