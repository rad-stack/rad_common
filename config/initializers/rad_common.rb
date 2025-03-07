require "#{Gem::Specification.find_by_name('rad_common').gem_dir}/lib/core_extensions/active_record" \
        '/base/schema_validations'

require 'httpclient'
require 'rad_config'

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'SMS'
  inflect.acronym 'PDF'
  inflect.acronym 'CRM'
  inflect.acronym 'CSV'
  inflect.acronym 'BCC'
end

ActiveRecord::Base.prepend CoreExtensions::ActiveRecord::Base::SchemaValidations

Rails.application.config.rad_common = Rails.application.config_for(:rad_common)
Rails.application.config.assets.precompile += %w[rad_common/rad_mailer.css rad_common/rad_mailer_reset.css]

RadConfig.check_validity!

Rails.application.routes.default_url_options[:host] = RadConfig.host_name!

if Rails.env.staging? || Rails.env.production?
  Rails.application.config.action_mailer.delivery_method = :smtp
  Rails.application.config.action_mailer.perform_deliveries = true
  Rails.application.config.action_mailer.default charset: 'utf-8'
  Rails.application.config.action_mailer.asset_host = "https://#{RadConfig.host_name!}"

  Rails.application.config.action_mailer.smtp_settings = {
    address: RadConfig.smtp_address!,
    port: RadConfig.smtp_port!,
    enable_starttls_auto: RadConfig.smtp_enable_starttls_auto!,
    domain: RadConfig.smtp_domain!,
    authentication: RadConfig.smtp_authentication!,
    user_name: RadConfig.smtp_username!,
    password: RadConfig.smtp_password!
  }
else
  Rails.application.config.action_mailer.asset_host = 'http://localhost:3000'
end

if Rails.env.staging?
  class ChangeStagingEmailSubject
    def self.delivering_email(mail)
      mail.subject = "[STAGING] #{mail.subject}"
    end
  end

  ActionMailer::Base.register_interceptor(ChangeStagingEmailSubject)
end

Devise.setup do |config|
  config.mailer = 'RadDeviseMailer'
end

# https://swell.radicalbear.com/tasks/37444
# https://github.com/collectiveidea/audited/issues/631
Rails.configuration.active_record.use_yaml_unsafe_load = true

Audited.current_user_method = :true_user
Audited.ignored_attributes += ['address_changes']

Rails.configuration.to_prepare do
  ActiveStorage::Attachment.audited associated_with: :record
end

AuthTrail.geocode = false

module Kaminari
  # monkey patch to fix paging on engine routes
  # https://github.com/radicalbear/rad_common/pull/211/files
  # https://github.com/kaminari/kaminari/issues/457

  module Helpers
    class Tag
      def page_url_for(page)
        (@options[:routes_proxy] || @template).url_for @params.merge(@param_name => (page <= 1 ? nil : page))
      end
    end
  end
end
