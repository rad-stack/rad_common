module RadReports
  class SortBuilder
    attr_reader :join_builder

    def initialize(join_builder)
      @join_builder = join_builder
    end

    def call(columns)
      columns.map do |col|
        {
          label: col['label'] || col['name'].humanize,
          column: col['sortable'] ? convert_sort_column_path(col['select']) : nil
        }
      end
    end

    def convert_sort_column_path(column_path)
      return if column_path.blank?

      parts = column_path.to_s.split('.')
      return column_path if parts.length < 2

      column_name = parts.last
      association_path = parts[0..-2].join('.')
      table_name = join_builder.table_name_for_association(association_path)

      "#{table_name}.#{column_name}"
    end
  end
end
