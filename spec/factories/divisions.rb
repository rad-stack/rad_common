FactoryBot.define do
  factory :division do
    sequence(:name) { |n| "Division #{n + 1}" }
    sequence(:code) { |n| "Code #{n + 1}" }
    association :owner, factory: :user
    division_status :status_active
  end
end
