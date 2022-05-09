class RenameValidateEmail < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_statuses, :validate_email, :validate_email_phone
  end
end
