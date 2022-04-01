# Instructions to Migrate Projects to webpacker

1. remove `jquery-ui-rails` and `coffee-rails` from Gemfile
2. run `bundle update && rails g rad_common:install`, check/fix changes
4. remove the following files from `app/assets/javascripts` and `app/assets/stylesheets`
```
bootstrap.js
tooltip.js

bootstrap_and_overrides.scss
```
5. remove legacy references from `app/assets/javascripts/application.js` and `app/assets/stylesheets/application.scss`
```
//= require bootstrap
//= require bootstrap-sprockets
//= require bootstrap-select
//= require bootstrap-datetimepicker
//= require bootstrap_datetimepicker/dates
//= require jquery-ui/autocomplete
//= require rad_common/jquery.are_you_sure
//= require rad_common/are_you_sure_datepickers
//= require rad_common/autocomplete-rails
//= require rad_common/rad_common
//= require rad_common/readmore
//= require tooltip

 *= require bootstrap_and_overrides
 *= require bootstrap-select
 *= require jquery-ui/autocomplete
 *= require rad_common/rad_common
 *= require rad_common/devise_auth
 *= require bootstrap-datetimepicker
 *= require bootstrap_datetimepicker/dates
```

6. add the following to `app/javascript/packs/application.js`
```
import('bootstrap-select/dist/css/bootstrap-select.min.css');
import('jquery-ui/themes/base/all.css');
import('tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.min.css');
import 'rad_common_js/src/css/rad_common/jquery-ui-overrides.scss';
import 'rad_common_js/src/css/bootstrap_and_overrides.scss';
import 'rad_common_js/src/css/main.css.scss';

import { RadCommon } from 'rad_common_js/src/radCommon';
RadCommon.setup();
```
7. run `yarn install`
8. convert all js files from coffee to js using [https://decaffeinate-project.org/](https://decaffeinate-project.org/) and move to `app/javascript/src`
```
decaffeinate app/assets/javascripts/
```
9. for the coffee scripts handled in the previous step, remove the references from `application.js`
