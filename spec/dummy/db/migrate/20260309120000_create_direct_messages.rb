class CreateDirectMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :direct_messages do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.jsonb :log, default: []
      t.timestamps
    end

    add_index :direct_messages, %i[sender_id recipient_id], unique: true
  end
end
