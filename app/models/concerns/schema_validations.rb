module SchemaValidations
  EXEMPT_COLUMNS = %i[created_at updated_at].freeze
  DECIMAL_FIELDS = %i[decimal money].freeze
  TEXT_FIELDS = %i[text string].freeze

  def load_schema_validations
    load_index_validations
    load_column_validations
    load_association_validations
  end

  def load_column_validations
    klass.content_columns.each do |column|
      name = column.name.to_sym
      next if exempt_column?(name)

      datatype = retrieve_data_type(column)

      validate_numericality_and_length(name, datatype, column.limit)
      validate_presence(column, name, datatype)
    end
  end

  def retrieve_data_type(column)
    column_type = column.type
    if respond_to?(:defined_enums) && defined_enums.has_key?(column.name)
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
  end

  def validate_numericality_and_length(name, datatype, limit)
    if datatype.in? %i[integer decimal numeric]
      validate_logged :validates_numericality_of, name, allow_nil: true
    elsif datatype == :text
      validate_logged :validates_length_of, name, allow_nil: true, maximum: limit if limit.present?
    end
  end

  def validate_presence(column, name, datatype)
    return if column.null

    if datatype == :boolean
      validate_logged :validates_inclusion_of, name, in: [true, false], message: :blank
    elsif !column.default.nil? && column.default.blank?
      validate_logged :validates_with, NotNilValidator, attributes: [name]
    elsif datatype != :datetime
      validate_logged :validates_presence_of, name
    end
  end

  def load_index_validations
    klass.connection.indexes(klass.table_name.to_sym).each do |index|
      next unless index.unique

      columns = index.columns
      first_column = columns.first.to_sym
      options = {}
      options[:allow_blank] = true
      options[:scope] = columns[1..-1].map(&:to_sym) if columns.count > 1
      validate_logged :validates_uniqueness_of, first_column, options, true
    end
  end

  def load_association_validations
    klass.reflect_on_all_associations(:belongs_to).each do |association|
      next if association.options[:optional]

      foreign_key_method = association.respond_to?(:foreign_key) ? :foreign_key : :primary_key_name
      column = klass.columns_hash[association.send(foreign_key_method).to_s]
      next unless column

      validate_logged :validates_presence_of, association.name
    end
  end

  def validate_logged(method, arg, opts = {}, class_method = false)
    msg = "[schema_validations] #{self.class.name}.#{method} #{arg.inspect}"
    msg += ", #{opts.inspect[1...-1]}" if opts.any?
    Rails.logger.info(msg)

    return klass.send(method, arg, opts) if class_method

    send method, arg, opts
  end

  def exempt_column?(column)
    # Timestamps and model-specific instances to be skipped
    column.in?(EXEMPT_COLUMNS + skip_columns)
  end

  def klass
    self.class
  end

  def skip_columns
    defined?(SKIP_SCHEMA_VALIDATIONS) ? SKIP_SCHEMA_VALIDATIONS : []
  end
end
