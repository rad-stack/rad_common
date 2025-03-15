module EnumsHelper
  def enum_to_translated_option(record, enum_name)
    RadEnum.new(record.class, enum_name).translated_option(record)
  end

  def options_for_enum(klass, enum_name)
    RadEnum.new(klass, enum_name).options
  end

  def enum_translation(klass, enum_name, value)
    RadEnum.new(klass, enum_name).translation(value)
  end
end
