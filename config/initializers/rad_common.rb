if ENV.fetch('STAGING') == 'true'
  class ChangeStagingEmailSubject
    def self.delivering_email(mail)
      mail.subject = '[STAGING] ' + mail.subject
    end
  end

  ActionMailer::Base.register_interceptor(ChangeStagingEmailSubject)
end
