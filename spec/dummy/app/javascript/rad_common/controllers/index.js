import GlobalSearchController from './global_search_controller';
import rad_calendar_controller from './rad_calendar_controller';
import RemoteFormController from './remote_form_controller';
import SearchController from './search_controller';
import SearchDateFilterController from './search_date_filter_controller';
import SearchMatchTypeFilterController from './search_match_type_filter_controller';
import ToastController from './toast_controller';
import TimezoneDetectionController from './timezone_detection_controller';
import ChatPollingController from './chat_polling_controller';
import LlmChatFormController from './llm_chat_form_controller';
import InvitationFormController from './invitation_forms_controller';
import CollapseStateController from './collapse_state_controller';
import ClipboardController from './clipboard_controller';

export const radControllers = [
  { id: 'global-search', controller: GlobalSearchController },
  { id: 'rad-calendar', controller: rad_calendar_controller },
  { id: 'remote-form', controller: RemoteFormController },
  { id: 'search', controller: SearchController },
  { id: 'search-date-filter', controller: SearchDateFilterController },
  { id: 'search-match-type-filter', controller: SearchMatchTypeFilterController },
  { id: 'toast', controller: ToastController },
  { id: 'timezone-detection', controller: TimezoneDetectionController },
  { id: 'chat-polling', controller: ChatPollingController },
  { id: 'llm-chat-form', controller: LlmChatFormController },
  { id: 'invitation-form', controller: InvitationFormController },
  { id: 'collapse-state', controller: CollapseStateController },
  { id: 'clipboard', controller: ClipboardController }
];
