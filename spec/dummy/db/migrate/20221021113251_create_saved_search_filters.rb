class CreateSavedSearchFilters < ActiveRecord::Migration[6.1]
  def change
    create_table :saved_search_filters do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true, null: false
      t.string :search_class, null: false
      t.jsonb :search_filters, null: false, default: {}

      t.timestamps

      t.index %i[user_id name search_class], unique: true, name: 'unique_saved_search_filters'
    end
  end
end
