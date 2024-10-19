module RadContactMailer
  extend ActiveSupport::Concern

  included do
    before_action :start_contact_log
    after_action :finish_contact_log
  end

  private

    def start_contact_log
      @rad_contact_log = ContactLog.create!(service_type: :email)
    end

    def finish_contact_log
      @rad_contact_log.update! from_email: mail.from.first,
                               content: mail.subject,
                               record: @rad_record,
                               from_user: @rad_from_user,
                               sent: true

      mail.to.each do |recipient|
        add_rad_recipient recipient, :to
      end

      if mail.cc.present?
        mail.cc.each do |recipient|
          add_rad_recipient recipient, :cc
        end
      end

      return if mail.bcc.blank?

      mail.bcc.each do |recipient|
        add_rad_recipient recipient, :bcc
      end
    end

    def add_rad_recipient(recipient, type)
      ContactLogRecipient.create! contact_log: @rad_contact_log,
                                  email: recipient,
                                  email_type: type,
                                  email_status: :delivered,
                                  notify_on_fail: @rad_notify_on_fail.nil? ? true : @rad_notify_on_fail
    end

    def rad_headers
      headers['X-SMTPAPI'] = { unique_args: { host_name: RadConfig.host_name!,
                                              contact_log_id: @rad_contact_log.id } }.to_json
    end
end
