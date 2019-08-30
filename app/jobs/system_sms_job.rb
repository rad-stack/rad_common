class SystemSMSJob < ApplicationJob
  queue_as :default

  def perform(message, recipients, current_user)
    errors = []
    recipients.each do |user_id|
      user = User.find(user_id)
      phone_number = if user.mobile_phone.present?
                       user.mobile_phone
                     else
                       user.phone_number
                     end

      if phone_number.blank?
        errors << user.id
        next
      end

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
    RadbearMailer.simple_message([current_user.id], 'Error Sending System Message to Some Users', body).deliver_later
  end
end
