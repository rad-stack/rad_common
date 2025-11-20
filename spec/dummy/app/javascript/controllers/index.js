import { application } from './application';
import { radControllers } from 'rad_common/controllers/index';
import { controllers } from './app_specific/index';

[...controllers, ...radControllers].forEach(({ id, controller }) => {
  application.register(id, controller);
});

