FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { 'User' }
    mobile_phone { '(999) 231-1111' }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.zone.now }
    association :user_status, factory: %i[user_status active]

    factory :admin do |f|
      f.after(:create) { |user| user.security_roles << SecurityRole.find_by(name: 'Admin') }
    end

    factory :super_admin do |f|
      f.after(:create) do |user|
        user.security_roles << SecurityRole.find_by(name: 'Admin')
        user.update!(super_admin: true)
      end
    end

    factory :pending do
      association :user_status, factory: %i[user_status pending]
    end
  end
end
