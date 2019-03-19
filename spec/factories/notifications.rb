FactoryBot.define do
  factory :notification do
    sequence(:name) { |n| "Notify #{n + 1}" }
  end
end
