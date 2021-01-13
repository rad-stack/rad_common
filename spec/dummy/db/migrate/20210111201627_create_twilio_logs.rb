class CreateTwilioLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :twilio_logs do |t|
      t.string :to_number, null: false
      t.string :from_number, null: false
      t.integer :user_id
      t.string :message, null: false
      t.string :media_url
      t.boolean :success, null: false, default: true

      t.timestamps
    end

    add_index :twilio_logs, :user_id
    add_foreign_key :twilio_logs, :users
  end
end
