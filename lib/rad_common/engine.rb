module RadCommon
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    require 'audited'
    require 'devise'
    require 'devise-authy'
    require 'devise-security'
    require 'devise_invitable'
    require 'faker'
    require 'font-awesome-rails'
    require 'haml-rails'
    require 'hashids'
    require 'kaminari'
    require 'bootstrap4-kaminari-views'
    require 'mini_racer'
    require 'momentjs-rails'
    require 'nokogiri'
    require 'pg'
    require 'premailer/rails'
    require 'pundit'
    require 'rails_email_validator'
    require 'sentry-raven'
    require 'sidekiq'
    require 'sidekiq-failures'
    require 'simple_form'
    require 'twilio-ruby'
    require 'bootstrap'
    require 'bootstrap-select-rails'
    require 'webpacker'
  end
end
