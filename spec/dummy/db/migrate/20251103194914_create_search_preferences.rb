class CreateSearchPreferences < ActiveRecord::Migration[7.2]
  def change
    create_table :search_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.string :search_class, null: false
      t.integer :toggle_behavior
      t.boolean :sticky_filters, default: false, null: false
      t.jsonb :search_filters, default: {}, null: false

      t.timestamps
    end

    add_index :search_preferences, [:user_id, :search_class], unique: true, name: 'unique_search_preferences'
  end
end
