class CreateAttorneys < ActiveRecord::Migration[6.0]
  def change
    create_table :attorneys do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name
      t.string :company_name, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.string :address_1, null: false
      t.string :address_2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zipcode, null: false
      t.text :duplicates_info
      t.text :duplicates_not
      t.integer :duplicate_score
      t.integer :duplicate_sort, default: 500, null: false
      t.datetime :duplicates_processed_at

      t.timestamps
    end

    ActiveRecord::Base.connection.execute("CREATE EXTENSION fuzzystrmatch;")
  end
end
