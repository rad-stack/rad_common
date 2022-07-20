FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    address_1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code[0..4] }
    phone_number { create :phone_number }
    website { Faker::Internet.url }
    email { Faker::Internet.email }
    valid_user_domains { ['example.com'] }
    timezone { 'Eastern Time (US & Canada)' }
    bypass_address_validation { true }
  end
end
