module RadReports
  class ColumnSelector
    include RadHelper

    attr_reader :report

    def initialize(report:)
      @report = report
    end

    def selected_columns
      report.available_columns.pluck(:select)
    end

    def apply_column_selection(query)
      return query if selected_columns.empty?

      has_rich_text = selected_columns.any? do |select_clause|
        column_def = report.available_columns.find { |c| c[:select] == select_clause }
        column_def&.dig(:is_rich_text)
      end

      has_attachment = selected_columns.any? do |select_clause|
        column_def = report.available_columns.find { |c| c[:select] == select_clause }
        column_def&.dig(:is_attachment)
      end

      return query if has_rich_text || has_attachment

      select_clauses = selected_columns.filter_map { |select_clause|
        column_def = report.available_columns.find { |c| c[:select] == select_clause }
        next unless column_def

        if select_clause.to_s.downcase.include?(' as ')
          select_clause
        else
          # Convert association name to table name for SQL
          # e.g., created_by.name -> users.name (in SQL) but aliased as created_by_name
          sql_select = convert_to_sql_select(select_clause)
          unique_alias = select_clause.to_s.gsub('.', '_')
          "#{sql_select} AS #{unique_alias}"
        end
      }

      if select_clauses.any?
        query.select(select_clauses.join(', '))
      else
        query
      end
    end

    def column_definition(name_or_select)
      report.available_columns.find { |c| c[:select].to_s == name_or_select.to_s } ||
        report.available_columns.find { |c| c[:name].to_s == name_or_select.to_s }
    end

    private

    def convert_to_sql_select(select_clause)
      parts = select_clause.to_s.split('.')
      return select_clause if parts.length < 2

      column = parts.last
      association_path = parts[0..-2].join('.')
      table_name = report.association_to_table_map[association_path] || association_path

      "#{table_name}.#{column}"
    end
  end
end
