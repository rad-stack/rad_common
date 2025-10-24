module RadReports
  class Report < RadSearch::Search
    attr_reader :available_columns, :custom_report, :join_builder

    delegate :report_name, to: :custom_report

    def initialize(custom_report:, current_user:, params:)
      @custom_report = custom_report
      @model_class = custom_report.report_model.constantize
      @join_builder = JoinBuilder.new(@model_class, custom_report.joins)
      filter_builder = FilterBuilder.new(@model_class, @join_builder)
      sort_builder = SortBuilder.new(@join_builder)
      @available_columns = build_column_definitions(custom_report.columns)

      super(query: @join_builder.call,
            filters: filter_builder.call(custom_report.filters),
            sort_columns: sort_builder.call(custom_report.columns),
            current_user: current_user,
            params: params,
            sticky_filters: false)
    end

    def results
      base_results = super
      base_results = base_results.includes(rich_text_associations) if rich_text_associations.any?
      base_results = base_results.includes(attachment_associations) if attachment_associations.any?

      ColumnSelector.new(report: self).apply_column_selection(base_results)
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
            select: is_rich_text || is_attachment ? col['name'] : col['select'],
            is_rich_text: is_rich_text,
            is_attachment: is_attachment,
            formula: col['formula'],
            sortable: col['sortable']
          }
        end
      end

      def rich_text_field?(column_name)
        @model_class.reflect_on_all_associations.any? do |assoc|
          assoc.klass.name == 'ActionText::RichText' &&
            assoc.name.to_s == "rich_text_#{column_name}"
        end
      end

      def attachment_field?(column_name)
        @model_class.reflect_on_all_associations.any? do |assoc|
          assoc.klass.name == 'ActiveStorage::Attachment' &&
            ["#{column_name}_attachment", "#{column_name}_attachments"].include?(assoc.name.to_s)
        end
      end

      def rich_text_associations
        @rich_text_associations ||= column_definitions.filter_map do |column_def|
          next unless column_def&.dig(:is_rich_text)

          :"rich_text_#{column_def[:name]}"
        end
      end

      def attachment_associations
        @attachment_associations ||= column_definitions.filter_map { |column_def|
          next unless column_def&.dig(:is_attachment)

          attachment_name = column_def[:name]
          if @model_class.reflect_on_association(:"#{attachment_name}_attachment")
            :"#{attachment_name}_attachment"
          elsif @model_class.reflect_on_association(:"#{attachment_name}_attachments")
            :"#{attachment_name}_attachments"
          end
        }.compact
      end
  end
end
