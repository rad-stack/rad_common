$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'rad_common/version'

Gem::Specification.new do |s|
  s.name = 'rad_common'
  s.version = RadCommon::VERSION
  s.authors = ['Gary Foster']
  s.summary = 'A library of common functions for a rad bear app'
  s.description = 'A library of common functions for a standard business web app'
  s.license = 'MIT'
  s.metadata['rubygems_mfa_required'] = 'true'
  s.required_ruby_version = '>= 3.4.7'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.bindir = 'bin'
  s.executables = %w[reset_db migrate_reset rc_update rc_rspec rc_parallel_rspec
                     rc_rspec_shared local_backup clone_local reset_staging creds kill_ruby]

  s.add_dependency 'active_storage_validations', '1.0.4' # see Task 43068
  s.add_dependency 'audited'
  s.add_dependency 'authtrail'
  s.add_dependency 'aws-sdk-s3'
  s.add_dependency 'bootstrap5-kaminari-views'
  s.add_dependency 'connection_pool', '< 3' # Remove when upgraded to Rails 8.1.2+
  s.add_dependency 'cssbundling-rails', '~> 1.4'
  s.add_dependency 'csv'
  s.add_dependency 'devise', '~> 5.0.0'
  s.add_dependency 'devise_invitable'
  s.add_dependency 'devise-security'
  s.add_dependency 'factory_bot_rails'
  s.add_dependency 'faker'
  s.add_dependency 'geocoder'
  s.add_dependency 'haml', '7.1' # remove this entire line when Task 12805 is resolved
  s.add_dependency 'haml-rails', '2.1.0' # scaffold breaks beyond this - Task 12874
  s.add_dependency 'hashids'
  s.add_dependency 'image_processing'
  s.add_dependency 'jwt'
  s.add_dependency 'kaminari'
  s.add_dependency 'matrix' # remove once this is released: https://github.com/prawnpdf/prawn/issues/1235
  s.add_dependency 'neighbor'
  s.add_dependency 'nokogiri'
  s.add_dependency 'pg'
  s.add_dependency 'prawn'
  s.add_dependency 'prawn-table'
  s.add_dependency 'premailer-rails'
  s.add_dependency 'pretender'
  s.add_dependency 'propshaft'
  s.add_dependency 'puma'
  s.add_dependency 'pundit'
  s.add_dependency 'rack-attack'
  s.add_dependency 'rails', '~> 7.2.3'
  s.add_dependency 'redis'
  s.add_dependency 'ruby-openai'
  s.add_dependency 'sendgrid-ruby'
  s.add_dependency 'sentry-rails'
  s.add_dependency 'sentry-ruby'
  s.add_dependency 'sidekiq', '~> 7.1'
  s.add_dependency 'simple_form'
  s.add_dependency 'smartystreets_ruby_sdk', '5.20.4'
  s.add_dependency 'strip_attributes'
  s.add_dependency 'text'
  s.add_dependency 'turbo-rails'
  s.add_dependency 'twilio-ruby'
  s.add_dependency 'wicked_pdf', '2.6.3'
  s.add_dependency 'wkhtmltopdf-heroku', '2.12.6.1.pre.jammy'

  # Test Group
  s.add_dependency 'selenium-webdriver', '~> 4.18.1'

  s.add_development_dependency 'active_record_doctor'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'haml_lint'
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
  s.add_development_dependency 'tty-prompt'
end
