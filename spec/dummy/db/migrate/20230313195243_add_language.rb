class AddLanguage < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :language, :string, null: false, default: 'en'
  end
end
