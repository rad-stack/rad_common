class AddCompanyTable < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :phone_number, null: false
      t.string :website, null: false
      t.string :email, null: false
      t.string :address_1, null: false
      t.string :address_2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zipcode, null: false

      t.timestamps
    end

    query = "INSERT INTO companies (name, phone_number, website, email, address_1, city, state, zipcode)
            VALUES ('ABC Company', '(800) 123-2000', 'http://www.example.com', 'info@example.com', '100 1st Street', 'Neptune Beach', 'FL', '32246' )"

    ActiveRecord::Base.connection.execute query
  end
end
