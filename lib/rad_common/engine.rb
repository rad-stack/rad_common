module RadCommon
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    ActiveSupport.on_load(:action_controller) do
      include DeviseTwilioVerify::Controllers::Helpers
    end

    ActiveSupport.on_load(:action_view) do
      include DeviseTwilioVerify::Views::Helpers
    end

    config.after_initialize do
      Devise::Mapping.prepend DeviseTwilioVerify::Mapping
    end

    require 'active_storage_validations'
    require 'audited'
    require 'authtrail'
    require 'chartkick'
    require 'csv'
    require 'devise'
    require 'devise-twilio-verify'
    require 'devise-security'
    require 'devise_invitable'
    require 'faker'
    require 'faraday'
    require 'geocoder'
    require 'haml-rails'
    require 'hashids'
    require 'jwt'
    require 'kaminari'
    require 'lexxy'
    require 'bootstrap5-kaminari-views'
    require 'neighbor'
    require 'nokogiri'
    require 'pg'
    require 'prawn'
    require 'prawn/table'
    require 'premailer/rails'
    require 'pretender'
    require 'pundit'
    require 'rack/attack'
    require 'openai'
    require 'sendgrid-ruby'
    require 'sentry-rails'
    require 'sentry-ruby'
    require 'sidekiq'
    require 'sidekiq/web'
    require 'simple_form'
    require 'smartystreets_ruby_sdk'
    require 'strip_attributes'
    require 'text'
    require 'turbo-rails'
    require 'twilio-ruby'
    require 'wicked_pdf'
  end
end
