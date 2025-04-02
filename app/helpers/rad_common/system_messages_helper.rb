module RadCommon
  module SystemMessagesHelper
    def system_message_title(system_message)
      "System Message Sent to #{enum_to_translated_option(system_message, :send_to)} " \
        "on #{format_datetime(system_message.created_at)}"
    end

    def message_type_options
      options = options_for_enum(SystemMessage, :message_type)
      options.reject! { |option| option.include?('sms') } unless RadConfig.twilio_enabled?
      options
    end

    def message_send_to_options
      options = options_for_enum(SystemMessage, :send_to)
      options.reject! { |option| option.include?('external_users') } unless RadConfig.external_users?
      options
    end

    def system_message_show_data(system_message)
      [{ label: 'Message', value: system_message.html_message }, :message_type, :security_role]
    end
  end
end
