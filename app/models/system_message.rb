class SystemMessage < ApplicationRecord
  include Authority::Abilities

  belongs_to :user

  enum send_to: %i[internal_users client_users all_users preview]
  enum message_type: %i[email sms]

  scope :recent_first, -> { order(created_at: :desc) }

  before_validation :maybe_strip_tags

  def to_s
    "System Message from #{user}"
  end

  def self.recent_or_new(user)
    last_message = user.system_messages.recent_first.first
    return SystemMessage.new if last_message.blank?

    SystemMessage.new(send_to: last_message.send_to, message: last_message.message)
  end

  def recipients
    return [user] if preview?

    users = User.active

    users = users.internal if internal_users?
    users = users.external if client_users?

    users
  end

  def send!(current_user)
    if email?
      recipients.each do |user|
        RadbearMailer.simple_message(user, "Important Message From #{I18n.t(:app_name)}", message).deliver_later
      end
    else
      SystemSMSJob.perform_later(message, recipients.map(&:id), current_user)
    end
  end

  private

    def maybe_strip_tags
      self.message = ApplicationController.helpers.strip_tags(message) if message.present? && sms?
    end
end
