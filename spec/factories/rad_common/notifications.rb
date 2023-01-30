FactoryBot.define do
  factory :notification do
    association :user
    content { Faker::Movies::StarWars.quote }
  end
end
