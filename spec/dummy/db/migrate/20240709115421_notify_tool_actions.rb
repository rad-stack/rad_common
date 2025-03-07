class NotifyToolActions < ActiveRecord::Migration[7.0]
  def change
    return unless Rails.env.production?

    message_body = "The 'Show History' and 'Reset Duplicates' links on the lower right of the page footer has been " \
                   "moved to a button on the top header with an icon of a gear."

    record = SystemMessage.create! security_role: SecurityRole.find_by!(admin: true),
                                   user: User.active.admins.first,
                                   send_to: :internal_users,
                                   message_type: :email,
                                   email_message_body: message_body

    record.send!
  end
end
