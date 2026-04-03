FactoryBot.define do
  factory :assistant_session do
    user
    chat_class { 'LLM::ChatTypes::SystemChat' }
    status { :completed }
    log { [] }

    before(:create) do
      if RadAssistant.chat_types.exclude?(LLM::ChatTypes::SystemChat)
        RadAssistant.register_chat_type(LLM::ChatTypes::SystemChat)
      end
    end
  end
end
