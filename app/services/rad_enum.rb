class RadEnum
  attr_accessor :enum_class, :enum_name

  def initialize(enum_class, enum_name)
    self.enum_class = enum_class
    self.enum_name = enum_name
    return if enum_exists?

    raise "enum #{enum_name} on #{enum_class} doesn't exist"
  end

  def translated_option(record)
    enum_value = record[enum_name]
    return if enum_value.blank?

    translation enum_value
  end

  def translation(enum_value)
    I18n.t(translation_key(enum_value), default: enum_value.to_s.titleize)
  end

  def raw_translation(raw_value)
    db_options.to_h.invert[raw_value]
  end

  def options
    retrieve_options false
  end

  def db_options
    retrieve_options true
  end

  private

    def enum_exists?
      enum_class.respond_to?(enums_name)
    end

    def enums_name
      enum_name.to_s.pluralize
    end

    def enum_values
      enum_class.send(enums_name)
    end

    def translation_key(enum_value)
      "activerecord.attributes.#{enum_class.to_s.underscore.gsub('/', '_')}.#{enums_name}.#{enum_value}"
    end

    def retrieve_options(db_values)
      items = enum_values.map do |enum_value, db_value|
        value = db_values ? db_value : enum_value
        [translation(enum_value), value]
      end

      items.reject { |item, _enum_value| item.blank? }
    end
end
