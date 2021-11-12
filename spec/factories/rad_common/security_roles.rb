FactoryBot.define do
  factory :security_role do
    sequence(:name) { |n| "Role #{n}" }

    trait :admin do |item|
      item.after(:build) do |role|
        SecurityRole.permission_fields.each { |i| role.send("#{i}=", true) }
      end
    end

    trait :external do
      external { true }
    end
  end
end
