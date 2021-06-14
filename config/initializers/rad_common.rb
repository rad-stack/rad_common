require "#{Gem::Specification.find_by_name('rad_common').gem_dir}/lib/core_extensions/active_record"\
        '/base/schema_validations'

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'SMS'
  inflect.acronym 'PDF'
  inflect.acronym 'CRM'
  inflect.acronym 'CSV'
end

ActiveRecord::Base.prepend CoreExtensions::ActiveRecord::Base::SchemaValidations

Rails.application.config.rad_common = Rails.application.config_for(:rad_common)

Rails.application.config.assets.precompile += %w[rad_common/radbear_mailer.css rad_common/radbear_mailer_reset.css]

Rails.application.config.rad_common[:portal_host_name] = if !Rails.configuration.rad_common[:external_users]
                                                           Rails.configuration.rad_common[:host_name]
                                                         elsif Rails.env.production? || Rails.env.staging?
                                                           ENV['PORTAL_HOST_NAME']
                                                         else
                                                           'portal.localhost:3000'
                                                         end

Rails.application.routes.default_url_options[:host] = Rails.configuration.rad_common[:host_name]

raise 'Missing admin_email in credentials' if Rails.application.credentials.admin_email.blank?
raise 'Missing from_email in credentials' if Rails.application.credentials.from_email.blank?

if Rails.env.staging?
  class ChangeStagingEmailSubject
    def self.delivering_email(mail)
      mail.subject = "[STAGING] #{mail.subject}"
    end
  end

  ActionMailer::Base.register_interceptor(ChangeStagingEmailSubject)
end

Devise.setup do |config|
  config.mailer = 'RadbearDeviseMailer'
end

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
