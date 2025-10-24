module RadReports
  class Report < RadSearch::Search
    attr_reader :available_columns, :selected_columns, :report_name, :custom_report, :model_name, :association_to_table_map

    def initialize(custom_report:, current_user:, params:)
      @custom_report = custom_report
      @model_name = custom_report.report_model
      @report_name = custom_report.name

      @model_class = @model_name.constantize
      raise "Invalid model: #{@model_name}" unless @model_class < ApplicationRecord

      @association_to_table_map = build_association_to_table_map(custom_report.joins)
      @available_columns = build_column_definitions(custom_report.columns)
      @column_selector = ColumnSelector.new(report: self)

      query = build_query(custom_report.joins)
      filters = build_filter_definitions(custom_report.filters)
      sort_columns = build_sort_definitions(custom_report.sort_columns)

      super(query: query,
            filters: filters,
            sort_columns: sort_columns,
            current_user: current_user,
            params: params,
            sticky_filters: false)

      @selected_columns = @column_selector.selected_columns
    end

    def results
      base_results = super

      rich_text_associations = get_selected_rich_text_associations
      base_results = base_results.includes(rich_text_associations) if rich_text_associations.any?

      attachment_associations = get_selected_attachment_associations
      base_results = base_results.includes(attachment_associations) if attachment_associations.any?

      @column_selector.apply_column_selection(base_results)
    end

    def all_results
      results.reorder(@sorting.sort_clause(results.klass))
    end

    def column_definitions
      @available_columns
    end

    private

      def build_association_to_table_map(joins)
        map = {}
        joins.each do |join_path|
          parts = join_path.split('.')
          current_class = @model_class

          parts.each_with_index do |part, index|
            association = current_class.reflect_on_association(part.to_sym)
            next unless association

            path_so_far = parts[0..index].join('.')
            map[path_so_far] = association.table_name

            current_class = association.klass
          end
        end
        map
      end

      def build_query(joins)
        query = @model_class.all
        joins.each do |join_path|
          if join_path.include?('.')
            parts = join_path.split('.')
            nested_hash = parts.reverse.reduce { |acc, part| { part.to_sym => acc } }
            query = query.joins(nested_hash)
          else
            query = query.joins(join_path.to_sym)
          end
        end
        query
      end

      def build_column_definitions(columns)
        columns.map do |col|
          is_rich_text = rich_text_field?(col['name'])
          is_attachment = attachment_field?(col['name'])

          {
            name: col['name'],
            label: col['label'],
            select: (is_rich_text || is_attachment) ? nil : col['select'],
            is_rich_text: is_rich_text,
            is_attachment: is_attachment,
            formula: col['formula']
          }
        end
      end

      def rich_text_field?(column_name)
        return false unless @model_class

        @model_class.reflect_on_all_associations.any? do |assoc|
          assoc.klass.name == 'ActionText::RichText' &&
            assoc.name.to_s == "rich_text_#{column_name}"
        end
      rescue StandardError
        false
      end

      def attachment_field?(column_name)
        return false unless @model_class

        @model_class.reflect_on_all_associations.any? do |assoc|
          assoc.klass.name == 'ActiveStorage::Attachment' &&
            (assoc.name.to_s == "#{column_name}_attachment" || assoc.name.to_s == "#{column_name}_attachments")
        end
      rescue StandardError
        false
      end

      def get_selected_rich_text_associations
        @selected_columns.filter_map do |select_clause|
          column_def = @available_columns.find { |c| c[:select] == select_clause }
          next unless column_def&.dig(:is_rich_text)

          :"rich_text_#{column_def[:name]}"
        end
      end

      def get_selected_attachment_associations
        @selected_columns.filter_map do |select_clause|
          column_def = @available_columns.find { |c| c[:select] == select_clause }
          next unless column_def&.dig(:is_attachment)

          # Determine if it's has_one_attached (singular) or has_many_attached (plural)
          attachment_name = column_def[:name]
          if @model_class.reflect_on_association(:"#{attachment_name}_attachment")
            :"#{attachment_name}_attachment"
          elsif @model_class.reflect_on_association(:"#{attachment_name}_attachments")
            :"#{attachment_name}_attachments"
          end
        end.compact
      end

      def build_filter_definitions(filters)
        return [] if filters.blank?

        filters.map do |filter|
          next if filter['type'].present? && filter['type'].start_with?('[')

          # Convert association names to table names for SQL
          column_path = convert_filter_column_path(filter['column'])

          filter_def = {
            column: column_path
          }

          filter_def[:type] = filter['type'].constantize if filter['type'].present?

          if filter['options'].present?
            options = filter['options']
            options = JSON.parse(options) if options.is_a?(String)
            filter_def[:options] = options if options.present?
          elsif filter['type'] == 'RadSearch::SearchFilter' || filter['type'].blank?
            filter_def[:options] = generate_filter_options(filter)
          end

          if filter['label'].present?
            if filter['type'] == 'RadSearch::DateFilter'
              filter_def[:start_input_label] = "#{filter['label']} Start"
              filter_def[:end_input_label] = "#{filter['label']} End"
            else
              filter_def[:input_label] = filter['label']
            end
          end

          if filter['type'] == 'RadSearch::EqualsFilter' && filter['data_type'].present?
            filter_def[:data_type] = map_column_type_to_data_type(filter['data_type'])
          end

          if filter['type'] == 'RadSearch::EnumFilter'
            column_path = filter['column']
            table_name, column_name = parse_column_path(column_path)
            model_class = find_model_for_table(table_name)
            if model_class
              filter_def[:klass] = model_class
              filter_def[:column] = column_name.to_sym
            end
          end

          filter_def
        end.compact
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
        column_path = filter['column']
        table_name, column_name = parse_column_path(column_path)

        model_class = find_model_for_table(table_name)
        return [] unless model_class

        association = find_association_for_fk(model_class, column_name)
        return [] unless association

        association.klass.all.to_a
      rescue StandardError => e
        Rails.logger.error("Error generating filter options for #{filter['column']}: #{e.message}")
        []
      end

      def convert_filter_column_path(column_path)
        parts = column_path.to_s.split('.')
        return column_path if parts.length < 2

        column = parts.last
        association_path = parts[0..-2].join('.')
        table_name = @association_to_table_map[association_path] || association_path

        "#{table_name}.#{column}"
      end

      def parse_column_path(column_path)
        parts = column_path.split('.')

        if parts.length == 2
          association_path = parts[0]
          column_name = parts[1]

          table_name = @association_to_table_map[association_path] || parts[0]

          [table_name, column_name]
        else
          [@model_class.table_name, column_path]
        end
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

      def build_sort_definitions(sort_columns)
        return [] if sort_columns.blank?

        sort_columns.map do |sort_col|
          {
            label: sort_col['label'],
            column: sort_col['column']
          }
        end
      end
  end
end
