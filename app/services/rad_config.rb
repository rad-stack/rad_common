require 'mail'

class RadConfig
  class << self
    def admin_email!
      secret_config_item! :admin_email
    end

    def admin_email_address!
      Mail::Address.new(admin_email!).address
    end

    def developer_domain!
      secret_config_item! :developer_domain
    end

    def from_email!
      secret_config_item! :from_email
    end

    def smtp_username!
      secret_config_item! :smtp_username
    end

    def smtp_password!
      secret_config_item! :smtp_password
    end

    def smtp_address!
      override_variable(:smtp_address) || 'smtp.sendgrid.net'
    end

    def smtp_port!
      override_variable(:smtp_port) || 587
    end

    def smtp_enable_starttls_auto!
      if boolean_override_variable_present?(:smtp_enable_starttls_auto)
        return boolean_override_variable(:smtp_enable_starttls_auto)
      end

      true
    end

    def smtp_domain!
      override_variable(:smtp_domain) || 'sendgrid.com'
    end

    def smtp_authentication!
      override_variable(:smtp_authentication) || 'plain'
    end

    def sendgrid_api?
      sendgrid_api_key.present?
    end

    def sendgrid_api_key!
      secret_config_item! :sendgrid_api_key
    end

    def sendgrid_api_key
      secret_config_item :sendgrid_api_key
    end

    def smarty_enabled?
      smarty_auth_id.present?
    end

    def smarty_auth_id
      secret_config_item :smarty_auth_id
    end

    def smarty_auth_id!
      secret_config_item! :smarty_auth_id
    end

    def smarty_auth_token
      secret_config_item :smarty_auth_token
    end

    def smarty_auth_token!
      secret_config_item! :smarty_auth_token
    end

    def open_ai_api_key!
      secret_config_item! :open_ai_api_key
    end

    def open_ai_api_key
      secret_config_item :open_ai_api_key
    end

    def hash_key!
      secret_config_item! :hash_key
    end

    def hash_alphabet!
      secret_config_item! :hash_alphabet
    end

    def jwt_secret!
      secret_config_item! :jwt_secret
    end

    def jwt_enabled?
      secret_config_item(:jwt_secret).present?
    end

    def timeout_hours!
      config_item! :timeout_hours
    end

    def test_phone_number
      secret_config_item :test_phone_number
    end

    def test_phone_number!
      secret_config_item! :test_phone_number
    end

    def test_mobile_phone
      secret_config_item :test_mobile_phone
    end

    def test_mobile_phone!
      secret_config_item! :test_mobile_phone
    end

    def test_fax_number!
      secret_config_item! :test_fax_number
    end

    def twilio_enabled?
      if secret_config_item(:twilio_account_sid).blank? &&
         secret_config_item(:twilio_auth_token).blank? &&
         secret_config_item(:twilio_phone_number).blank?

        return false
      end

      if secret_config_item(:twilio_account_sid).present? &&
         secret_config_item(:twilio_auth_token).present? &&
         secret_config_item(:twilio_phone_number).present?

        return true
      end

      raise 'inconsistent twilio config'
    end

    def twilio_phone_number!
      secret_config_item! :twilio_phone_number
    end

    def twilio_account_sid!
      secret_config_item! :twilio_account_sid
    end

    def twilio_auth_token!
      secret_config_item! :twilio_auth_token
    end

    def twilio_verify_service_sid!
      secret_config_item! :twilio_verify_service_sid
    end

    def two_factor_auth_enabled?
      boolean_config_item! :two_factor_auth_enabled
    end

    def two_factor_auth_all_users?
      boolean_config_item! :two_factor_auth_all_users
    end

    def twilio_verify_remember_device!
      config_item!(:two_factor_remember_device_days).days
    end

    def expire_password_after!
      config_item!(:expire_password_after_days).days
    end

    def seeded_users!
      raise 'missing seeded_users config' if Rails.application.credentials.seeded_users.blank?

      Rails.application.credentials.seeded_users
    end

    def app_name!
      config_item! :app_name
    end

    def host_name!
      config_item! :host_name
    end

    def start_route!
      "/#{config_item!(:start_route)}"
    end

    def client_table_name!
      config_item(:client_table_name) || 'clients'
    end

    def impersonate?
      return true unless Rails.env.production?

      boolean_config_item! :impersonate
    end

    def show_sign_in_marketing?
      boolean_config_item! :show_sign_in_marketing
    end

    def avatar?
      boolean_config_item! :use_avatar
    end

    def switch_languages?
      boolean_config_item! :switch_languages
    end

    def require_mobile_phone?
      boolean_config_item! :require_mobile_phone
    end

    def validate_user_domains?
      boolean_config_item! :validate_user_domains
    end

    def storage_config_override?
      boolean_config_item! :storage_config_override
    end

    def database_config_override?
      boolean_config_item! :database_config_override
    end

    def procfile_override?
      boolean_config_item! :procfile_override
    end

    def external_users?
      boolean_config_item! :external_users
    end

    def validate_external_email_domain?
      boolean_config_item! :validate_external_email_domain
    end

    def disable_sign_up?
      boolean_config_item! :disable_sign_up
    end

    def disable_invite?
      boolean_config_item! :disable_invite
    end

    def manually_create_users?
      boolean_config_item! :manually_create_users
    end

    def pending_users?
      boolean_config_item! :pending_users
    end

    def show_help_menu?
      boolean_config_item! :show_help_menu
    end

    def force_marketing_site?
      boolean_config_item! :force_marketing_site
    end

    def allow_marketing_site?
      boolean_config_item! :allow_marketing_site
    end

    def marketing_subdomain
      config_item(:marketing_subdomain).presence || 'www'
    end

    def canadian_addresses?
      boolean_config_item! :canadian_addresses
    end

    def saved_search_filters_enabled?
      boolean_config_item! :saved_search_filters_enabled
    end

    def filter_toggle_default_behavior!
      config_item! :filter_toggle_default_behavior
    end

    def legal_docs?
      boolean_config_item! :legal_docs
    end

    def legacy_assets?
      config_item(:legacy_assets).presence || false
    end

    def shared_database?
      config_item(:shared_database).presence || false
    end

    def app_logo_includes_name?
      boolean_config_item! :app_logo_includes_name
    end

    def user_clients?
      boolean_config_item! :user_clients
    end

    def user_profiles?
      boolean_config_item! :user_profiles
    end

    def portal?
      boolean_config_item! :portal
    end

    def secure_sentry?
      boolean_config_item! :secure_sentry
    end

    def s3_access_key_id!
      secret_config_item! :s3_access_key_id
    end

    def s3_secret_access_key!
      secret_config_item! :s3_secret_access_key
    end

    def s3_region!
      secret_config_item! :s3_region
    end

    def s3_bucket!
      secret_config_item! :s3_bucket
    end

    def additional_company_params!
      array_config_item! :additional_company_params
    end

    def rad_assistant_system_tools!
      array_config_item! :rad_assistant_system_tools
    end

    def additional_user_params!
      array_config_item! :additional_user_params
    end

    def additional_user_profile_params!
      array_config_item! :additional_user_profile_params
    end

    def restricted_audit_attributes!
      array_config_item! :restricted_audit_attributes
    end

    def global_search_scopes!
      items = array_config_item!(:global_search_scopes)
      raise 'global_search_scopes contain duplicate name(s)' unless items.pluck(:name).uniq.size == items.size

      items
    end

    def system_usage_models!
      array_config_item!(:system_usage_models) +
        [['ContactLogRecipient', 'successful', 'Successful Contacts'],
         ['ContactLogRecipient', 'failed', 'Failed Contacts'],
         'Notification']
    end

    def global_validity_days!
      config_item! :global_validity_days
    end

    def global_validity_timeout_hours!
      config_item! :global_validity_timeout_hours
    end

    def global_validity_exclude!
      array_config_item! :global_validity_exclude
    end

    def global_validity_supress!
      array_config_item! :global_validity_supress
    end

    def duplicates!
      array_config_item! :duplicates
    end

    def user_confirmable?
      Devise.mappings[:user].confirmable?
    end

    def user_expirable?
      Devise.mappings[:user].expirable?
    end

    def password_expirable?
      Devise.mappings[:user].password_expirable?
    end

    def allow_crawling?
      boolean_config_item! :allow_crawling
    end

    def rad_system_chat_enabled?
      boolean_config_item! :rad_system_chat_enabled
    end

    def action_cable_enabled?
      config_item(:action_cable_enabled).to_s.downcase == 'true'
    end

    def always_crawl?
      boolean_config_item! :always_crawl
    end

    def crawlable_subdomains
      array_config_item! :crawlable_subdomains
    end

    def last_first_user?
      boolean_config_item! :last_first_user
    end

    def timezone_detection?
      boolean_config_item! :timezone_detection
    end

    def blocked_ip_addresses?
      secret_config_item(:blocked_ip_addresses).present?
    end

    def blocked_ip_addresses!
      secret_config_item!(:blocked_ip_addresses).split(',')
    end

    def secret_config_item!(item)
      value = secret_config_item(item)
      raise "required secret config item #{item} is missing" if value.blank?

      value
    end

    def secret_config_item(item)
      override_variable(item) || Rails.application.credentials[item]
    end

    def config_item!(item)
      value = config_item(item)
      raise "required config item #{item} is missing" if value.blank?

      value
    end

    def config_item(item)
      override_variable(item) || Rails.configuration.rad_common[item]
    end

    def boolean_config_item!(item)
      return boolean_override_variable(item) if boolean_override_variable_present?(item)

      raw_config_item! item
    end

    def array_config_item!(item)
      raw_config_item! item
    end

    def raw_config_item!(item)
      value = Rails.configuration.rad_common[item]
      raise "required config item #{item} is missing" if value.nil?

      value
    end

    def check_validity!
      check_aws!
      check_two_factor!
      check_smarty!
      check_marketing!
      check_external!
    end

    private

      def check_aws!
        if secret_config_item(:s3_region).present? &&
           secret_config_item(:s3_access_key_id).present? &&
           secret_config_item(:s3_secret_access_key).present? &&
           secret_config_item(:s3_bucket).present?
          return
        end

        # this can be fixed in Rails 6.1 to not have to always have them present
        # https://bigbinary.com/blog/rails-6-1-allows-per-environment-configuration-support-for-active-storage

        raise 'Missing AWS S3 credentials'
      end

      def check_two_factor!
        return unless two_factor_auth_enabled? && !twilio_enabled?

        raise 'Twilio must be enabled to provide mobile phone # validation when two factor authentication is enabled'
      end

      def check_smarty!
        return if smarty_auth_id.present? && smarty_auth_token.present?
        return if smarty_auth_id.blank? && smarty_auth_token.blank?

        raise 'include all or none of smarty_auth_id and smarty_auth_token'
      end

      def check_marketing!
        return unless force_marketing_site? && !allow_marketing_site?

        raise 'force_marketing_site not allowed'
      end

      def check_external!
        return unless user_clients? && !external_users?

        raise 'user_clients requires external_users'
      end

      def override_variable(item)
        ENV.fetch(item.to_s.upcase, nil)
      end

      def boolean_override_variable(item)
        boolean_override_variable_present?(item) && ENV[item.to_s.upcase].downcase == 'true'
      end

      def boolean_override_variable_present?(item)
        ENV[item.to_s.upcase].present?
      end
  end
end
