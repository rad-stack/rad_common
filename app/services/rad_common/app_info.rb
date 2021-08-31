module RadCommon
  class AppInfo
    def application_tables
      (ActiveRecord::Base.connection.tables - exclude_tables).sort
    end

    def application_models
      application_tables.map(&:classify).sort
    end

    def audited_models
      application_models.select do |model|
        model_class = model.safe_constantize
        model_class.respond_to?(:auditing_enabled) && model_class.auditing_enabled
      end
    end

    def duplicate_models
      Rails.configuration.rad_common.duplicates[:models].pluck(:name)
    end

    def duplicates_enabled?(model_name)
      duplicate_model_config(model_name).present?
    end

    def duplicate_model_config(model_name)
      Rails.configuration.rad_common.duplicates[:models].select { |item| item[:name] == model_name }.first
    end

    private

      def exclude_tables
        %w[active_storage_attachments active_storage_variant_records active_storage_blobs action_text_rich_texts
           ar_internal_metadata audits schema_migrations old_passwords login_activities twilio_logs]
      end
  end
end
