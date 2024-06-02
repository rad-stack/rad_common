FactoryBot.define do
  factory :contact_log_recipient do
    contact_log
    phone_number { Faker::PhoneNumber.cell_phone }
    to_user factory: :user

    after(:build) do |record|
      if record.contact_log.sms? && record.sms_status.blank? && record.contact_log.sent? && record.contact_log.outgoing?
        record.sms_status = RadEnum.new(ContactLogRecipient, :sms_status).random_value
      end
    end

    trait :email do
      email { Faker::Internet.email }
      email_type { :to }
      phone_number { nil }
    end
  end
end
