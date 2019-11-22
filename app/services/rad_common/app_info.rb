module RadCommon
  class AppInfo
    def application_tables
      (ActiveRecord::Base.connection.tables - exclude_tables).sort
    end

    def application_models
      application_tables.map { |model| model.capitalize.singularize.camelize }.sort
    end

    def audited_models
      application_models.select do |model|
        model_class = model.safe_constantize
        model_class.respond_to?(:auditing_enabled) && model_class.auditing_enabled
      end
    end

    private

      def exclude_tables
        %w[active_storage_attachments active_storage_blobs ar_internal_metadata audits schema_migrations]
      end
  end
end
