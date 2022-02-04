FactoryBot.define do
  factory :category do
    name { Faker::Company.industry }
  end
end
