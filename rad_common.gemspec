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
  s.required_ruby_version = '>= 3.0.4'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.bindir = 'bin'
  s.executables = %w[reset_db migrate_reset rc_update rc_rspec rc_parallel_rspec]

  s.add_dependency 'active_storage_validations'
  s.add_dependency 'audited'
  s.add_dependency 'authtrail'
  s.add_dependency 'aws-sdk-s3'
  s.add_dependency 'bootstrap4-kaminari-views'
  s.add_dependency 'devise'
  s.add_dependency 'devise_invitable'
  s.add_dependency 'devise-security'
  s.add_dependency 'factory_bot_rails'
  s.add_dependency 'faker'
  s.add_dependency 'haml-rails'
  s.add_dependency 'hashids'
  s.add_dependency 'image_processing'
  s.add_dependency 'jwt'
  s.add_dependency 'kaminari'
  s.add_dependency 'matrix' # remove once this is released: https://github.com/prawnpdf/prawn/issues/1235

  s.add_dependency 'nokogiri'

  # this needs to match the ruby version to avoid warnings, see Task 40504
  s.add_dependency 'parser', '~> 3.1.2.1'

  s.add_dependency 'pg'
  s.add_dependency 'prawn'
  s.add_dependency 'prawn-table'
  s.add_dependency 'premailer-rails'
  s.add_dependency 'pretender'
  s.add_dependency 'puma'
  s.add_dependency 'pundit'
  s.add_dependency 'rails'
  s.add_dependency 'redis'
  s.add_dependency 'sassc'
  s.add_dependency 'sendgrid-ruby'
  s.add_dependency 'sentry-rails'
  s.add_dependency 'sentry-ruby'
  s.add_dependency 'sidekiq', '~> 7.1'
  s.add_dependency 'simple_form'
  s.add_dependency 'smartystreets_ruby_sdk'
  s.add_dependency 'strip_attributes'
  s.add_dependency 'text'
  s.add_dependency 'twilio-ruby'
  s.add_dependency 'webpacker'

  s.add_development_dependency 'active_record_doctor'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'haml_lint'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rails'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
