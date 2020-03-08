FactoryBot.define do
  factory :user_status do
    sequence(:name) { |n| "Status #{n}" }

    trait :pending do
      active { false }
      validate_email { true }
    end

    trait :active do
      active { true }
      validate_email { true }
    end

    trait :inactive do
      active { false }
      validate_email { false }
    end
  end
end
