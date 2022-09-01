FactoryBot.define do
  factory :security_role do
    sequence(:name) { |n| "Role #{n}" }

    trait :admin do |item|
      item.after(:build) do |role|
        RadPermission.all.each { |i| role.send("#{i}=", true) }
      end
    end

    trait :external do
      external { true }
      allow_sign_up { true }
    end
  end
end
