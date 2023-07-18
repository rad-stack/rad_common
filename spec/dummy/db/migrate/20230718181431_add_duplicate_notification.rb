class AddDuplicateNotification < ActiveRecord::Migration[7.0]
  def change
    return unless Rails.env.production? && SecurityRole.count.positive?

    Notifications::PossibleDuplicateFoundNotification.create! security_roles: SecurityRole.all
  end
end
