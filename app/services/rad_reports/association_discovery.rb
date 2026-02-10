module RadReports
  class AssociationDiscovery
    # Models/associations that should never be joined
    EXCLUDED_ASSOCIATIONS = %w[
      ActionText::RichText
      ActiveStorage::Attachment
      Audited::Audit
    ].freeze

    attr_reader :model_name, :existing_joins

    def initialize(model_name, existing_joins = [])
      @model_name = model_name
      @existing_joins = existing_joins
    end

    def available_associations
      return [] if model_name.blank?

      klass = model_name.constantize
      base_associations = associations_for_class(klass)
      nested_associations = build_nested_associations(klass)
      existing_join_definitions = build_existing_join_definitions(klass)

      (base_associations + nested_associations + existing_join_definitions).uniq { |a| a[:name] }.compact
    rescue NameError
      []
    end

    def model_associations
      return [] if model_name.blank?

      klass = model_name.constantize
      klass.reflect_on_all_associations.filter_map do |assoc|
        next if should_exclude_association?(assoc)

        build_model_association_pair(assoc)
      end
    rescue NameError
      []
    end

    private

      def build_nested_associations(base_klass)
        existing_joins.flat_map do |join_path|
          associated_class = navigate_join_path(base_klass, join_path)
          next [] unless associated_class

          nested_associations_for_class(associated_class, join_path, base_klass)
        end
      end

      def associations_for_class(klass, join_prefix = nil)
        klass.reflect_on_all_associations.filter_map do |assoc|
          next if should_exclude_association?(assoc)

          build_association_definition(assoc, klass, join_prefix)
        end
      end

      def build_association_definition(assoc, klass, join_prefix)
        associated_class = assoc.klass
        join_path = build_join_path(join_prefix, assoc.name)

        return nil if creates_circular_reference?(klass, associated_class, join_path)

        {
          name: join_path,
          label: build_association_label(join_prefix, assoc.name),
          type: assoc.macro.to_s,
          class_name: associated_class.name,
          table_name: associated_class.table_name,
          foreign_key: assoc.foreign_key,
          depth: calculate_depth(join_prefix)
        }
      rescue NameError
        nil
      end

      def build_join_path(prefix, name)
        prefix ? "#{prefix}.#{name}" : name.to_s
      end

      def build_association_label(prefix, name)
        prefix ? "#{prefix.titleize} → #{name.to_s.titleize}" : name.to_s.titleize
      end

      def calculate_depth(prefix)
        prefix ? prefix.split('.').length + 1 : 1
      end

      def nested_associations_for_class(associated_class, join_path, base_class)
        associated_class.reflect_on_all_associations.filter_map do |assoc|
          next if should_exclude_association?(assoc)
          next if existing_joins.include?("#{join_path}.#{assoc.name}")

          build_nested_association_definition(assoc, join_path, base_class)
        end
      end

      def build_nested_association_definition(assoc, join_path, base_class)
        nested_class = assoc.klass
        nested_join_path = "#{join_path}.#{assoc.name}"

        return nil if creates_circular_reference?(base_class, nested_class, nested_join_path)

        {
          name: nested_join_path,
          label: "#{join_path.titleize} → #{assoc.name.to_s.titleize}",
          type: assoc.macro.to_s,
          class_name: nested_class.name,
          table_name: nested_class.table_name,
          foreign_key: assoc.foreign_key,
          depth: join_path.split('.').length + 1
        }
      rescue NameError
        nil
      end

      def build_model_association_pair(assoc)
        associated_class = assoc.klass
        association_type = assoc.macro.to_s.humanize
        label = "#{assoc.name.to_s.titleize} (#{association_type} #{associated_class.model_name.human})"

        [label, assoc.name.to_s]
      rescue NameError
        nil
      end

      def navigate_join_path(base_class, join_path)
        path_parts = join_path.split('.')
        current_class = base_class

        path_parts.each do |part|
          assoc = current_class.reflect_on_association(part.to_sym)
          return nil unless assoc

          current_class = assoc.klass
        end

        current_class
      end

      def should_exclude_association?(assoc)
        assoc.polymorphic? ||
          through_option?(assoc) ||
          excluded_association_class?(assoc) ||
          duplicate_association?(assoc) ||
          config_excluded_association?(assoc) ||
          has_many_association?(assoc) ||
          !model_available?(assoc)
      rescue NameError
        true
      end

      def through_option?(assoc)
        assoc.options[:through].present?
      end

      def excluded_association_class?(assoc)
        EXCLUDED_ASSOCIATIONS.include?(assoc.klass.name)
      end

      def duplicate_association?(assoc)
        assoc.name.to_s.include?('duplicate')
      end

      def config_excluded_association?(assoc)
        excluded_associations.include?(assoc.name.to_s)
      end

      # Currently disabled to prevent potential performance issues with has_many associations
      def has_many_association?(assoc)
        assoc.macro == :has_many
      end

      def model_available?(assoc)
        RadReports::ModelDiscovery.model_available?(assoc.klass)
      end

      def creates_circular_reference?(base_class, target_class, join_path)
        models_in_chain = build_model_chain(base_class, join_path)
        models_in_chain[0..-2].any? { |model| model.name == target_class.name }
      end

      def build_model_chain(base_class, join_path)
        models = [base_class]
        current_class = base_class

        join_path.split('.').each do |part|
          assoc = current_class.reflect_on_association(part.to_sym)
          break unless assoc

          current_class = assoc.klass
          models << current_class
        end

        models
      end

      def build_existing_join_definitions(base_klass)
        existing_joins.filter_map do |join_path|
          target_class = navigate_join_path(base_klass, join_path)
          next unless target_class

          parts = join_path.split('.')
          if parts.length == 1
            assoc = base_klass.reflect_on_association(parts.first.to_sym)
            next unless assoc

            build_association_definition(assoc, base_klass, nil)
          else
            parent_path = parts[0..-2].join('.')
            parent_class = navigate_join_path(base_klass, parent_path)
            next unless parent_class

            last_part = parts.last
            assoc = parent_class.reflect_on_association(last_part.to_sym)
            next unless assoc

            build_association_definition(assoc, parent_class, parent_path)
          end
        end
      end

      def excluded_associations
        @excluded_associations ||= Array(RadConfig.custom_reports_config[:excluded_associations]).map(&:to_s)
      end
  end
end
