require 'schema_monkey'
module SchemaValidations
  module ActiveRecord
    module Base

      def load_schema_validations
        self.class.send :load_schema_validations
      end

      module ClassMethods

        def self.extended(base)
          base.class_eval do
            class_attribute :schema_validations_loaded
          end
        end

        def inherited(subclass) # :nodoc:
          super
          before_validation :load_schema_validations unless schema_validations_loaded?
        end

        def validators
          load_schema_validations unless schema_validations_loaded?
          super
        end

        def validators_on(*args)
          load_schema_validations unless schema_validations_loaded?
          super
        end

        def schema_validations(opts={})
          @schema_validations_config = SchemaValidations.config.merge({:auto_create => true}.merge(opts))
        end

        def schema_validations_config # :nodoc:
          @schema_validations_config ||= SchemaValidations.config.dup
        end

        private
        def load_schema_validations #:nodoc:
          # Don't bother if: it's already been loaded; the class is abstract; not a base class; or the table doesn't exist
          return unless create_schema_validations?
          load_column_validations
          load_association_validations
          self.schema_validations_loaded = true
        end

        def load_column_validations #:nodoc:
          content_columns.each do |column|
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
              load_integer_column_validations(name, column)
            when :decimal
              if column.precision
                limit = 10 ** (column.precision - (column.scale || 0))
                validate_logged :validates_numericality_of, name, :allow_nil => true, :greater_than => -limit, :less_than => limit
              end
            when :numeric
              validate_logged :validates_numericality_of, name, :allow_nil => true
            when :text
              validate_logged :validates_length_of, name, :allow_nil => true, :maximum => column.limit if column.limit
            end

            # NOT NULL constraints
            if column.required_on
              if datatype == :boolean
                validate_logged :validates_inclusion_of, name, :in => [true, false], :message => :blank
              else
                if !column.default.nil? && column.default.blank?
                  validate_logged :validates_with, SchemaValidations::Validators::NotNilValidator, attributes: [name]
                else
                  # Validate presence
                  validate_logged :validates_presence_of, name
                end
              end
            end

            # UNIQUE constraints
            add_uniqueness_validation(column) if column.unique?
          end
        end

        def load_integer_column_validations(name, column) # :nodoc:
          integer_range = ::ActiveRecord::Type::Integer.new.range
          # The Ruby Range object does not support excluding the beginning of a Range,
          # so we always include :greater_than_or_equal_to
          options = { :allow_nil => true, :only_integer => true, greater_than_or_equal_to: integer_range.begin }

          if integer_range.exclude_end?
            options[:less_than] = integer_range.end
          else
            options[:less_than_or_equal_to] = integer_range.end
          end

          validate_logged :validates_numericality_of, name, options
        end

        def load_association_validations #:nodoc:
          reflect_on_all_associations(:belongs_to).each do |association|
            # :primary_key_name was deprecated (noisily) in rails 3.1
            foreign_key_method = (association.respond_to? :foreign_key) ?  :foreign_key : :primary_key_name
            column = columns_hash[association.send(foreign_key_method).to_s]
            next unless column

            # NOT NULL constraints
            validate_logged :validates_presence_of, association.name if column.required_on
          end
        end

        def has_case_insensitive_index?(column, scope)
          indexed_columns = (scope + [column.name]).map(&:to_sym).sort
          index = column.indexes.select { |i| i.unique && i.columns.map(&:to_sym).sort == indexed_columns }.first

          index && index.respond_to?(:case_sensitive?) && !index.case_sensitive?
        end

        def create_schema_validations? #:nodoc:
          schema_validations_config.auto_create? && !(schema_validations_loaded || abstract_class? || name.blank? || !table_exists?)
        end
      end
    end
  end
end

SchemaMonkey.register SchemaValidations
