require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec/vcr')
  c.hook_into :webmock
  c.ignore_hosts '127.0.0.1', 'chromedriver.storage.googleapis.com'

  if RadicalConfig.test_mobile_phone.present?
    c.filter_sensitive_data('<TEST_MOBILE_PHONE>') { RadicalConfig.test_mobile_phone! }

    c.filter_sensitive_data('<TEST_MOBILE_PHONE_STRIPPED>') do
      RadicalConfig.test_mobile_phone!.gsub('(', '').gsub(')', '').gsub(' ', '').gsub('-', '')
    end
  end

  if RadicalConfig.test_phone_number.present?
    c.filter_sensitive_data('<TEST_PHONE_NUMBER>') { RadicalConfig.test_phone_number! }

    c.filter_sensitive_data('<TEST_PHONE_NUMBER_STRIPPED>') do
      RadicalConfig.test_phone_number!.gsub('(', '').gsub(')', '').gsub(' ', '').gsub('-', '')
    end
  end

  c.filter_sensitive_data('<AUTHY_API_KEY>') { RadicalConfig.authy_api_key! } if RadicalConfig.authy_api_key.present?

  if RadicalConfig.sendgrid_api_key.present?
    c.filter_sensitive_data('<SENDGRID_API_KEY>') { RadicalConfig.sendgrid_api_key! }
  end

  c.filter_sensitive_data('<LOB_KEY>') { RadicalConfig.lob_key! } if RadicalConfig.lob_key.present?
  c.filter_sensitive_data('<SMARTY_AUTH_ID>') { RadicalConfig.smarty_auth_id! } if RadicalConfig.smarty_auth_id.present?

  if RadicalConfig.smarty_auth_token.present?
    c.filter_sensitive_data('<SMARTY_AUTH_TOKEN>') { RadicalConfig.smarty_auth_token! }
  end
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(%r{[^\w/]+}, '_')
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end
