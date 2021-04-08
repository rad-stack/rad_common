module HasAddress
  extend ActiveSupport::Concern

  def full_address
    [address_line_1, address_line_2].compact.join(', ').presence
  end

  def address_line_1
    [address_1, address_2].compact.join(', ').presence
  end

  def address_line_2
    city_state = [city, state].compact.join(', ').presence
    [city_state, zipcode].compact.join(' ').presence
  end
end
