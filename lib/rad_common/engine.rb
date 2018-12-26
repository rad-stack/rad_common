module RadCommon
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    require 'audited'
    require 'authority'
    require 'devise'
    require 'devise-authy'
    require 'faker'
    require 'font-awesome-rails'
    require 'haml-rails'
    require 'kaminari-bootstrap'
    require 'momentjs-rails'
    require 'nokogiri'
    require 'paperclip'
    require 'pg'
    require 'premailer/rails'
    require 'rad_common/global_validity'
    require 'schema_validations'
    require 'sidekiq'
    require 'simple_form'
    require 'twitter-bootstrap-rails'
  end
end
