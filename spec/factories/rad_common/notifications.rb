FactoryBot.define do
  factory :notification do
    user
    content { Faker::Movies::StarWars.quote }
  end
end
