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
import FormulaEditorController from './formula_editor_controller';
import ReportBuilderController from './report_builder_controller';
import SortableController from './sortable_controller';
import CalculatedColumnFormController from './calculated_column_form_controller';
import CustomReportFilterFormController from './custom_report_filter_form_controller';
import ConfigEditorController from './config_editor_controller';

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
  { id: 'clipboard', controller: ClipboardController },
  { id: 'formula-editor', controller: FormulaEditorController },
  { id: 'report-builder', controller: ReportBuilderController },
  { id: 'sortable', controller: SortableController },
  { id: 'calculated-column-form', controller: CalculatedColumnFormController },
  { id: 'custom-report-filter-form', controller: CustomReportFilterFormController },
  { id: 'config-editor', controller: ConfigEditorController }
];
