require('trix');
require('@rails/actiontext');

import 'rad_common/jquery';
import 'rad_common/jqueryAreYouSure';

import { RadCommon } from 'rad_common/radCommon';
RadCommon.setup();

import './app_specific.js';
import './controllers';
