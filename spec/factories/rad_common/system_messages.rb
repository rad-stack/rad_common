FactoryBot.define do
  factory :system_message do
    send_to { :all_users }
    user

    trait :email do
      message_type { 'email' }
      email_message_body { Faker::Movies::StarWars.quote }
    end

    trait :sms do
      message_type { 'sms' }
      sms_message_body { Faker::Movies::StarWars.quote }
    end
  end
end
