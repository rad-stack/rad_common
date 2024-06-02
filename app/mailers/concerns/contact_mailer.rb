module ContactMailer
  extend ActiveSupport::Concern

  included do
    before_action :start_contact_log
    after_action :finish_contact_log
  end

  private

    def start_contact_log
      # TODO: is there a better way to handle this content required field?
      @contact_log_id = ContactLog.create!(content: 'n/a', service_type: :email, sms_sent: false).id
    end

    def finish_contact_log
      log = ContactLog.find(@contact_log_id)
      log.update! from_email: mail.from.first, content: mail.subject, record: @contact_log_record, from_user: @from_user

      mail.to.each do |recipient|
        ContactLogRecipient.create! contact_log: log, email: recipient, email_type: :to, email_status: :delivered
      end

      if mail.cc.present?
        mail.cc.each do |recipient|
          ContactLogRecipient.create! contact_log: log, email: recipient, email_type: :cc, email_status: :delivered
        end
      end

      return if mail.bcc.blank?

      mail.bcc.each do |recipient|
        ContactLogRecipient.create! contact_log: log, email: recipient, email_type: :bcc, email_status: :delivered
      end
    end

    def rad_headers
      headers['X-SMTPAPI'] = { unique_args: { host_name: RadConfig.host_name!,
                                              contact_log_id: @contact_log_id } }.to_json
    end
end
