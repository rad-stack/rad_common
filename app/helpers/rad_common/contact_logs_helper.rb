module RadCommon
  module ContactLogsHelper
    def format_contact_log_recipients(recipients, to_field)
      recipients.map { |recipient|
        "#{recipient.public_send(to_field)} (#{enum_to_translated_option(recipient, :service_status)})"
      }.join(', ')
    end
  end
end
