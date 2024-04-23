FactoryBot.define do
  factory :contact_log do
    service_type { :sms }
    sms_log_type { 'outgoing' }
    from_number { Faker::PhoneNumber.cell_phone }
    from_user factory: :user
    content { Faker::TvShows::GameOfThrones.quote }
    sms_media_url { Faker::Internet.url if rand(1..3) == 1 }
    sms_sent { rand(1..5) != 1 }

    transient do
      to_user { nil }
      email { nil }
      phone_number { nil }
    end

    after(:create) do |contact_log, evaluator|
      if evaluator.to_user || evaluator.email || evaluator.phone_number
        attrs = { to_user: evaluator.to_user, phone_number: evaluator.phone_number, email: evaluator.email }
        create :contact_log_recipient, contact_log: contact_log, **attrs.compact
      end
    end

    trait :sendgrid do
      service_type { :email }
      sms_log_type { nil }
      sms_media_url { nil }
      from_number { nil }
      from_email { Faker::Internet.email }
    end
  end
end
