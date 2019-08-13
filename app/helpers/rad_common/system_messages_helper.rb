module RadCommon
  module SystemMessagesHelper
    def system_message_title(system_message)
      "System Message Sent to #{enum_to_translated_option(SystemMessage, :send_to, system_message.send_to)} "\
      "on #{format_datetime(@system_message.created_at)}"
    end
  end
end
