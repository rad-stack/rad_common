import { application } from './application';
import { radControllers } from '../rad_common_js/src/controllers/index';
import { controllers } from './app_specific/index';

[...controllers, ...radControllers].forEach(({ id, controller }) => {
  application.register(id, controller);
});

