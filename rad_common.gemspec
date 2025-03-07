$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'rad_common/version'

Gem::Specification.new do |s|
  s.name = 'rad_common'
  s.version = RadCommon::VERSION
  s.authors = ['Gary Foster']
  s.email = ['gary@radicalbear.com']
  s.homepage = 'https://www.radicalbear.com/'
  s.summary = 'A library of common functions for a rad bear app'
  s.description = 'A library of common functions for a standard business web app, developed by Radical Bear'
  s.license = 'MIT'
  s.metadata['rubygems_mfa_required'] = 'true'
  s.required_ruby_version = '>= 3.3.1'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.bindir = 'bin'
  s.executables = %w[reset_db migrate_reset rc_update]

  s.add_dependency 'active_storage_validations'
  s.add_dependency 'audited'
  s.add_dependency 'authtrail'

  s.add_dependency 'aws-sdk-s3'
  s.add_dependency 'bootstrap4-kaminari-views', '~> 1.0.1'
  s.add_dependency 'devise'
  s.add_dependency 'devise_invitable'
  s.add_dependency 'devise-security', '0.16.0' # locked, see Task 35711
  s.add_dependency 'factory_bot_rails'
  s.add_dependency 'faker'
  s.add_dependency 'geocoder'
  s.add_dependency 'haml-rails', '~> 2.0'
  s.add_dependency 'httpclient'
  s.add_dependency 'hashids'
  s.add_dependency 'image_processing', '~> 1.9'
  s.add_dependency 'kaminari', '~> 1.2.1'
  s.add_dependency 'sassc'
  s.add_dependency 'sprockets-rails'

  # TODO: remove these 3 once the mail gem is up to date, see Task 37200
  s.add_dependency 'net-imap'
  s.add_dependency 'net-pop'
  s.add_dependency 'net-smtp'

  s.add_dependency 'nokogiri'
  s.add_dependency 'pg'
  s.add_dependency 'premailer-rails', '~> 1.10.2'
  s.add_dependency 'pretender'
  s.add_dependency 'puma', '~> 5.6'
  s.add_dependency 'pundit'
  s.add_dependency 'rails', '~> 7.0.8'
  s.add_dependency 'rails_email_validator'

  # TODO: remove this once this warning has been fixed, see Task 37778
  s.add_dependency 'redis', '4.7.1'

  s.add_dependency 'sendgrid-ruby'
  s.add_dependency 'sentry-rails'
  s.add_dependency 'sentry-ruby'
  s.add_dependency 'sidekiq', '~> 6.4.1'
  s.add_dependency 'sidekiq-failures'
  s.add_dependency 'simple_form', '~> 5.0'
  s.add_dependency 'smartystreets_ruby_sdk'
  s.add_dependency 'strip_attributes'
  s.add_dependency 'text'
  s.add_dependency 'twilio-ruby', '~> 5.74'
  s.add_dependency 'webpacker'

  s.add_development_dependency 'active_record_doctor'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'haml_lint', '0.55.0'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-capybara'
  s.add_development_dependency 'rubocop-factory_bot'
  s.add_development_dependency 'rubocop-rails'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'rubocop-rspec_rails'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'wkhtmltopdf-binary'
end
