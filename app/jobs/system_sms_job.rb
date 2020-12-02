class SystemSMSJob < ApplicationJob
  queue_as :default

  attr_accessor :message, :recipients, :current_user, :media_url, :error_lines, :from

  def perform(message, recipients, current_user, media_url)
    self.message = message
    self.recipients = recipients
    self.current_user = current_user
    self.media_url = media_url

    self.error_lines = []
    self.from = RadicalTwilio.next_phone_number

    recipients.each do |user_id|
      user = User.find(user_id)

      if user.mobile_phone.blank?
        error_lines.push "The message to #{user} failed: they do not have a mobile phone number."
        next
      end

      send_message user
    end

    handle_problems
  end

  private

    def send_message(user)
      RadicalRetry.perform_request do
        if media_url.present?
          RadicalTwilio.send_mms from: from, to: "+1#{user.mobile_phone}", message: message, media_url: media_url
        else
          # TODO: why not +1 like above?
          RadicalTwilio.send_sms from: from, to: user.mobile_phone, message: message
        end
      end
    rescue Twilio::REST::RestError => e
      # TODO: will this be captured even though that exception is handled by rad retry?
      error_lines.push "The message to #{user} failed: #{e.description}."
    end

    def handle_problems
      # TODO: what to do if no current user?
      return if error_count.zero? || current_user.blank?

      RadbearMailer.simple_message(current_user, error_subject, error_body).deliver_later
    end

    def recipient_count
      recipients.count
    end

    def error_count
      error_lines.count
    end

    def error_subject
      if recipient_count == 1
        "Error Sending #{message_type} Message"
      else
        "Error Sending #{message_type} Messages"
      end
    end

    def message_type
      media_url.present? ? 'MMS' : 'SMS'
    end

    def error_body
      error_lines.join('/n')
    end
end
