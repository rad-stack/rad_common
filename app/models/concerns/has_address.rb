module HasAddress
  extend ActiveSupport::Concern

  def full_address
    "#{address_line_1}, #{address_line_2}"
  end

  def address_line_1
    line = address_1
    line = "#{line}, #{address_2}" if address_2.present?
    line
  end

  def address_line_2
    "#{city}, #{state} #{zipcode}"
  end
end
