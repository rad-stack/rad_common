class RemoveOtpRequiredForLogin < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :otp_required_for_login, :boolean, null: false, default: true
  end
end
