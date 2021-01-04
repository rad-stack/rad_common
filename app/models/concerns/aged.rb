module Aged
  extend ActiveSupport::Concern

  def age
    return if birth_date.blank?

    ((Time.current - birth_date.to_datetime) / 1.year.seconds).floor
  end
end
