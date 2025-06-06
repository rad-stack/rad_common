class FixLastActivity < ActiveRecord::Migration[7.0]
  def change
    return unless RadConfig.user_expirable?

    User.where(last_activity_at: nil).each do |user|
      user.update_column :last_activity_at, user.current_sign_in_at.presence || user.created_at
    end
  end
end
