require('trix');
require('@rails/actiontext');
import * as ActionCable from '@rails/actioncable';
ActionCable.createConsumer();

import * as ActiveStorage from '@rails/activestorage';
ActiveStorage.start();

import 'rad_common/jquery';
import 'rad_common/jqueryAreYouSure';

import { RadCommon } from 'rad_common/radCommon';
RadCommon.setup();

import './app_specific.js';
import './controllers';
