FactoryBot.define do
  factory :phone_number, class: 'String' do
    skip_create

    transient do
      phone_number { Faker::PhoneNumber.phone_number }
    end

    trait :mobile do
      phone_number do
        if Rails.env.production?
          # we shouldn't be using this for production but could one day if needed
          raise 'invalid operation' unless Company.staging?

          ENV.fetch('TEST_PHONE_NUMBER')
        else
          Faker::PhoneNumber.cell_phone
        end
      end
    end

    trait :real_mobile do
      phone_number do
        # we shouldn't be using this for production but could one day if needed
        raise 'invalid operation' if Rails.env.production? && !Company.staging?

        ENV.fetch('TEST_PHONE_NUMBER')
      end
    end

    initialize_with { new(phone_number) }
  end
end
