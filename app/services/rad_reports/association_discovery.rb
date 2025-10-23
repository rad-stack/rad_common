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

    # Get available associations that can be added as joins
    # Excludes already-joined associations and prevents circular references
    def available_associations
      return [] if model_name.blank?

      klass = model_name.constantize
      result = []

      # Get direct associations from the base model
      result.concat(associations_for_class(klass))

      # For each existing join, get its associations too
      existing_joins.each do |join_path|
        associated_class = navigate_join_path(klass, join_path)
        next unless associated_class

        result.concat(nested_associations_for_class(associated_class, join_path, klass))
      end

      result.compact
    rescue NameError
      []
    end

    # Simple list of associations for model selection (legacy support)
    def model_associations
      return [] unless model_name.present?

      klass = model_name.constantize

      klass.reflect_on_all_associations.filter_map do |assoc|
        next if should_exclude_association?(assoc)

        begin
          associated_class = assoc.klass
          association_type = assoc.macro.to_s.humanize

          label = "#{assoc.name.to_s.titleize} (#{association_type} #{associated_class.model_name.human})"
          [label, assoc.name.to_s]
        rescue NameError
          nil
        end
      end
    rescue NameError
      []
    end

    private

    def associations_for_class(klass, join_prefix = nil)
      klass.reflect_on_all_associations.filter_map do |assoc|
        next if should_exclude_association?(assoc)

        begin
          associated_class = assoc.klass
          join_path = join_prefix ? "#{join_prefix}.#{assoc.name}" : assoc.name.to_s

          # Skip if this would create a circular reference
          next if creates_circular_reference?(klass, associated_class, join_path)

          {
            name: join_path,
            label: join_prefix ? "#{join_prefix.titleize} → #{assoc.name.to_s.titleize}" : assoc.name.to_s.titleize,
            type: assoc.macro.to_s,
            class_name: associated_class.name,
            table_name: associated_class.table_name,
            foreign_key: assoc.foreign_key,
            depth: join_prefix ? join_prefix.split('.').length + 1 : 1
          }
        rescue NameError
          nil
        end
      end
    end

    def nested_associations_for_class(associated_class, join_path, base_class)
      associated_class.reflect_on_all_associations.filter_map do |assoc|
        next if should_exclude_association?(assoc)

        begin
          nested_class = assoc.klass
          nested_join_path = "#{join_path}.#{assoc.name}"

          # Don't include if already in joins
          next if existing_joins.include?(nested_join_path)

          # Skip if this would create a circular reference back to base or any intermediate model
          next if creates_circular_reference?(base_class, nested_class, nested_join_path)

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
      end
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
      # Skip polymorphic associations
      return true if assoc.polymorphic?

      # Skip has_many :through for now
      return true if assoc.options[:through].present?

      # Skip internal Rails associations
      return true if EXCLUDED_ASSOCIATIONS.include?(assoc.klass.name)

      # Skip duplicate associations
      return true if assoc.name.to_s.include?('duplicate')

      # Check configuration for excluded associations
      return true if excluded_associations.include?(assoc.name.to_s)

      # Skip if the associated model is not available for custom reports
      return true unless RadReports::ModelDiscovery.model_available?(assoc.klass)

      false
    rescue NameError
      true
    end

    def creates_circular_reference?(base_class, target_class, join_path)
      # Get all models in the current join chain
      models_in_chain = [base_class]

      # Navigate the join path to collect all models
      current_class = base_class
      join_path.split('.').each do |part|
        assoc = current_class.reflect_on_association(part.to_sym)
        break unless assoc

        current_class = assoc.klass
        models_in_chain << current_class
      end

      # Check if the target class is already in the chain (excluding the last one which is the target itself)
      # This prevents circular references like: User -> Division -> User
      models_in_chain[0..-2].any? { |model| model.name == target_class.name }
    end

    def excluded_associations
      @excluded_associations ||= begin
        config = RadConfig.custom_reports_config
        Array(config[:excluded_associations]).map(&:to_s)
      end
    end
  end
end
