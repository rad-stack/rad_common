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
          format = if col['format'].present?
                     col['format'].to_sym
                   else
                     infer_format_from_column(col['name'])
                   end

          select_clause = if format == :rich_text
                            nil
                          else
                            col['select']
                          end

          {
            name: col['name'],
            label: col['label'],
            select: select_clause,
            format: format
          }
        end
      end

      def infer_format_from_column(column_name)
        return nil unless @model_class
        return :rich_text if rich_text_field?(column_name)

        db_column = @model_class.columns_hash[column_name.to_s]
        return nil unless db_column

        case db_column.type
        when :date
          :date
        when :datetime, :timestamp
          :datetime
        when :decimal, :float
          :decimal
        when :integer, :bigint
          :integer
        when :boolean
          :boolean
        end
      end

      def rich_text_field?(column_name)
        @model_class.reflect_on_all_associations.any? do |assoc|
          assoc.klass.name == 'ActionText::RichText' &&
            assoc.name.to_s == "rich_text_#{column_name}"
        end
      rescue StandardError
        false
      end

      def get_selected_rich_text_associations
        @selected_columns.filter_map do |select_clause|
          column_def = @available_columns.find { |c| c[:select] == select_clause }
          next unless column_def&.dig(:format) == :rich_text

          :"rich_text_#{column_def[:name]}"
        end
      end

      def build_filter_definitions(filters)
        return [] if filters.blank?

        filters.map do |filter|
          filter_def = {
            column: filter['column'],
            type: filter['type'].constantize
          }

          if filter['options'].present?
            options = filter['options']
            options = JSON.parse(options) if options.is_a?(String)
            filter_def[:options] = options if options.present?
          end

          if filter['label'].present?
            if filter['type'] == 'RadSearch::DateFilter'
              filter_def[:start_input_label] = "#{filter['label']} Start"
              filter_def[:end_input_label] = "#{filter['label']} End"
            else
              filter_def[:input_label] = filter['label']
            end
          end

          filter_def
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
