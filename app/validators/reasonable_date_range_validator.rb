class ReasonableDateRangeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    return unless record.public_send("#{attribute}_changed?")
    return if ((Date.current - 150.years)..(Date.current + 150.years)).include?(value.to_date)

    record.errors.add attribute, (options[:message] || 'is not a reasonable date')
  end
end
