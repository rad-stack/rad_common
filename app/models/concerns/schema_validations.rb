module SchemaValidations
  EXEMPT_COLUMNS = %i[created_at updated_at]
  DECIMAL_FIELDS = %i[decimal money]
  TEXT_FIELDS = %i[text string]

  def load_schema_validations
    load_column_validations
  end

  def load_column_validations
    self.class.content_columns.each do |column|
      name = column.name.to_sym
      column_type = column.type
      next if exempt_column?(name)

      datatype = if respond_to?(:defined_enums) && defined_enums.has_key?(column.name)
                   :enum
                 elsif column_type.in? DECIMAL_FIELDS
                   :decimal
                 elsif column_type == :float
                   :numeric
                 elsif column_type.in? TEXT_FIELDS
                   :text
                 else
                   column_type
                 end

      case datatype
      when :integer
        validate_logged :validates_numericality_of, name
      when :decimal
        if column.precision
          limit = 10**(column.precision - (column.scale || 0))
          validate_logged :validates_numericality_of, name, allow_nil: true, greater_than: -limit, less_than: limit
        end
      when :numeric
        validate_logged :validates_numericality_of, name, allow_nil: true
      when :text
        validate_logged :validates_length_of, name, allow_nil: true, maximum: column.limit if column.limit
      end

      # NOT NULL constraints
      unless column.null
        if datatype == :boolean
          validate_logged :validates_inclusion_of, name, in: [true, false], message: :blank
        elsif !column.default.nil? && column.default.blank?
          validate_logged :validates_with, NotNilValidator, attributes: [name]
        elsif datatype != :datetime
          validate_logged :validates_presence_of, name
        end
      end
    end
  end

  def load_association_validations #:nodoc:
    reflect_on_all_associations(:belongs_to).each do |association|
      # :primary_key_name was deprecated (noisily) in rails 3.1
      foreign_key_method = association.respond_to?(:foreign_key) ? :foreign_key : :primary_key_name
      column = columns_hash[association.send(foreign_key_method).to_s]
      next unless column

      # NOT NULL constraints
      validate_logged :validates_presence_of, association.name
    end
  end

  def validate_logged(method, arg, opts = {}) #:nodoc:\
    msg = "[schema_validations] #{self.class.name}.#{method} #{arg.inspect}"
    msg += ", #{opts.inspect[1...-1]}" if opts.any?
    Rails.logger.info(msg)
    send method, arg, opts
  end

  def exempt_column?(column)
    # As of now, this only consists of timestamps. There are no user entry points to change these fields, so a database error will suffice.
    column.in? EXEMPT_COLUMNS
  end
end
