class ReasonableDateRangeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    return if ((Date.current - 100.years)..(Date.current + 100.years)).include?(value.to_date)

    record.errors.add attribute, (options[:message] || 'is not a reasonable date')
  end
end
