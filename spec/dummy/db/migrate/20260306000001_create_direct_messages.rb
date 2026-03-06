class CreateDirectMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :direct_messages do |t|
      t.references :from_user, null: false, foreign_key: { to_table: :users }
      t.references :to_user, null: false, foreign_key: { to_table: :users }
      t.jsonb :log, default: []

      t.timestamps
    end
  end
end
