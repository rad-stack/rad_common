import ChatPollingController from './chat_polling_controller';
import LlmChatFormController from './llm_chat_form_controller';
export const controllers = [{ id: 'chat-polling', controller: ChatPollingController },
                                                   { id: 'llm-chat-form', controller: LlmChatFormController }];
