module RadReports
  class ColumnSelector
    include RadHelper

    attr_reader :report

    def initialize(report:)
      @report = report
    end

    def selected_columns
      report.available_columns.pluck(:name)
    end

    def apply_column_selection(query)
      return query if selected_columns.empty?

      has_rich_text = selected_columns.any? do |col_name|
        column_def = report.available_columns.find { |c| c[:name] == col_name }
        column_def&.dig(:format) == :rich_text
      end

      return query if has_rich_text

      select_clauses = selected_columns.filter_map { |col_name|
        column_def = report.available_columns.find { |c| c[:name] == col_name }
        next unless column_def

        select_clause = column_def[:select]

        if select_clause.to_s.downcase.include?(' as ')
          select_clause
        else
          "#{select_clause} AS #{col_name}"
        end
      }

      if select_clauses.any?
        query.select(select_clauses.join(', '))
      else
        query
      end
    end

    def column_definition(name)
      report.available_columns.find { |c| c[:name].to_s == name.to_s }
    end

    def format_value(column_name, value)
      column_def = column_definition(column_name)
      RadReports::ValueFormatter.call(column_def, value)
    end
  end
end
