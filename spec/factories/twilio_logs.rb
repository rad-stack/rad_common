FactoryBot.define do
  factory :twilio_log do
    to_number { "+1#{Faker::PhoneNumber.phone_number.gsub('(', '').gsub(')', '').gsub('-', '').gsub(' ', '')}" }
    from_number { "+1#{Faker::PhoneNumber.phone_number.gsub('(', '').gsub(')', '').gsub('-', '').gsub(' ', '')}" }
    association :from_user, factory: :user
    association :to_user, factory: :user
    message { Faker::TvShows::GameOfThrones.quote }
    media_url { Faker::Internet.url if rand(1..3) == 1 }
    success { rand(1..5) != 1 }
  end
end
