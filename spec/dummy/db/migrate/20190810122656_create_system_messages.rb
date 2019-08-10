class CreateSystemMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :system_messages do |t|
      t.text :message, null: false
      t.integer :user_id, null: false
      t.integer :send_to, null: false, default: 0

      t.timestamps
    end

    add_index :system_messages, :user_id
    add_foreign_key :system_messages, :users
  end
end
