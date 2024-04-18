FactoryBot.define do
  factory :contact_log do
    log_type { 'outgoing' }
    to_number { Faker::PhoneNumber.cell_phone }
    from_number { Faker::PhoneNumber.cell_phone }
    from_user factory: :user
    to_user factory: :user
    message { Faker::TvShows::GameOfThrones.quote }
    media_url { Faker::Internet.url if rand(1..3) == 1 }
    sent { rand(1..5) != 1 }

    after(:build) do |record|
      if record.twilio_status.blank? && record.sent? && record.outgoing?
        record.twilio_status = RadEnum.new(ContactLog, :twilio_status).random_value
      end
    end
  end
end
