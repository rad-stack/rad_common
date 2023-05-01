class CreateTwilioLogAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :twilio_log_attachments do |t|
      t.references :twilio_log, foreign_key: true
      t.string :twilio_url
      t.timestamps
    end
  end
end
