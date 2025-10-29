module RadReports
  class ColumnSelector
    include RadHelper

    attr_reader :report

    delegate :column_definitions, :join_builder, to: :report

    def initialize(report:)
      @report = report
    end

    def apply_column_selection(query)
      return query if column_definitions.empty?

      select_clauses = column_definitions.filter_map do |column_def|
        next if column_def[:is_rich_text] || column_def[:is_attachment] || column_def[:is_calculated]

        sql_select = convert_to_sql_select(column_def[:select])
        unique_alias = column_def[:select].to_s.gsub('.', '_')
        "#{sql_select} AS #{unique_alias}"
      end

      base_pk_clause = "#{query.table_name}.#{query.klass.primary_key}" # Required for attachments, rich text, etc.

      all_selects = [base_pk_clause, *select_clauses, *calculated_support_selects]
      query.select(all_selects.compact.uniq)
    end

    private

      def calculated_support_selects
        column_definitions.flat_map do |column_def|
          next [] unless column_def[:is_calculated]

          Array(column_def[:formula]).flat_map do |transform|
            Array(transform.dig('params', 'columns')).filter_map do |column_path|
              next if column_path.blank?

              sql_select = convert_to_sql_select(column_path)
              next if sql_select.blank?

              alias_name = column_path.to_s.gsub('.', '_')
              "#{sql_select} AS #{alias_name}"
            end
          end
        end
      end

      def convert_to_sql_select(select_clause)
        parts = select_clause.to_s.split('.')
        return select_clause if parts.length < 2

        column = parts.last
        association_path = parts[0..-2].join('.')
        table_name = join_builder.association_to_table_map[association_path] || association_path

        "#{table_name}.#{column}"
      end
  end
end
