module RadReports
  class FilterBuilder
    attr_reader :model_class, :join_builder

    def initialize(model_class, join_builder)
      @model_class = model_class
      @join_builder = join_builder
    end

    def call(filters)
      return [] if filters.blank?

      filters.filter_map do |filter|
        filter_def = { column: convert_filter_column_path(filter['column']),
                       type: RadReports::FilterRegistry.filter_class(filter['type']) }
        apply_filter_labels(filter_def, filter)
        apply_filter_options(filter_def, filter)
        apply_filter_defaults(filter_def, filter)
        apply_multiple_select(filter_def, filter)
        apply_equals_filter_data_type(filter_def, filter)
        apply_enum_filter_config(filter_def, filter)

        filter_def
      end
    end

    private

      def apply_filter_labels(filter_def, filter)
        return if filter['label'].blank?

        if filter['type'] == 'RadSearch::DateFilter'
          filter_def[:start_input_label] = "#{filter['label']} Start"
          filter_def[:end_input_label] = "#{filter['label']} End"
        else
          filter_def[:input_label] = filter['label']
        end
      end

      def parsed_default_value(default_value)
        return default_value if default_value.blank?

        parse_default_value_array(default_value) || default_value
      end

      def parse_default_value_array(value)
        return unless value.include?(',')

        parts = value.split(',').map(&:strip)

        if parts.all? { |part| part.match?(/\A'.*'\z/) }
          parts.map { |part| part.delete("'") }
        elsif parts.all? { |part| part.match?(/\A-?\d+\z/) }
          parts.map(&:to_i)
        end
      end

      def apply_filter_options(filter_def, filter)
        return unless search_filter_type?(filter['type'])

        filter_def[:options] = generate_filter_options(filter)
        filter_def[:multiple] = filter['multiple'] if filter['multiple']
      end

      def apply_multiple_select(filter_def, filter)
        return unless filter['type'] == 'RadSearch::SearchFilterMultiple'

        filter_def[:multiple] = true
      end

      def apply_filter_defaults(filter_def, filter)
        return if filter['default_value'].blank?

        filter_def[:default_value] = parsed_default_value(filter['default_value'])
      end

      def apply_equals_filter_data_type(filter_def, filter)
        return unless filter['type'] == 'RadSearch::EqualsFilter'

        column_type = lookup_column_type(filter['column'])
        return unless column_type

        filter_def[:data_type] = map_column_type_to_data_type(column_type)
      end

      def apply_enum_filter_config(filter_def, filter)
        return unless filter['type'] == 'RadSearch::EnumFilter'

        table_name, column_name = parse_column_path(filter['column'])
        model_class = find_model_for_table(table_name)

        return unless model_class

        filter_def[:klass] = model_class
        filter_def[:column] = column_name.to_sym
      end

      def convert_filter_column_path(column_path)
        parts = column_path.to_s.split('.')
        return column_path if parts.length < 2

        table_name, column_name = split_column_path(parts)
        "#{table_name}.#{column_name}"
      end

      def parse_column_path(column_path)
        parts = column_path.split('.')
        return [@model_class.table_name, column_path] if parts.length < 2

        split_column_path(parts)
      end

      def split_column_path(parts)
        column_name = parts.last
        association_path = parts[0..-2].join('.')
        table_name = @join_builder.table_name_for_association(association_path)

        [table_name, column_name]
      end

      def map_column_type_to_data_type(column_type)
        case column_type.to_s
        when 'integer', 'bigint', 'decimal', 'float'
          :integer
        when 'text'
          :text
        else
          :string
        end
      end

      def lookup_column_type(column_path)
        table_name, column_name = parse_column_path(column_path)
        model_class = find_model_for_table(table_name)
        return unless model_class

        column = model_class.columns_hash[column_name]
        return unless column

        column.respond_to?(:array) && column.array ? 'array' : column.type.to_s
      end

      def generate_filter_options(filter)
        table_name, column_name = parse_column_path(filter['column'])
        model_class = find_model_for_table(table_name)
        return [] unless model_class

        association = find_association_for_fk(model_class, column_name)
        association&.klass&.all.to_a
      rescue StandardError => e
        Rails.logger.error("Error generating filter options for #{filter['column']}: #{e.message}")
        []
      end

      def find_model_for_table(table_name)
        return @model_class if @model_class.table_name == table_name

        ApplicationRecord.descendants.find { |model| model.table_name == table_name }
      end

      def find_association_for_fk(model_class, column_name)
        model_class.reflect_on_all_associations.find do |assoc|
          assoc.foreign_key.to_s == column_name
        end
      end

      def search_filter_type?(type)
        %w[RadSearch::SearchFilter RadSearch::SearchFilterMultiple].include?(type)
      end
  end
end
