FactoryBot.define do
  factory :assistant_session do
    user
    chat_class { 'LLM::ChatTypes::SystemChat' }
    status { :completed }
    log { [] }

    before(:create) do
      RadAssistant.register_chat_type(LLM::ChatTypes::SystemChat) unless RadAssistant.chat_types.include?(LLM::ChatTypes::SystemChat)
    end
  end
end
