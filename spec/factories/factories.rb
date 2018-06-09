FactoryBot.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    mobile_phone '(999) 231-1111'
    sequence(:email) { |n| "example#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.zone.now
    association :user_status, factory: %i[user_status active]

    factory :admin do |f|
      f.after(:create) { |user| user.security_roles << SecurityRole.find_by(name: 'Admin') }
    end

    factory :super_admin do |f|
      super_admin true
      f.after(:create) { |user| user.security_roles << SecurityRole.find_by(name: 'Admin') }
    end

    factory :pending do |f|
      association :user_status, factory: %i[user_status pending]
    end
  end

  factory :company do
    name Faker::Company.name
    address_1 Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zipcode Faker::Address.zip
    phone_number '(444) 444-4444'
    website Faker::Internet.url
    email Faker::Internet.email
  end

  factory :security_role do
    sequence(:name) { |n| "Role #{n}" }
  end

  factory :user_status do
    sequence(:name) { |n| "Status #{n}" }

    trait :pending do
      active false
      validate_email true
    end

    trait :active do
      active true
      validate_email true
    end

    trait :inactive do
      active false
      validate_email false
    end
  end

  factory :division do
    sequence(:name) { |n| "Division #{n + 1}" }
    sequence(:code) { |n| "Code #{n + 1}" }
    association :owner, factory: :user
    division_status :status_active
  end
end
