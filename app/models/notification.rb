class Notification < ApplicationRecord
  include Authority::Abilities

  has_many :user_notifications, dependent: :restrict_with_error

  attr_accessor :subject

  def self.new_user_signed_up(user)
    notification = Notification.find_by(name: 'new_user_signed_up')
    notification.subject = user
    notification.notify!
  end

  def self.user_was_approved(user, approved_by)
    notification = Notification.find_by(name: 'user_was_approved')
    notification.subject = [user, approved_by]
    notification.notify!
  end

  def self.global_validity(error_messages)
    notification = Notification.find_by(name: 'global_validity')
    notification.subject = error_messages
    notification.notify!
  end

  def notify!
    raise "no users for notification: #{name}" if notify_list.count.zero?

    case name
    when 'new_user_signed_up'
      RadbearMailer.new_user_signed_up(notify_user_ids, @subject).deliver_later
    when 'user_was_approved'
      user = @subject.first
      RadbearMailer.user_was_approved(notify_user_ids - [user.id], user, @subject.last).deliver_later
    when 'global_validity'
      RadbearMailer.global_validity(notify_user_ids, @subject).deliver_later
    else
      raise "unknown notification: #{name}"
    end
  end

  def self.seed_items
    return unless Notification.count.zero?

    names = %w[new_user_signed_up user_was_approved global_validity]

    names.each do |name|
      notification = Notification.create!(name: name)
      notification.seed_users
    end
  end

  def seed_users
    users = name == 'global_validity' ? User.super_admins : User.admins
    raise 'no users' if users.count.zero?

    users.each do |user|
      user_notifications.create! user: user
    end
  end

  private

    def notify_list
      user_notifications.enabled
    end

    def notify_user_ids
      notify_list.pluck(:user_id)
    end
end
