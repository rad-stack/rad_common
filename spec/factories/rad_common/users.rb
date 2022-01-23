FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    mobile_phone { create :phone_number, :mobile }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { Rails.env.development? ? 'password' : 'cOmpl3x_p@55w0rd' }
    password_confirmation { Rails.env.development? ? 'password' : 'cOmpl3x_p@55w0rd' }
    confirmed_at { Time.current }
    association :user_status, factory: %i[user_status active]
    do_not_notify_approved { true }
    security_roles { [create(:security_role)] }
    authy_enabled { false }
    timezone { 'Eastern Time (US & Canada)' }

    trait :external do
      sequence(:email) { |n| "example#{n}@abc.com" }
      external { true }
      security_roles { [create(:security_role, :external)] }
    end

    trait :with_avatar do
      avatar { test_photo }
    end

    factory :admin do
      security_roles { [create(:security_role, :admin)] }
    end

    factory :pending do
      association :user_status, factory: %i[user_status pending]
    end

    factory :customer_user do |f|
      transient do
        customer { nil }
      end

      sequence(:email) { |n| "customer_user_#{n}@abc.com" }
      security_roles { [] }
      external { true }

      f.after(:create) do |user, evaluator|
        this_customer = evaluator.customer.presence || create(:customer)
        UserCustomer.create! user: user, customer_id: this_customer.id
      end
    end
  end
end
