FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "Client #{n}" }
    valid_user_domains { ['abc.com'] }
  end
end
