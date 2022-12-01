class TwilioErrorThresholdPassedNotification < ActiveRecord::Migration[6.1]
  def change
    return unless Rails.env.production? && SecurityRole.count.positive?

    Notifications::TwilioErrorThresholdPassedNotification.create! security_roles: [SecurityRole.admin_role]
  end
end
