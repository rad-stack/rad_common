FactoryBot.define do
  factory :contact_log_recipient do
    to_number { Faker::PhoneNumber.cell_phone }
    to_user factory: :user

    after(:build) do |record|
      if record.service_status.blank? && record.sent? && record.outgoing?
        record.service_status = RadEnum.new(ContactLog, :service_status).random_value
      end
    end
  end
end
