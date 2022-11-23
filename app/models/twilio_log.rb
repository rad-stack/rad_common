class TwilioLog < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User', optional: true

  enum twilio_status: { accepted: 0,
                        scheduled: 1,
                        queued: 2,
                        sending: 3,
                        sent: 4,
                        receiving: 5,
                        delivered: 6,
                        undelivered: 7,
                        failed: 8 }, _prefix: true

  before_validation :check_success

  def self.opt_out_message_sent?(to_number)
    TwilioLog.where(sent: true, opt_out_message_sent: true, to_number: to_number).limit(1).any?
  end

  def status
    return 'not sent' unless sent_to_twilio?

    twilio_status
  end

  private

    def check_success
      return unless twilio_status_delivered?

      self.success = true
    end
end
