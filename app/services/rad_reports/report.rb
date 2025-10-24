module RadReports
  class Report < RadSearch::Search
    attr_reader :available_columns, :selected_columns, :report_name, :custom_report, :model_name, :association_to_table_map

    def initialize(custom_report:, current_user:, params:)
      @custom_report = custom_report
      @model_name = custom_report.report_model
      @report_name = custom_report.name

      @model_class = @model_name.constantize
      raise "Invalid model: #{@model_name}" unless @model_class < ApplicationRecord

      @join_builder = JoinBuilder.new(@model_class, custom_report.joins)
      @filter_builder = FilterBuilder.new(@model_class, @join_builder)

      @association_to_table_map = @join_builder.association_to_table_map
      @available_columns = build_column_definitions(custom_report.columns)
      @column_selector = ColumnSelector.new(report: self)

      query = @join_builder.build_query
      filters = @filter_builder.build_filter_definitions(custom_report.filters)
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
