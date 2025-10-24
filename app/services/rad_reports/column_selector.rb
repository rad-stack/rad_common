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
        next if column_def.blank? || column_def[:is_rich_text] || column_def[:is_attachment]

        sql_select = convert_to_sql_select(column_def[:select])
        unique_alias = column_def[:select].to_s.gsub('.', '_')
        "#{sql_select} AS #{unique_alias}"
      end

      base_pk_clause = "#{query.table_name}.#{query.klass.primary_key}" # Required for attachments, rich text, etc.

      select_clauses.unshift(base_pk_clause)
      query.select(select_clauses.uniq)
    end

    private

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
