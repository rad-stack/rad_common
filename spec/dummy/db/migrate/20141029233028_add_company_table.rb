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
    
    company = Company.new
    company.name = "ABC Company"
    company.phone_number = "(800) 123-2000"
    company.website = "http://www.example.com"
    company.email = "info@example.com"
    company.address_1 = "100 1st Street"
    company.city = "Neptune Beach"
    company.state = "FL"
    company.zipcode = "32246"
    company.save!
  end
end
