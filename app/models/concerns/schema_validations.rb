module SchemaValidations
  extend ActiveSupport::Concern

  EXEMPT_COLUMNS = %i[created_at updated_at].freeze
  DECIMAL_FIELDS = %i[decimal money].freeze
  TEXT_FIELDS = %i[text string].freeze

  included do
    class_attribute :schema_validations_loaded
    class_attribute :schema_validation_config, default: SchemaValidationConfig.new

    before_validation :load_schema_validations
  end

  class_methods do
    def schema_validation_options(&block)
      config = SchemaValidationConfig.new
      config.instance_eval(&block)
      self.schema_validation_config = config
    end
  end

  def load_schema_validations
    return if klass.schema_validations_loaded

    load_index_validations
    load_column_validations
    klass.schema_validations_loaded = true
  end

  private

    def load_column_validations
      klass.content_columns.each do |column|
        name = column.name.to_sym
        next if exempt_column?(name)

        datatype = retrieve_data_type(column)

        validate_numericality_and_length(name, datatype, column)
        validate_presence(column, name, datatype)
      end
    end

    def retrieve_data_type(column)
      column_type = column.type
      if respond_to?(:defined_enums) && defined_enums.has_key?(column.name)
        :enum
      elsif column.array?
        :array
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

    def validate_numericality_and_length(name, datatype, column)
      custom_options = column_options(name)
      if datatype.in?(%i[numeric integer])
        opts = { allow_nil: true }
        opts.merge! custom_options
        validate_logged :validates_numericality_of, name, opts
      elsif datatype == :decimal
        if column.precision
          limit = 10**(column.precision - (column.scale || 0))
          opts = { allow_nil: true, greater_than: -limit, less_than: limit }
          opts.merge! custom_options
          validate_logged :validates_numericality_of, name, opts
        end
      elsif datatype == :text && column.limit.present?
        opts = { allow_nil: true, maximum: column.limit }
        opts.merge! custom_options
        validate_logged :validates_length_of, name, opts
      end
    end

    def validate_presence(column, name, datatype)
      return if column.null

      custom_options = column_options(name)
      if datatype == :boolean
        opts = { in: [true, false], message: :blank }
        opts.merge! custom_options
        validate_logged :validates_inclusion_of, name, opts
      elsif !column.default.nil? && column.default.blank?
        opts = { attributes: [name] }
        opts.merge! custom_options
        validate_logged :validates_with, NotNilValidator, opts
      elsif datatype == :array
        opts = { presence: true, if: -> { public_send(name).nil? } }
        opts.merge! custom_options
        validate_logged :validates, name, opts
      else
        opts = column_options(name)
        validate_logged :validates_presence_of, name, opts
      end
    end

    def load_index_validations
      klass.connection.indexes(klass.table_name.to_sym).each do |index|
        next if index.name.to_sym.in?(skip_indexes) || !index.unique

        columns = index.columns
        first_column = columns.first.to_sym
        options = {}
        options[:allow_nil] = true
        options[:scope] = columns[1..-1].map(&:to_sym) if columns.count > 1
        options.merge! index_options(index.name.to_sym)
        validate_logged :validates_uniqueness_of, first_column, options
      end
    end

    def validate_logged(method, arg, opts = {})
      msg = "[schema_validations] #{self.class.name}.#{method} #{arg.inspect}"
      msg += ", #{opts.inspect[1...-1]}" if opts.any?
      Rails.logger.debug(msg)

      klass.send(method, arg, opts)
    end

    def exempt_column?(column)
      # Timestamps and model-specific instances to be skipped
      column.in?(EXEMPT_COLUMNS + skip_columns)
    end

    def klass
      self.class
    end

    def skip_columns
      schema_validation_config&.skip_columns || []
    end

    def skip_indexes
      schema_validation_config&.skip_indexes || []
    end

    def column_options(column)
      schema_validation_config&.column_options&.dig(column.to_sym) || {}
    end

    def index_options(index)
      schema_validation_config&.index_options&.dig(index.to_sym) || {}
    end
end

class SchemaValidationConfig
  attr_reader :column_options, :index_options, :skip_columns, :skip_indexes

  def initialize
    @column_options = {}
    @index_options = {}
    @skip_columns = []
    @skip_indexes = []
  end

  def column(name, opts = {})
    name = name.to_sym
    if opts.delete(:skip)
      @skip_columns << name
    else
      @column_options[name] = opts
    end
  end

  def index(name, opts = {})
    name = name.to_sym
    if opts.delete(:skip)
      @skip_indexes << name
    else
      @index_options[name] = opts
    end
  end
end
