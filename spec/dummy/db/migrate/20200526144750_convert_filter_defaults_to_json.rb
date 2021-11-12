class ConvertFilterDefaultsToJson < ActiveRecord::Migration[6.0]
  def change
    return unless  column_exists? :users, :filter_defaults

    remove_column :users, :filter_defaults
    add_column :users, :filter_defaults, :jsonb
  end
end
