class TotpFields < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :twilio_totp_factor_sid, :string
    add_column :users, :twilio_totp_url, :string
    add_column :users, :twilio_totp_verified, :boolean, default: false
  end
end
