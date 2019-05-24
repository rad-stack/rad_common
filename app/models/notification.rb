class Notification < ApplicationRecord
  include Authority::Abilities

  belongs_to :notification_type
  belongs_to :user

  private

    def notify_user_ids
      the_type = NotificationType.find_by(name: self.class.name)
      the_type.notify_list(true).pluck(:id)
    end
end
