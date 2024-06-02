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
      log = ContactLog.create! sms_log_type: :incoming,
                               from_number: from_number,
                               from_user_id: from_user_id,
                               content: message,
                               sent: true,
                               sms_message_id: message_sid,
                               sms_opt_out_message_sent: false

      ContactLogRecipient.create! contact_log: log, phone_number: to_number, success: true
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

      'File' if media_urls.present?
    end

    def message_sid
      params[:MessageSid]
    end

    def media_urls
      params.slice(*params.keys.select { |value| value.match(/MediaUrl\d+/) }).values.compact
    end
end
