module SchemaValidations
  def load_schema_validations
    load_column_validations
  end

  def load_column_validations
    self.class.content_columns.each do |column|
      name = column.name.to_sym

      # Data-type validation
      datatype = case
                 when respond_to?(:defined_enums) && defined_enums.has_key?(column.name) then :enum
                 when column.type == :integer then :integer
                 when column.type == :decimal || column.type == :money then :decimal
                 when column.type == :float   then :numeric
                 when column.type == :text || column.type == :string then :text
                 when column.type == :boolean then :boolean
                 end

      case datatype
      when :integer
        validate_logged :validates_numericality_of, name
      when :decimal
        if column.precision
          limit = 10 ** (column.precision - (column.scale || 0))
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
          validate_logged :validates_with, SchemaValidations::Validators::NotNilValidator, attributes: [name]
        elsif tyoe != :datetime
          validate_logged :validates_presence_of, name
        end
      end
    end
  end

  def load_association_validations #:nodoc:
    reflect_on_all_associations(:belongs_to).each do |association|
      # :primary_key_name was deprecated (noisily) in rails 3.1
      foreign_key_method = association.respond_to?(:foreign_key) ?  :foreign_key : :primary_key_name
      column = columns_hash[association.send(foreign_key_method).to_s]
      next unless column

      # NOT NULL constraints
      validate_logged :validates_presence_of, association.name
    end
  end

  def validate_logged(method, arg, opts={}) #:nodoc:\
    msg = "[schema_validations] #{self.class.name}.#{method} #{arg.inspect}"
    msg += ", #{opts.inspect[1...-1]}" if opts.any?
    send method, arg, opts
  end
end
