class SystemSMSJob < ApplicationJob
  queue_as :system_sms

  def perform(message, recipients, current_user)
    errors = []
    recipients.each do |user|
      phone_number = user.phone_number
      begin
        RadicalRetry.perform_request do
          RadicalTwilio.send_sms(to: phone_number, message: message, from: RadicalTwilio.twilio_phone_number)
        end
      rescue Twilio::REST::RequestError
        errors << user.id
      end
    end

    return if errors.empty?

    body = "These users did not receive a system SMS message: #{errors.join(', ')}"
    RadbearMailer.simple_message([current_user.id], 'Error Sending System Message to Some Users', body, options).deliver_later
  end
end
