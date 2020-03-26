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

    def host_name
      review_app? ? "#{ENV.fetch('HEROKU_APP_NAME')}.herokuapp.com" : ENV.fetch('HOST_NAME')
    end

    def portal_host_name
      raise 'portal_host_name not yet implemented for review apps' if review_app?
      return host_name unless RadCommon.external_users

      ENV.fetch('PORTAL_HOST_NAME')
    end

    def review_app?
      ENV['REVIEW_APP'].present? && ENV['REVIEW_APP'] == 'true'
    end

    private

      def exclude_tables
        %w[active_storage_attachments active_storage_blobs action_text_rich_texts ar_internal_metadata audits
           schema_migrations old_passwords]
      end
  end
end
