class AddOtpDeliveryMethodToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :otp_delivery_method, :string, default: 'sms'
  end
end
