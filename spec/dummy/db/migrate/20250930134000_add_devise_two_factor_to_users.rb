class AddDeviseTwoFactorToUsers < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :twilio_verify_enabled, :otp_required_for_login
    remove_column :users, :last_sign_in_with_twilio_verify

    add_column :users, :otp_secret, :string
    add_column :users, :consumed_timestep, :integer
  end
end
