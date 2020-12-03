class SystemMessage < ApplicationRecord
  belongs_to :user

  enum send_to: { internal_users: 0, client_users: 1, all_users: 2, preview: 3 }
  enum message_type: { email: 0, sms: 1 }

  scope :recent_first, -> { order(id: :desc) }

  has_rich_text :email_message_body

  validates :sms_message_body, presence: true, if: :sms?
  validates :sms_message_body, absence: true, if: :email?

  validates :email_message_body, presence: true, if: :email?
  validates :email_message_body, absence: true, if: :sms?

  before_validation :erase_other

  def to_s
    "System Message from #{user}"
  end

  def self.recent_or_new(user)
    last_message = user.system_messages.recent_first.first
    return SystemMessage.new if last_message.blank?

    msg = SystemMessage.new(send_to: last_message.send_to,
                            message_type: last_message.message_type,
                            sms_message_body: last_message.sms_message_body)

    msg.email_message_body = last_message.email_message_body if last_message.email?
    msg
  end

  def recipients
    users = User.active

    users = users.where(id: user.id) if preview?
    users = users.internal if internal_users?
    users = users.external if client_users?
    users = users.with_mobile_phone if sms?

    users
  end

  def html_message
    sms? ? sms_message_body.html_safe : email_message_body
  end

  def send!
    recipients.each do |recipient|
      if email?
        RadbearMailer.simple_message(recipient,
                                     "Important Message From #{I18n.t(:app_name)}",
                                     email_message_body,
                                     do_not_format: true).deliver_later
      else
        SystemSMSJob.perform_later(sms_message_body, recipient.id, nil)
      end
    end
  end

  private

    def erase_other
      self.sms_message_body = nil if email?
      self.email_message_body = nil if sms?
    end
end
