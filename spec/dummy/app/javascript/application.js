require('trix');
require('@rails/actiontext');

import * as ActiveStorage from '@rails/activestorage';
ActiveStorage.start();

import 'rad_common_js/src/jquery';
import 'rad_common_js/src/jqueryAreYouSure';

import { RadCommon } from 'rad_common_js/src/radCommon';
RadCommon.setup();

import './app_specific.js';
import './controllers';
