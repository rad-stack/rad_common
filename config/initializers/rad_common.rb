require "#{Gem::Specification.find_by_name('rad_common').gem_dir}/lib/core_extensions/active_record/base/schema_validations"

ActiveRecord::Base.prepend CoreExtensions::ActiveRecord::Base::SchemaValidations

if ENV.fetch('STAGING') == 'true'
  class ChangeStagingEmailSubject
    def self.delivering_email(mail)
      mail.subject = '[STAGING] ' + mail.subject
    end
  end

  ActionMailer::Base.register_interceptor(ChangeStagingEmailSubject)
end

Rails.application.config.assets.precompile += %w[rad_common/radbear_mailer.css rad_common/radbear_mailer_reset.css]

Devise.setup do |config|
  config.mailer = 'RadbearDeviseMailer'
end

Rails.configuration.to_prepare do
  ActiveStorage::Attachment.audited associated_with: :record
end
