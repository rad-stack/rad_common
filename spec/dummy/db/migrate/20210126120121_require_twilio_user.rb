class RequireTwilioUser < ActiveRecord::Migration[6.0]
  def change
    drop_table :twilio_logs

    create_table :twilio_logs do |t|
      t.string :from_number, null: false
      t.string :to_number, null: false
      t.integer :from_user_id, null: false
      t.integer :to_user_id
      t.string :message, null: false
      t.string :media_url
      t.boolean :success, null: false, default: true

      t.timestamps
    end

    add_index :twilio_logs, :from_user_id
    add_foreign_key :twilio_logs, :users, column: :from_user_id

    add_index :twilio_logs, :to_user_id
    add_foreign_key :twilio_logs, :users, column: :to_user_id
  end
end
