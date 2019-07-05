class AttachmentValidator < ActiveModel::Validator
  def validate(record)
    return if record.blank? || !record.persisted?

    fields = options[:fields]

    fields.each do |field|
      next if record.send(field).attached?

      record.errors.add(field, 'must be attached')
    end
  end
end
