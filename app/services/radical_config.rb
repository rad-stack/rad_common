class RadicalConfig
  def self.secret_config_item!(item)
    value = Rails.application.credentials[item]
    raise "required secret config item #{item} is missing" if value.blank?

    value
  end

  def self.secret_config_item(item)
    Rails.application.credentials[item]
  end

  def self.config_item!(item)
    value = override_variable(item) || Rails.configuration.rad_common[item]
    raise "required config item #{item} is missing" if value.blank?

    value
  end

  def self.override_variable(item)
    ENV[item.to_s.upcase]
  end

  def self.boolean_config_item!(item)
    value = boolean_override_variable(item) || Rails.configuration.rad_common[item]
    raise "required config item #{item} is missing" if value.nil?

    value
  end

  def self.boolean_override_variable(item)
    ENV[item.to_s.upcase].present? && ENV[item.to_s.upcase].downcase == 'true'
  end

  def self.jwt_secret!
    secret_config_item! :jwt_secret
  end

  def self.admin_email!
    secret_config_item! :admin_email
  end

  def self.from_email!
    secret_config_item! :from_email
  end

  def self.hash_key!
    secret_config_item! :hash_key
  end

  def self.hash_alphabet!
    secret_config_item! :hash_alphabet
  end

  def self.sendgrid_api?
    # TODO: refactor
    Rails.application.credentials.sendgrid.present? && Rails.application.credentials.sendgrid[:api_key].present?
  end

  def self.sendgrid_api_key!
    # TODO: raise if blank
    Rails.application.credentials.sendgrid[:api_key]
  end

  def self.host_name!
    config_item! :host_name
  end

  def self.portal_host_name!
    config_item! :portal_host_name
  end

  def self.authy_enabled?
    Rails.configuration.rad_common.authy_enabled
  end

  def self.authy_api_key!
    return unless authy_enabled?

    secret_config_item! :authy_api_key
  end

  def self.authy_api_key
    # TODO: this seems weird just for the vcr thing
    secret_config_item :authy_api_key
  end

  def self.avatar?
    boolean_config_item! :use_avatar
  end

  def self.aws_s_3_access_key_id!
    value = Rails.application.credentials.aws[:s_3][:access_key_id]
    raise "required secret config item aws_s_3_access_key_id is missing" if value.blank?

    value
  end

  # TODO:
  # secret_access_key: <%= Rails.application.credentials.aws[:s_3][:secret_access_key] %>
  #   region: <%= Rails.application.credentials.aws[:s_3][:region] %>
  # bucket: <%= Rails.application.credentials.aws[:s_3][:bucket] %>

  def self.check_aws!
    return unless Rails.application.credentials.aws.blank? || Rails.application.credentials.aws[:s_3].blank?

    # this can be fixed in Rails 6.1 to not have to always have them present
    # https://bigbinary.com/blog/rails-6-1-allows-per-environment-configuration-support-for-active-storage

    raise 'Missing AWS S3 credentials'
  end
end
