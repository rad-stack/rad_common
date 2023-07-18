FactoryBot.define do
  factory :user_with_profile, parent: :user do
    profile_entered { true }
    birth_date { Faker::Date.birthday(min_age: 20) }
  end
end
