class Attorney < ApplicationRecord
  include DuplicateFixable

  scope :by_name, -> { order(:first_name, :last_name) }

  validates_with PhoneNumberValidator, fields: [{ field: :phone_number }]
  validates_with EmailAddressValidator, fields: %i[email]

  strip_attributes
  audited

  def to_s
    the_name = "#{last_name}, #{first_name}"
    the_name = "#{the_name} #{middle_name}" if middle_name.present?
    the_name
  end

  def clean_up_duplicate(_new_record)
    # nothing to do
  end
end
