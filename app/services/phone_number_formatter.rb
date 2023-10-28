class PhoneNumberFormatter
  extend ActionView::Helpers::NumberHelper

  def self.format(phone_number)
    return if phone_number.blank?

    phone_number = phone_number.to_s.gsub(/\D/, '')
    return unless phone_number.length.in?([10, 11]) && StringUtil.integer?(phone_number)

    formatted_number = number_to_phone(phone_number.slice(-10, 10), area_code: true)
    yield formatted_number if block_given?

    formatted_number
  end
end
