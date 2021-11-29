class ConvertFilterDefaultsToJson < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :filter_defaults, :jsonb
  end
end
