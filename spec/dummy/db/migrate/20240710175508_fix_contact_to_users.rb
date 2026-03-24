class FixContactToUsers < ActiveRecord::Migration[7.0]
  def change
    # return if ContactLogRecipient.none?
    #
    # ContactLogRecipient.where(to_user: nil).each do |record|
    #   next if record.phone_number.blank? && record.email.blank?
    #
    #   if record.email.present?
    #     user = User.find_by(email: record.email)
    #     record.update_column(:to_user_id, user.id) if user.present?
    #   elsif record.phone_number.present?
    #     users = User.where(mobile_phone: record.phone_number)
    #     record.update_column(:to_user_id, users.first.id) if users.size == 1
    #   end
    # end
  end
end
