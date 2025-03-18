class DuplicatesProcessed < ActiveRecord::Migration[6.0]
  def change
    add_column :duplicates, :processed_at, :datetime
    execute 'UPDATE duplicates SET processed_at = updated_at;' if Duplicate.exists?
    change_column_null :duplicates, :processed_at, false
  end
end
