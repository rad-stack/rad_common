require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec/vcr')
  c.hook_into :webmock

  # see Task 37353, need the example.com item for now
  c.ignore_hosts '127.0.0.1', 'chromedriver.storage.googleapis.com', 'googlechromelabs.github.io', 'www.example.com'

  if RadConfig.test_mobile_phone.present?
    c.filter_sensitive_data('<TEST_MOBILE_PHONE>') { RadConfig.test_mobile_phone! }

    c.filter_sensitive_data('<TEST_MOBILE_PHONE_STRIPPED>') do
      RadConfig.test_mobile_phone!.gsub('(', '').gsub(')', '').gsub(' ', '').gsub('-', '')
    end
  end

  if RadConfig.test_phone_number.present?
    c.filter_sensitive_data('<TEST_PHONE_NUMBER>') { RadConfig.test_phone_number! }

    c.filter_sensitive_data('<TEST_PHONE_NUMBER_STRIPPED>') do
      RadConfig.test_phone_number!.gsub('(', '').gsub(')', '').gsub(' ', '').gsub('-', '')
    end
  end

  if RadConfig.secret_config_item!(:sinch_access_key).present?
    c.filter_sensitive_data('<SINCH_ACCESS_KEY>') { RadConfig.secret_config_item! :sinch_access_key }
    c.filter_sensitive_data('<SINCH_PROJECT_ID>') { RadConfig.secret_config_item! :sinch_project_id }
    c.filter_sensitive_data('<SINCH_SECRET_KEY>') { RadConfig.secret_config_item! :sinch_secret_key }
    c.filter_sensitive_data('<AUTH_TOKEN>') do |interaction|
      interaction.request.headers['Authorization']&.first
    end
  end

  c.filter_sensitive_data('<SENDGRID_API_KEY>') { RadConfig.sendgrid_api_key! } if RadConfig.sendgrid_api_key.present?

  if RadConfig.secret_config_item(:twilio_alt_verify_service_sid).present?
    c.filter_sensitive_data('<TWILIO_ALT_VERIFY_SERVICE_SID>') do
      RadConfig.secret_config_item!(:twilio_alt_verify_service_sid)
    end
  end

  c.filter_sensitive_data('<SMARTY_AUTH_ID>') { RadConfig.smarty_auth_id! } if RadConfig.smarty_auth_id.present?

  if RadConfig.smarty_auth_token.present?
    c.filter_sensitive_data('<SMARTY_AUTH_TOKEN>') { RadConfig.smarty_auth_token! }
  end

  if RadConfig.secret_config_item(:chrome_username).present?
    c.filter_sensitive_data('chrome_api') do
      "#{RadConfig.secret_config_item!(:chrome_username)}:" \
        "#{RadConfig.secret_config_item!(:chrome_password)}@media.chromedata.com"
    end
  end

  if RadConfig.secret_config_item(:github_access_token).present?
    c.filter_sensitive_data('<GITHUB_ACCESS_TOKEN>') { RadConfig.secret_config_item!(:github_access_token) }
  end

  if RadConfig.secret_config_item(:sentry_api_token).present?
    c.filter_sensitive_data('<SENTRY_API_TOKEN>') { RadConfig.secret_config_item!(:sentry_api_token) }
  end

  c.filter_sensitive_data('<S3_ACCESS_KEY_ID>') { RadConfig.s3_access_key_id! }

  if RadConfig.secret_config_item(:lob_key).present?
    c.filter_sensitive_data('<LOB_KEY>') { RadConfig.secret_config_item!(:lob_key) }
  end
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(%r{[^\w/]+}, '_')
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end
