class FilterDefaultsForAll < ActiveRecord::Migration[6.0]
  def change
    return if  column_exists? :users, :filter_defaults

    add_column :users, :filter_defaults, :jsonb
  end
end
