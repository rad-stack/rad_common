class StalePendingUserCleaner
  def run
    return unless RadConfig.pending_users?

    users = User.pending.select(&:stale?)
    return if users.empty?

    users.each do |user|
      info = { name: user.to_s, email: user.email, mobile_phone: user.mobile_phone, created_at: user.created_at }
      user.destroy!
      Notifications::StalePendingUserDeletedNotification.main(info).notify!
    end
  end
end
