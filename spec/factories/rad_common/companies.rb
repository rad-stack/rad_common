FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    address_1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { StateOptions.sample }
    zipcode { Faker::Address.zip }
    phone_number { create :phone_number }
    website { Faker::Internet.url }
    email { Faker::Internet.email }
    valid_user_domains { ['example.com'] }
    timezone { 'Eastern Time (US & Canada)' }
    bypass_address_validation { true }
  end
end
