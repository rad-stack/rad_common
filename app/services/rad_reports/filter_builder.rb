module RadReports
  class FilterBuilder
    attr_reader :model_class, :join_builder

    def initialize(model_class, join_builder)
      @model_class = model_class
      @join_builder = join_builder
    end

    def build_filter_definitions(filters)
      return [] if filters.blank?

      filters.filter_map do |filter|
        next if filter['type'].present? && filter['type'].start_with?('[')

        filter_def = { column: convert_filter_column_path(filter['column']) }
        filter_def[:type] = filter['type'].constantize if filter['type'].present?

        apply_filter_options(filter_def, filter)
        apply_filter_labels(filter_def, filter)
        apply_equals_filter_data_type(filter_def, filter)
        apply_enum_filter_config(filter_def, filter)

        filter_def
      end
    end

    private

      def apply_filter_options(filter_def, filter)
        if filter['options'].present?
          options = filter['options']
          options = JSON.parse(options) if options.is_a?(String)
          filter_def[:options] = options if options.present?
        elsif filter['type'] == 'RadSearch::SearchFilter' || filter['type'].blank?
          filter_def[:options] = generate_filter_options(filter)
        end
      end

      def apply_filter_labels(filter_def, filter)
        return if filter['label'].blank?

        if filter['type'] == 'RadSearch::DateFilter'
          filter_def[:start_input_label] = "#{filter['label']} Start"
          filter_def[:end_input_label] = "#{filter['label']} End"
        else
          filter_def[:input_label] = filter['label']
        end
      end

      def apply_equals_filter_data_type(filter_def, filter)
        return unless filter['type'] == 'RadSearch::EqualsFilter' && filter['data_type'].present?

        filter_def[:data_type] = map_column_type_to_data_type(filter['data_type'])
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
  end
end
