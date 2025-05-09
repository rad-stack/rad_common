FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "#{Faker::Company.industry} #{n + 1}" }
  end
end
