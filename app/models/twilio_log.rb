class TwilioLog < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User', optional: true

  def self.opt_out_message_sent?(to_number)
    TwilioLog.where(success: true, opt_out_message_sent: true, to_number: to_number).limit(1).any?
  end
end
