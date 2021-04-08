module HasAddress
  extend ActiveSupport::Concern

  def full_address
    [address_line_1, address_line_2].compact.join(', ')
  end

  def address_line_1
    [address_1, address_2].compact.join(', ')
  end

  def address_line_2
    city_state = [city, state].compact.join(', ')
    [city_state, zipcode].compact.join(' ')
  end
end
