FactoryBot.define do
  factory :division do
    sequence(:name) { |n| "Division #{n + 1}" }
    sequence(:code) { |n| "Code #{n + 1}" }
    association :owner, factory: :user
    division_status { :status_active }
    additional_info { 'blah' }

    trait :with_logo do
      logo { test_photo }
    end
  end
end
