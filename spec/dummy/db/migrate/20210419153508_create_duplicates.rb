class CreateDuplicates < ActiveRecord::Migration[6.0]
  def change
    create_table :duplicates do |t|
      t.string :duplicatable_type, null: false
      t.bigint :duplicatable_id, null: false
      t.text :duplicates_info
      t.text :duplicates_not
      t.integer :duplicate_score
      t.integer :duplicate_sort, default: 500, null: false

      t.timestamps
    end

    add_index :duplicates, %i[duplicatable_type duplicatable_id]
  end
end
