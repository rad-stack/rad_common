module RadCommon
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    require 'active_storage_validations'
    require 'audited'
    require 'authtrail'
    require 'authy'
    require 'csv'
    require 'devise'
    require 'devise-security'
    require 'devise_invitable'
    require 'faker'
    require 'faraday'
    require 'haml-rails'
    require 'hashids'
    require 'jwt'
    require 'kaminari'
    require 'bootstrap4-kaminari-views'
    require 'nokogiri'
    require 'pg'
    require 'premailer/rails'
    require 'pretender'
    require 'pundit'
    require 'sendgrid-ruby'
    require 'sentry-rails'
    require 'sentry-ruby'
    require 'sidekiq'
    require 'sidekiq/web'
    require 'simple_form'
    require 'smartystreets_ruby_sdk'
    require 'strip_attributes'
    require 'text'
    require 'twilio-ruby'
    require 'webpacker'
  end
end
