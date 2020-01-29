FactoryBot.define do
  factory :system_message do
    send_to { :all_users }
    association :user
    message { Faker::Movies::StarWars.quote }
    email_message_body { Faker::Movies::StarWars.quote }
    message_type { 'email' }
  end
end
