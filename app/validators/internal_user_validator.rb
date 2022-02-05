class InternalUserValidator < ActiveModel::Validator
  def validate(record)
    return if record.blank?

    options[:fields].each do |field|
      next if record.send(field).blank? || record.send(field).internal?

      record.errors.add(field, 'does not allow external users.')
    end
  end
end
