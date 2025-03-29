module RadCommon
  class AppInfo
    def application_tables
      (ActiveRecord::Base.connection.tables - exclude_tables).sort
    end

    def rad_common_tables
      %w[duplicates notification_security_roles notification_settings notifications notification_types user_statuses
         system_messages user_security_roles]
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
      RadConfig.duplicates!.pluck(:name)
    end

    def duplicates_enabled?(model_name)
      duplicate_model_config(model_name).present?
    end

    def duplicate_model_config(model_name)
      RadConfig.duplicates!.select { |item| item[:name] == model_name }.first
    end

    def client_model_label
      RadConfig.client_table_name!.classify.titleize
    end

    def client_model_class_name
      RadConfig.client_table_name!.classify
    end

    def client_model_class
      RadConfig.client_table_name!.classify.constantize
    end

    private

      def exclude_tables
        %w[active_storage_attachments active_storage_variant_records active_storage_blobs action_text_rich_texts
           action_mailbox_inbound_emails ar_internal_metadata audits schema_migrations old_passwords login_activities]
      end
  end
end
