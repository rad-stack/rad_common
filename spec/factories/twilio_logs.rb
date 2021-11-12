FactoryBot.define do
  factory :twilio_log do
    to_number { RadicalTwilio.human_to_twilio_format(Faker::PhoneNumber.phone_number) }
    from_number { RadicalTwilio.human_to_twilio_format(Faker::PhoneNumber.phone_number) }
    association :from_user, factory: :user
    association :to_user, factory: :user
    message { Faker::TvShows::GameOfThrones.quote }
    media_url { Faker::Internet.url if rand(1..3) == 1 }
    success { rand(1..5) != 1 }
  end
end
