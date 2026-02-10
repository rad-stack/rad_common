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
        next if column_def[:is_rich_text] || column_def[:is_attachment]

        if column_def[:is_calculated]
          build_calculated_select(column_def)
        else
          sql_select = convert_to_sql_select(column_def[:select])
          unique_alias = column_def[:select].to_s.gsub('.', '_')
          "#{sql_select} AS #{unique_alias}"
        end
      end

      base_pk_clause = "#{query.table_name}.#{query.klass.primary_key}" # Required for attachments, rich text, etc.

      all_selects = [base_pk_clause, *select_clauses]
      query.select(all_selects.compact.uniq)
    end

    def self.convert_to_sql_column(column_path, join_builder)
      parts = column_path.to_s.split('.')
      return column_path if parts.length < 2

      column = parts.last
      association_path = parts[0..-2].join('.')

      base_table = join_builder.model_class.table_name
      table_name = if association_path == base_table
                     base_table
                   else
                     join_builder.association_to_table_map[association_path] || association_path
                   end

      "#{table_name}.#{column}"
    end

    private

      def build_calculated_select(column_def)
        formula_entry = Array(column_def[:formula]).first
        return nil unless formula_entry

        formula_def = RadReports::FormulaRegistry.find(formula_entry['type'])
        return nil unless formula_def

        sql_expr = formula_def[:sql_generator].call(formula_entry['params'] || {}, join_builder)
        alias_name = column_def[:name].to_s.gsub('.', '_')

        "(#{sql_expr}) AS #{alias_name}"
      end

      def convert_to_sql_select(select_clause)
        self.class.convert_to_sql_column(select_clause, join_builder)
      end
  end
end
