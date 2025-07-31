require('trix');
require('@rails/actiontext');

import * as ActiveStorage from '@rails/activestorage';
ActiveStorage.start();

import 'rad_common/jquery';
import 'rad_common/jqueryAreYouSure';

import { RadCommon } from 'rad_common/radCommon';
RadCommon.setup();

import 'chartkick/chart.js';
import './app_specific.js';
import './controllers';
