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
