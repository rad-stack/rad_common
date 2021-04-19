class RemoveOldDupes < ActiveRecord::Migration[6.0]
  def change
    remove_column :attorneys, :duplicates_info
    remove_column :attorneys, :duplicates_not
    remove_column :attorneys, :duplicate_score
    remove_column :attorneys, :duplicate_sort
    remove_column :attorneys, :duplicates_processed_at
  end
end
