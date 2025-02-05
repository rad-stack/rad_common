import GlobalSearchController from './global_search_controller';
import RemoteFormController from './remote_form_controller';
import SearchController from './search_controller';
import SearchDateFilterController from './search_date_filter_controller';
import ToastController from './toast_controller';

export const radControllers = [
  { id: 'global-search', controller: GlobalSearchController },
  { id: 'remote-form', controller: RemoteFormController },
  { id: 'search', controller: SearchController },
  { id: 'search-date-filter', controller: SearchDateFilterController },
  { id: 'toast', controller: ToastController }
];
