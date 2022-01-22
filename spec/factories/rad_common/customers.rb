FactoryBot.define do
  factory :customer do
    sequence(:name) { |n| "Customer #{n}" }
    valid_user_domains { ['abc.com'] }
  end
end
