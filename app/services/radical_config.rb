class RadicalConfig
  class << self
    def admin_email!
      secret_config_item! :admin_email
    end

    def from_email!
      secret_config_item! :from_email
    end

    def smtp_username!
      return secret_config_item(:sendgrid_username) if secret_config_item(:sendgrid_username).present?

      secret_config_item! :smtp_username
    end

    def smtp_password!
      return secret_config_item(:sendgrid_password) if secret_config_item(:sendgrid_password).present?

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

    def sendgrid_username!
      secret_nested_config_item! %i[sendgrid username], :sendgrid_username
    end

    def sendgrid_password!
      secret_nested_config_item! %i[sendgrid password], :sendgrid_password
    end

    def sendgrid_api?
      sendgrid_api_key.present?
    end

    def sendgrid_api_key!
      secret_nested_config_item! %i[sendgrid api_key], :sendgrid_api_key
    end

    def sendgrid_api_key
      secret_nested_config_item %i[sendgrid api_key], :sendgrid_api_key
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

    def host_name!
      config_item! :host_name
    end

    def portal_host_name!
      config_item! :portal_host_name
    end

    def avatar?
      boolean_config_item! :use_avatar
    end

    def authy_enabled?
      boolean_config_item! :authy_enabled
    end

    def authy_api_key!
      return unless authy_enabled?

      secret_config_item! :authy_api_key
    end

    def authy_api_key
      secret_config_item :authy_api_key
    end

    def aws_s_3_access_key_id!
      secret_nested_config_item! %i[aws s_3 access_key_id], :s3_access_key_id
    end

    def aws_s_3_secret_access_key!
      secret_nested_config_item! %i[aws s_3 secret_access_key], :s3_secret_access_key
    end

    def aws_s_3_region!
      secret_nested_config_item! %i[aws s_3 region], :s3_region
    end

    def aws_s_3_bucket!
      secret_nested_config_item! %i[aws s_3 bucket], :s3_bucket
    end

    def secret_config_item!(item)
      value = secret_config_item(item)
      raise "required secret config item #{item} is missing" if value.blank?

      value
    end

    def secret_config_item(item)
      Rails.application.credentials[item]
    end

    def config_item!(item)
      value = override_variable(item) || Rails.configuration.rad_common[item]
      raise "required config item #{item} is missing" if value.blank?

      value
    end

    def boolean_config_item!(item)
      value = boolean_override_variable(item) || Rails.configuration.rad_common[item]
      raise "required config item #{item} is missing" if value.nil?

      value
    end

    def check_aws!
      return unless Rails.application.credentials.aws.blank? || Rails.application.credentials.aws[:s_3].blank?

      # this can be fixed in Rails 6.1 to not have to always have them present
      # https://bigbinary.com/blog/rails-6-1-allows-per-environment-configuration-support-for-active-storage

      raise 'Missing AWS S3 credentials'
    end

    private

      def secret_nested_config_item!(nested_keys, flat_key)
        value = secret_nested_config_item(nested_keys, flat_key)
        raise "required secret config item #{nested_keys} is missing" if value.blank?

        value
      end

      def secret_nested_config_item(nested_keys, flat_key)
        override_variable(flat_key) || Rails.application.credentials.dig(*nested_keys)
      end

      def override_variable(item)
        ENV[item.to_s.upcase]
      end

      def boolean_override_variable(item)
        boolean_override_variable_present?(item) && ENV[item.to_s.upcase].downcase == 'true'
      end

      def boolean_override_variable_present?(item)
        ENV[item.to_s.upcase].present?
      end
  end
end
