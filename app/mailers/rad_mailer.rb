class RadMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper
  include RadCommon::ApplicationHelper

  EXPORT_FORMATS = { csv: 'text/csv', pdf: 'application/pdf' }.freeze

  layout 'rad_mailer'
  before_action :set_defaults
  after_action :create_contact_log

  default from: RadConfig.from_email!
  default reply_to: RadConfig.admin_email!

  def your_account_approved(user)
    @email_action = { button_text: 'Get Started',
                      button_url: root_url }

    @recipient = user
    @message = "Your account was approved and you can begin using #{RadConfig.app_name!}."
    mail to: @recipient.formatted_email, subject: 'Your Account Was Approved'
  end

  def simple_message(recipient, subject, message, options = {})
    recipient = User.find(recipient.first) if recipient.is_a?(Array) && recipient.count == 1

    if recipient.respond_to?(:email)
      @recipient = recipient
      to_address = "#{escape_name(recipient.to_s)} <#{recipient.email}>"
    elsif recipient.is_a?(String)
      @recipient = recipient
      to_address = recipient
    elsif recipient.is_a?(Array)
      @recipient = parse_recipients_array(recipient)
      to_address = @recipient
    else
      raise "recipient of type #{recipient.class} if not valid"
    end

    @message = options[:do_not_format] ? message : simple_format(message)
    @email_action = options[:email_action] if options[:email_action]
    enable_settings_link if options[:notification_settings_link]

    maybe_attach options

    mail(to: to_address, subject: subject, cc: options[:cc], bcc: options[:bcc])
  end

  def global_validity_on_demand(recipient, problems)
    @recipient = recipient
    @problems = problems
    @message = "There #{@problems.count == 1 ? 'is' : 'are'} #{pluralize(@problems.count, 'invalid record')}."

    mail to: recipient.formatted_email,
         subject: "Invalid data in #{RadConfig.app_name!}",
         template_path: 'notification_mailer',
         template_name: 'global_validity'
  end

  def email_report(user, file, report_name, options = {})
    start_date = options[:start_date]
    end_date   = options[:end_date]
    export_format = options[:format].presence || Exporter::DEFAULT_FORMAT

    message_date_string = ''
    message_date_string += " for #{format_datetime(start_date, include_zone: true)}" if start_date.present?
    message_date_string += " to #{format_datetime(end_date, include_zone: true)}" if end_date.present?

    attachment_date_string = ''
    attachment_date_string += "_#{start_date.strftime('%Y%m%d')}" if start_date.present?
    attachment_date_string += "-#{end_date.strftime('%Y%m%d')}" if end_date.present?

    subject_date_string = ''
    subject_date_string += " for #{start_date.strftime('%m/%d/%Y')}" if start_date.present?
    subject_date_string += " - #{end_date.strftime('%m/%d/%Y')}" if end_date.present?

    @recipient = user
    @message = "Attached is the #{report_name}#{message_date_string}."
    filename = "#{report_name}#{attachment_date_string}.#{export_format}"
    attachments[filename] = { mime_type: EXPORT_FORMATS[export_format], content: file }

    mail to: @recipient.formatted_email, subject: "#{report_name}#{subject_date_string}"
  end

  def default_url_options
    # this won't work for links called using the route helpers outside of the mailer context
    { host: RadConfig.host_name! }
  end

  private

    def set_defaults
      @include_yield = true
      headers['X-SMTPAPI'] = { unique_args: { host_name: RadConfig.host_name! } }.to_json
    end

    def parse_recipients_array(recipients)
      string_emails, user_ids = recipients.partition { |email| email.to_i.zero? }
      users_emails = User.where(id: user_ids).pluck(:email)
      users_emails + string_emails
    end

    def maybe_attach(options)
      return if options[:attachment].blank?

      attachment = options[:attachment][:record].send(options[:attachment][:method])
      return unless attachment.attached?

      attachments[attachment.filename.to_s] = { mime_type: attachment.content_type, content: attachment.blob.download }
    end

    def escape_name(recipient_name)
      recipient_name.gsub(',', ' ')
    end

    def enable_settings_link
      @notification_settings_link = true
    end

    def create_contact_log
      ContactLog.create!(
        from_email: mail.from.first,
        reply_to: mail.reply_to.first,
        subject: mail.subject,
        message: @message, # What to store here if anything? could be html template
        log_type: :outgoing,
        service_type: :sendgrid
      ).tap do |log|
        create_contact_log_attachments(log) # Do we want to store all of these?
        create_contact_log_recipients(log)
      end
    end

    def create_contact_log_attachments(log)
      mail.attachments.each do |attachment|
        file = StringIO.new(Base64.decode64(attachment.body.decoded))
        log.contact_log_attachments.create!(attachment: { io: file, filename: attachment.filename })
      end
    end

    def create_contact_log_recipients(log)
      mail.to.each do |recipient|
        ContactLogRecipient.create!(contact_log: log, email: recipient, email_type: :to, service_status: :delivered)
      end

      if mail.cc.present?
        mail.cc.each do |recipient|
          ContactLogRecipient.create!(contact_log: log, email: recipient, email_type: :cc, service_status: :delivered)
        end
      end

      return if mail.bcc.blank?

      mail.bcc.each do |recipient|
        ContactLogRecipient.create!(contact_log: log, email: recipient, email_type: :bcc, service_status: :delivered)
      end
    end
end
