$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'rad_common/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rad_common'
  s.version     = RadCommon::VERSION
  s.authors     = ['Gary Foster']
  s.email       = ['gary@radicalbear.com']
  s.homepage    = 'http://www.radicalbear.com'
  s.summary     = 'A library of common functions for a rad bear app'
  s.description = 'A library of common functions for a standard business web app, developed by Radical Bear'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'audited', '~> 4.9'
  s.add_dependency 'aws-sdk-s3'
  s.add_dependency 'bootstrap', '~> 4.3.1'
  s.add_dependency 'bootstrap-select-rails', '~> 1.13.8'
  s.add_dependency 'bootstrap4-kaminari-views', '~> 1.0.1'
  s.add_dependency 'devise'
  s.add_dependency 'devise-authy'
  s.add_dependency 'devise_invitable'
  s.add_dependency 'faker'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'haml-rails', '~> 2.0'
  s.add_dependency 'hashids'
  s.add_dependency 'image_processing', '~> 1.9'
  s.add_dependency 'kaminari', '>= 0.13.0'
  s.add_dependency 'momentjs-rails', '~> 2.9', '>= 2.9.0'
  s.add_dependency 'pg'
  s.add_dependency 'premailer-rails', '~> 1.10.2'
  s.add_dependency 'pundit'
  s.add_dependency 'rails', '~> 6.0.2.2'
  s.add_dependency 'sentry-raven', '~> 3.0.0'
  s.add_dependency 'sidekiq', '~> 5.2.2'
  s.add_dependency 'sidekiq-failures'
  s.add_dependency 'simple_form', '~> 5.0.1'
  s.add_dependency 'twilio-ruby', '~> 5.31.0'
  s.add_dependency 'webpacker'

  s.add_development_dependency 'active_record_doctor'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'coffee-rails', '~> 5.0'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'firebase', '0.2.6'
  s.add_development_dependency 'listen', '~> 3.0.5'
  s.add_development_dependency 'puma', '~> 3.7'
  s.add_development_dependency 'rad-style'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rails'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
