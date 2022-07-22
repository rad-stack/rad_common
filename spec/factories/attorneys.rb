FactoryBot.define do
  factory :attorney do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    company_name { Faker::Company.name }
    address_1 { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address if rand(1..4) == 1 }
    city { Faker::Address.city }
    state { StateOptions.sample }
    zipcode { Faker::Address.zip_code[0..4] }
    phone_number { create :phone_number }
    email { Faker::Internet.email }
    bypass_address_validation { true }
  end
end
