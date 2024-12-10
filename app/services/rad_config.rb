require 'mail'

class RadConfig
  class << self
    def default_language_code!
      config_item! :language_code
    end

    def admin_email!
      secret_config_item! :admin_email
    end

    def admin_email_address!
      Mail::Address.new(admin_email!).address
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

    def hash_key!
      secret_config_item! :hash_key
    end

    def hash_alphabet!
      secret_config_item! :hash_alphabet
    end

    def jwt_secret!
      secret_config_item! :jwt_secret
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

    def twilio_mms_phone_number!
      secret_config_item(:twilio_mms_phone_number).presence || twilio_phone_number!
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


    # Config item should be in sync with countries enabled for messaging in twilio account
    # https://console.twilio.com/us1/develop/sms/settings/geo-permissions
    def twilio_countries_enabled!
      config_item!(:twilio_countries_enabled).split(' ')
    end

    def seeded_users!
      raise 'missing seeded_users config' if Rails.application.credentials.seeded_users.blank?

      Rails.application.credentials.seeded_users
    end

    def app_name!
      config_item! :app_name
    end

    def portal_app_name!(user = nil)
      return config_item!(:portal_app_name) if user.blank?

      if user.respond_to?(:portal_patient?) && user.portal_patient?
        config_item! :portal_app_name
      elsif user.respond_to?(:portal_prescriber?) && user.portal_prescriber?
        config_item! :prescriber_portal_app_name
      elsif user.respond_to?(:portal_attorney?) && user.portal_attorney?
        config_item! :attorney_portal_app_name
      else
        config_item! :portal_app_name
      end
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

    def portal_host_name!(user = nil)
      return config_item!(:portal_host_name) if user.blank?

      if user.respond_to?(:portal_patient?) && user.portal_patient?
        config_item! :portal_host_name
      elsif user.respond_to?(:portal_prescriber?) && user.portal_prescriber?
        config_item! :prescriber_portal_host_name
      elsif user.respond_to?(:portal_attorney?) && user.portal_attorney?
        config_item! :attorney_portal_host_name
      else
        config_item! :portal_host_name
      end
    end

    def portal?
      boolean_config_item! :portal
    end

    def impersonate?
      boolean_config_item! :impersonate
    end

    def avatar?
      false
    end

    def twilio_verify_enabled?
      boolean_config_item! :twilio_verify_enabled
    end

    def twilio_verify_internal_only?
      boolean_config_item! :twilio_verify_internal_only
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

    def shared_database?
      boolean_config_item! :shared_database
    end

    def favicon_filename!
      override_variable(:favicon_filename) || 'favicon.ico'
    end

    def app_logo_filename!
      override_variable(:app_logo_filename) || 'app_logo.png'
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

    def additional_user_params!
      array_config_item! :additional_user_params
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
      array_config_item! :system_usage_models
    end

    def global_validity_days!
      config_item! :global_validity_days
    end

    def global_validity_timeout_hours!
      config_item! :global_validity_timeout_hours
    end

    def global_validity_include!
      array_config_item! :global_validity_include
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
      check_twilio_verify!
      check_smarty!
    end

    def enable_super_search?
      boolean_config_item! :enable_super_search
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

      def check_twilio_verify!
        return unless twilio_verify_enabled? && !twilio_enabled?

        raise 'Twilio must be enabled to provide mobile phone # validation when two factor authentication is enabled'
      end

      def check_smarty!
        return if smarty_auth_id.present? && smarty_auth_token.present?
        return if smarty_auth_id.blank? && smarty_auth_token.blank?

        raise 'include all or none of smarty_auth_id and smarty_auth_token'
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
