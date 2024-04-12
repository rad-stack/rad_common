class PhoneSMSSender
  OPT_OUT_MESSAGE = 'To no longer receive text messages, text STOP'.freeze

  attr_accessor :message, :from_user_id, :to_mobile_phone, :to_user, :media_url, :twilio, :opt_out_message_sent,
                :exception, :twilio_log_attachments

  delegate :from_number, to: :twilio

  def initialize(message, from_user_id, to_mobile_phone, media_url, force_opt_out, twilio_log_attachment_ids = nil)
    message = 'File' if message.blank? && twilio_log_attachment_ids.present?
    raise "The message from user #{from_user_id} failed: the message is blank." if message.blank?
    raise 'The message failed: the mobile phone number is blank.' if to_mobile_phone.blank?

    self.from_user_id = from_user_id
    self.to_mobile_phone = to_mobile_phone
    self.media_url = media_url
    self.twilio = RadTwilio.new
    if twilio_log_attachment_ids.present?
      self.twilio_log_attachments = ContactLogAttachment.where(id: twilio_log_attachment_ids)
    end
    self.message = augment_message(message, force_opt_out)
  end

  def send!
    response = RadRetry.perform_request(raise_original: true) do
      if mms?
        url = if image_files.present?
                image_files.map { |log_attachment| log_attachment.attachment.url }
              else
                media_url
              end
        twilio.send_mms to: to_number, message: message, media_url: url
      else
        twilio.send_sms to: to_number, message: message
      end
    end

    log_event true, response.sid
    true
  rescue Twilio::REST::RestError => e
    self.exception = e
    raise e.message unless blacklisted?

    log_event false, nil
    handle_blacklist
    false
  end

  private

    def handle_blacklist
      # override as needed
    end

    def image_files
      return [] if twilio_log_attachments.nil?

      twilio_log_attachments.images
    end

    def other_files
      return [] if twilio_log_attachments.nil?

      twilio_log_attachments.other_files
    end

    def mms?
      media_url.present? || image_files.present?
    end

    def augment_message(message, force_opt_out)
      message = maybe_add_attachment_urls(message)
      if !force_opt_out && opt_out_message_already_sent?
        self.opt_out_message_sent = false
        return message
      end

      self.opt_out_message_sent = true
      return "#{message} - #{OPT_OUT_MESSAGE}" unless %w[. ! ?].include?(message[-1])

      "#{message} #{OPT_OUT_MESSAGE}."
    end

    def maybe_add_attachment_urls(message)
      return message if other_files.empty?

      urls = other_files.map(&:attachment)
                        .map { |file| AttachmentUrlGenerator.permanent_attachment_url(file) }
                        .join(' ')
      message = "#{message} #{urls}" if urls.present?
      message
    end

    def to_number
      RadTwilio.human_to_twilio_format(to_mobile_phone)
    end

    def blacklisted?
      # https://www.twilio.com/docs/api/errors/21610
      exception.message.include?('21610')
    end

    def opt_out_message_already_sent?
      ContactLog.opt_out_message_sent?(to_mobile_phone)
    end

    def log_event(sent, message_sid)
      ContactLog.create! log_type: :outgoing,
                         to_number: to_mobile_phone,
                         from_number: RadTwilio.twilio_to_human_format(from_number),
                         to_user: to_user,
                         from_user_id: from_user_id,
                         message: message,
                         media_url: media_url,
                         sent: sent,
                         message_sid: message_sid,
                         opt_out_message_sent: opt_out_message_sent,
                         twilio_log_attachments: twilio_log_attachments.presence || []
    end
end
