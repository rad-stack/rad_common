module RadReports
  class JoinBuilder
    attr_reader :model_class, :joins

    def initialize(model_class, joins)
      @model_class = model_class
      @joins = joins || []
    end

    def build_query
      return model_class.all if @joins.blank?

      join_sources = build_recursive_joins(
        base_table: model_class.arel_table,
        current_class: model_class,
        join_hash: build_initial_join_hash,
        path_prefix: ''
      )

      model_class.joins(join_sources)
    end

    def table_name_for_association(association_path)
      association_to_table_map[association_path] || association_path
    end

    def association_to_table_map
      @association_to_table_map ||= @joins.each_with_object({}) do |join_path, map|
        parts = join_path.split('.')
        current_class = model_class

        parts.each_with_index do |part, index|
          association = current_class.reflect_on_association(part.to_sym)
          next unless association

          path_so_far = parts[0..index].join('.')
          alias_name = "#{path_so_far.gsub('.', '_')}_#{association.table_name}"
          map[path_so_far] = alias_name

          current_class = association.klass
        end
      end
    end

    private

      def build_initial_join_hash
        @joins.each_with_object({}) do |join_path, join_hash|
          parts = join_path.split('.')
          current_level = join_hash

          parts.each_with_index do |part, index|
            part_sym = part.to_sym

            if index == parts.length - 1
              current_level[part_sym] ||= {}
            else
              current_level[part_sym] ||= {}
              current_level = current_level[part_sym]
            end
          end
        end
      end

      def build_recursive_joins(base_table:, current_class:, join_hash:, path_prefix:, parent_table_ref: nil)
        join_sources = []

        join_hash.each do |association_name, nested_joins|
          reflection = current_class.reflect_on_association(association_name.to_sym)
          next unless reflection

          current_path = build_join_path(path_prefix, association_name)
          join_alias = association_to_table_map[current_path]
          next unless join_alias

          join_table = reflection.klass.arel_table.alias(join_alias)
          left_table = parent_table_ref || base_table

          join_condition = build_join_condition(reflection, join_table, left_table)
          join_sources << base_table.join(join_table).on(join_condition).join_sources

          next unless nested_joins.is_a?(Hash) && nested_joins.any?

          join_sources.concat(
            build_recursive_joins(
              base_table: base_table,
              current_class: reflection.klass,
              join_hash: nested_joins,
              path_prefix: current_path,
              parent_table_ref: join_table
            )
          )
        end

        join_sources.flatten
      end

      def build_join_path(prefix, association_name)
        prefix.present? ? "#{prefix}.#{association_name}" : association_name.to_s
      end

      def build_join_condition(reflection, join_table, left_table)
        if reflection.belongs_to?
          join_table[reflection.join_primary_key].eq(left_table[reflection.foreign_key])
        else
          join_table[reflection.foreign_key].eq(left_table[reflection.active_record_primary_key])
        end
      end
  end
end
