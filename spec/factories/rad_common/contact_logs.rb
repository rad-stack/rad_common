FactoryBot.define do
  factory :contact_log do
    log_type { 'outgoing' }
    from_number { Faker::PhoneNumber.cell_phone }
    from_user factory: :user
    message { Faker::TvShows::GameOfThrones.quote }
    media_url { Faker::Internet.url if rand(1..3) == 1 }
    sent { rand(1..5) != 1 }

    trait :sendgrid do
      log_type { 'sendgrid' }
      from_number { nil }
      from_email { Faker::Internet.email }
    end
  end
end
