class PhoneNumberFormatter
  extend ActionView::Helpers::NumberHelper

  VALID_FORMATTED_REGEX = /\A\+?(\d{1,2}\s*)?[-.\s]?(\d{1,2}-)?(?:\((\d{3})\)|\d{3})[-.\s]?\d{3}[-.\s]?\d{4}\s*\z/

  def self.format(phone_number)
    return if phone_number.blank?

    phone_number = phone_number.strip
    matches = phone_number.match(VALID_FORMATTED_REGEX)
    return unless matches

    phone_number = phone_number.to_s.gsub(/\D/, '')
    formatted_number = number_to_phone(phone_number.slice(-10, 10), area_code: true)
    yield formatted_number if block_given?

    formatted_number
  end
end
