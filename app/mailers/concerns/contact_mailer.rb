module ContactMailer
  extend ActiveSupport::Concern

  included do
    after_action :create_contact_log
  end

  private

    def create_contact_log
      ContactLog.create!(
        from_email: mail.from.first,
        content: mail.subject,
        service_type: :email,
        sms_sent: false,
        record: @contact_log_record,
        from_user: @from_user
      ).tap do |log|
        create_contact_log_recipients(log)
      end
    end

    def create_contact_log_recipients(log)
      mail.to.each { |recipient| ContactLogRecipient.create!(contact_log: log, email: recipient, email_type: :to) }

      if mail.cc.present?
        mail.cc.each { |recipient| ContactLogRecipient.create!(contact_log: log, email: recipient, email_type: :cc) }
      end

      return if mail.bcc.blank?

      mail.bcc.each { |recipient| ContactLogRecipient.create!(contact_log: log, email: recipient, email_type: :bcc) }
    end
end
