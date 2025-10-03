class PhoneSMSSender
  OPT_OUT_MESSAGE = 'To no longer receive text messages, text STOP'.freeze

  attr_accessor :message, :contact_log_from_user_id, :to_mobile_phone, :to_user, :media_url, :twilio,
                :opt_out_message_sent, :exception, :contact_log_record, :log

  delegate :from_number, to: :twilio

  def initialize(message, contact_log_from_user_id, to_mobile_phone, media_url, force_opt_out, contact_log_record: nil)
    raise "The message from user #{contact_log_from_user_id} failed: the message is blank." if message.blank?
    raise 'The message failed: the mobile phone number is blank.' if to_mobile_phone.blank?

    self.contact_log_from_user_id = contact_log_from_user_id
    self.to_mobile_phone = to_mobile_phone
    self.media_url = media_url
    self.twilio = RadTwilio.new
    self.message = augment_message(message, force_opt_out)
    self.contact_log_record = contact_log_record
  end

  def send!
    response = RadRetry.perform_request(raise_original: true) do
      if mms?
        twilio.send_mms to: to_number, message: message, media_url: media_url
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

  def blacklisted?
    # https://www.twilio.com/docs/api/errors/21610
    exception.message.include?('21610')
  end

  private

    def handle_blacklist
      # override as needed
    end

    def mms?
      media_url.present?
    end

    def augment_message(message, force_opt_out)
      if !force_opt_out && opt_out_message_already_sent?
        self.opt_out_message_sent = false
        return message
      end

      self.opt_out_message_sent = true
      return "#{message} - #{OPT_OUT_MESSAGE}" unless %w[. ! ?].include?(message[-1])

      "#{message} #{OPT_OUT_MESSAGE}."
    end

    def to_number
      RadTwilio.human_to_twilio_format(to_mobile_phone)
    end

    def opt_out_message_already_sent?
      ContactLog.opt_out_message_sent?(to_mobile_phone)
    end

    def log_event(sent, message_sid)
      @log = ContactLog.create! direction: :outgoing,
                                from_number: RadTwilio.twilio_to_human_format(from_number),
                                from_user_id: contact_log_from_user_id,
                                content: message,
                                sms_media_url: media_url,
                                sent: sent,
                                sms_message_id: message_sid,
                                sms_opt_out_message_sent: opt_out_message_sent,
                                record: contact_log_record

      ContactLogRecipient.create! contact_log: log,
                                  phone_number: to_mobile_phone,
                                  to_user: to_user,
                                  sms_status: :sent

      return if @log.sms_media_url.blank?

      log_attachments
    end

    def log_attachments
      file = RadRetry.perform_request(retry_count: 2) { URI.open(@log.sms_media_url) }

      filename = if file.respond_to?(:meta) && file.meta.has_key?('content-disposition')
                   file.meta['content-disposition'].match(/filename="[^"]+"/).to_s.gsub(/filename=|"/, '')
                 else
                   File.basename(file.path)
                 end

      @log.attachments.attach io: file,
                              content_type: file.content_type,
                              identify: false,
                              filename: filename
    end
end
