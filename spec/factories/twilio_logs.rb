FactoryBot.define do
  factory :twilio_log do
    to_number { Faker::PhoneNumber.cell_phone }
    from_number { Faker::PhoneNumber.cell_phone }
    association :from_user, factory: :user
    association :to_user, factory: :user
    message { Faker::TvShows::GameOfThrones.quote }
    media_url { Faker::Internet.url if rand(1..3) == 1 }
    sent { rand(1..5) != 1 }

    after(:build) do |record|
      if record.twilio_status.blank? && record.sent?
        record.twilio_status = RadEnum.new(TwilioLog, :twilio_status).random_value
      end
    end
  end
end
