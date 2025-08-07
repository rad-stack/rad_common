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
      (application_models.select { |model|
        model_class = model.safe_constantize
        model_class.respond_to?(:auditing_enabled) && model_class.auditing_enabled
      } + %w[ActiveStorage::Attachment ActionText::RichText]).sort
    end

    def associated_audited_models
      audited_models + %w[ActiveStorage::Blob ActiveStorage::VariantRecord ActionMailbox::InboundEmail]
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

    def show_routes
      model_names = application_models

      Rails.application.routes.routes.map { |route|
        next unless show_route?(route)

        model_names.detect do |item|
          model = item.safe_constantize
          next if model.nil?

          route.defaults[:controller] == model.model_name.route_key
        end
      }.compact.uniq.sort
    end

    private

      def exclude_tables
        %w[active_storage_attachments active_storage_variant_records active_storage_blobs action_text_rich_texts
           action_mailbox_inbound_emails ar_internal_metadata audits schema_migrations old_passwords login_activities]
      end

      def show_route?(route)
        route.defaults[:action] == 'show' && route.path.spec.to_s.include?('/:id') && route.verb&.match(/^GET$/)
      end
  end
end
