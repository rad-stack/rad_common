class RanLongNotification < ActiveRecord::Migration[6.0]
  def change
    return unless Rails.env.production? && SecurityRole.exists?

    Notifications::GlobalValidityRanLongNotification.create! security_roles: [SecurityRole.admin_role]
  end
end
