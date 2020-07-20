FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    mobile_phone { Faker::PhoneNumber.cell_phone }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { Rails.env.development? ? 'password' : 'cOmpl3x_p@55w0rd' }
    password_confirmation { Rails.env.development? ? 'password' : 'cOmpl3x_p@55w0rd' }
    confirmed_at { Time.current }
    association :user_status, factory: %i[user_status active]
    do_not_notify_approved { true }
    security_roles { [create(:security_role)] }
    authy_enabled { false }

    trait :external do
      external { true }
    end

    factory :admin do
      security_roles { [create(:security_role, :admin)] }
    end

    factory :pending do
      association :user_status, factory: %i[user_status pending]
    end
  end
end
