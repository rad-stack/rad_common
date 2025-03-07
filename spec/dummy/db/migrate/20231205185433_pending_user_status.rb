class PendingUserStatus < ActiveRecord::Migration[7.0]
  def change
    return if UserStatus.none?
    return if RadConfig.pending_users?

    execute "DELETE FROM user_statuses WHERE name = 'Pending';"
  end
end
