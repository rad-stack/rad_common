FactoryBot.define do
  factory :notification do
    association :user
    association :notification_type
    content { Faker::Movies::StarWars.quote }
  end
end
