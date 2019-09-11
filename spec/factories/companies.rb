FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    address_1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip }
    phone_number { '(444) 444-4444' }
    website { Faker::Internet.url }
    email { Faker::Internet.email }
    valid_user_domains { ['example.com'] }
    timezone { 'Eastern Time (US & Canada)' }
  end
end
