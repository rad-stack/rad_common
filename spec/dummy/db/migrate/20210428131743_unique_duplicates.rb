class UniqueDuplicates < ActiveRecord::Migration[6.0]
  def change
    remove_index :duplicates, name: 'index_duplicates_on_duplicatable_type_and_duplicatable_id'
    add_index :duplicates, %i[duplicatable_type duplicatable_id], unique: true
  end
end
