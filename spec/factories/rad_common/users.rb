FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    mobile_phone { create :phone_number, :mobile }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { Rails.env.development? ? 'password' : 'cOmpl3x_p@55w0rd' }
    password_confirmation { Rails.env.development? ? 'password' : 'cOmpl3x_p@55w0rd' }
    confirmed_at { Time.current }
    user_status { UserStatus.default_active_status.presence || create(:user_status, :active) }
    do_not_notify_approved { true }
    security_roles { [create(:security_role)] }
    twilio_verify_enabled { false }
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
      security_roles { [SecurityRole.find_by(admin: true).presence || create(:security_role, :admin)] }
    end

    factory :pending do
      user_status factory: %i[user_status pending]
    end

    trait :inactive do
      user_status factory: %i[user_status inactive]
    end

    factory :client_user do |f|
      transient do
        client { nil }
      end

      sequence(:email) { |n| "client_user_#{n}@abc.com" }
      security_roles { [create(:security_role, :external)] }
      external { true }

      f.after(:create) do |user, evaluator|
        this_client = evaluator.client.presence || (create :client)
        UserClient.create! user: user, client_id: this_client.id
      end
    end
  end
end
