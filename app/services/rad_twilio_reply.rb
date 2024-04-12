class RadTwilioReply
  attr_accessor :params

  def initialize(params)
    self.params = params
  end

  def process!
    raise 'invalid' unless valid?

    log_event
  end

  def valid?
    message.present? && params[:From].present? && params[:To].present? && params[:MessageSid].present?
  end

  private

    def log_event
      log = ContactLog.create! log_type: :incoming,
                               to_number: to_number,
                               from_number: from_number,
                               from_user_id: from_user_id,
                               message: message,
                               sent: true,
                               message_sid: message_sid,
                               success: true,
                               opt_out_message_sent: false
      handle_attachments(log)
    end

    def from_number
      RadTwilio.twilio_to_human_format(params[:From])
    end

    def from_user
      User.find_by(mobile_phone: from_number)
    end

    def from_user_id
      return if from_user.blank?

      from_user.id
    end

    def to_number
      RadTwilio.twilio_to_human_format(params[:To])
    end

    def message
      return params[:Body] if params[:Body].present?

      return 'File' if media_urls.present?
    end

    def message_sid
      params[:MessageSid]
    end

    def handle_attachments(contact_log)
      return if media_urls.none?

      media_urls.each do |media_url|
        log_attachment = ContactLogAttachment.new(contact_log: contact_log, twilio_url: media_url)
        file = URI.parse(media_url).open(http_basic_authentication: [RadConfig.twilio_account_sid!,
                                                                     RadConfig.twilio_auth_token!])
        log_attachment.attachment.attach(io: file, filename: File.basename(media_url))
        log_attachment.save!
      end
    end

    def media_urls
      params.slice(*params.keys.select { |value| value.match(/MediaUrl\d+/) }).values.compact
    end
end
