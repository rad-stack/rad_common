class Attorney < ApplicationRecord
  include Contactable
  include DuplicateFixable

  scope :by_name, -> { order(:first_name, :last_name) }
  scope :created_between, lambda { |start_date, end_date|
    where('created_at >= ? and created_at <= ?', start_date, end_date)
  }

  validates_with PhoneNumberValidator, fields: [{ field: :phone_number }]
  validates_with EmailAddressValidator, fields: %i[email]

  strip_attributes
  audited

  def to_s
    the_name = "#{last_name}, #{first_name}"
    the_name = "#{the_name} #{middle_name}" if middle_name.present?
    the_name
  end
end
