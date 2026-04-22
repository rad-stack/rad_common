class RemoveLegacyFilterSettings < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :filter_defaults
  end
end
