class RadMailer < ActionMailer::Base
  include RadContactMailer
  include ActionView::Helpers::TextHelper
  include RadCommon::ApplicationHelper

  EXPORT_FORMATS = { csv: 'text/csv', pdf: 'application/pdf' }.freeze

  layout 'rad_mailer'
  before_action :set_defaults

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
    @rad_record = options[:record]
    @rad_from_user = options[:from_user]
    recipient = User.find(recipient.first) if recipient.is_a?(Array) && recipient.count == 1

    if recipient.respond_to?(:email)
      @recipient = recipient
      to_address = "\"#{escape_name(recipient.to_s)}\" <#{recipient.email}>"
    elsif recipient.is_a?(String)
      if recipient.match?(/(.*)<(.*)>/)
        name, email = recipient.match(/(.*)<(.*)>/).captures
        to_address = "\"#{escape_name(name.strip)}\" <#{email.strip}>"
      else
        to_address = recipient
      end
      @recipient = recipient
    elsif recipient.is_a?(Array)
      @recipient = parse_recipients_array(recipient)
      to_address = @recipient.map { |r| "\"#{escape_name(r.to_s)}\" <#{r.email}>" }
    else
      raise "recipient of type #{recipient.class} is not valid"
    end

    @message = options[:do_not_format] ? message : simple_format(message)
    @email_action = options[:email_action] if options[:email_action]

    maybe_attach options

    mail to: to_address,
        subject: subject,
        cc: options[:cc],
        bcc: options[:bcc],
        template_path: 'rad_mailer',
        template_name: 'simple_message'
  end

  def global_validity_on_demand(recipient, problems)
    @recipient = recipient
    @rad_from_user = recipient
    @problems = problems
    @message = "There #{@problems.count == 1 ? 'is' : 'are'} #{pluralize(@problems.count, 'invalid record')}."

    mail to: recipient.formatted_email,
         subject: "Invalid data in #{RadConfig.app_name!}",
         template_path: 'notification_mailer',
         template_name: 'global_validity'
  end

  def email_report(user, file, report_name, options = {})
    @rad_from_user = user
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
      rad_headers
    end

    def parse_recipients_array(recipients)
      string_emails, user_ids = recipients.partition { |email| email.to_i.zero? }
      users_emails = User.where(id: user_ids).pluck(:email)
      users_emails + string_emails
    end

    def maybe_attach(options)
      return if options[:attachment].blank?

      attachment = options[:attachment]
      if attachment[:record].present?
        attach_from_record(attachment)
      elsif attachment[:raw_file].present?
        attach_raw_file(attachment)
      else
        raise 'attachment must include record or raw_file'
      end
    end

    def attach_from_record(attachment)
      record_attachment = attachment[:record].send(attachment[:method])
      return unless record_attachment.attached?

      attachments[record_attachment.filename.to_s] = {
        mime_type: record_attachment.content_type,
        content: record_attachment.blob.download
      }
    end

    def attach_raw_file(attachment)
      attachments[attachment[:filename]] = {
        mime_type: attachment[:content_type],
        content: attachment[:raw_file]
      }
    end

    def escape_name(recipient_name)
      recipient_name.gsub(/[<>]/, '').gsub(',', ' ').strip
    end
end
