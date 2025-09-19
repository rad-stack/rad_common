class AddLLMChats < ActiveRecord::Migration[7.2]
  def change
    create_table :llm_chats do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :log
      t.references :contextable, polymorphic: true, null: true
      t.references :chat_scope, polymorphic: true, null: true
      t.integer :status, default: 1, null: false
      t.string :chat_type, null: false

      t.timestamps
    end
  end
end
