$:.push File.expand_path('../lib', __FILE__)

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

  s.add_dependency 'audited', '~> 4.8'
  s.add_dependency 'authority', '3.3.0'
  s.add_dependency 'aws-sdk-s3'
  s.add_dependency 'devise'
  s.add_dependency 'devise-authy'
  s.add_dependency 'devise_invitable'
  s.add_dependency 'faker'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'haml-rails', '1.0.0'
  s.add_dependency 'hashids'
  s.add_dependency 'image_processing', '~> 1.2'
  s.add_dependency 'kaminari', '>= 0.13.0'
  s.add_dependency 'bootstrap4-kaminari-views', '~> 1.0.1'
  s.add_dependency 'momentjs-rails', '~> 2.9', '>= 2.9.0'
  s.add_dependency 'pg'
  s.add_dependency 'premailer-rails', '~> 1.10.2'
  s.add_dependency 'rails', '~> 5.2.1'
  s.add_dependency 'schema_validations'
  s.add_dependency 'sentry-raven'
  s.add_dependency 'sidekiq', '~> 5.2.2'
  s.add_dependency 'simple_form'
  s.add_dependency 'bootstrap', '~> 4.3.1'

  s.add_development_dependency 'active_record_doctor'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'coffee-rails', '~> 4.2'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'firebase', '0.2.6'
  s.add_development_dependency 'listen', '~> 3.0.5'
  s.add_development_dependency 'puma', '~> 3.7'
  s.add_development_dependency 'rad-style'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'
end
