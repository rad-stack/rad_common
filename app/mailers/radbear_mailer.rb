class RadbearMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper
  include RadCommon::ApplicationHelper

  layout 'radbear_mailer'
  before_action :set_defaults

  default from: RadicalConfig.from_email!
  default reply_to: RadicalConfig.admin_email!

  def new_user_signed_up(recipients, user)
    auto_approve = user.auto_approve?

    action_message = 'Review their user registration information'
    action_message += auto_approve ? ' if desired.' : ' and approve them if desired.'

    @email_action = { message: action_message,
                      button_text: auto_approve ? 'Review' : 'Review & Approve',
                      button_url: edit_user_url(user) }

    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @message = "#{user} has signed up on #{app_name(user)}"
    @message += auto_approve ? '.' : ' and is awaiting approval.'

    mail(to: to_address, subject: "New User on #{app_name(user)}")
  end

  def your_account_approved(user)
    @email_action = { button_text: 'Get Started',
                      button_url: root_url }

    @recipient = user
    @message = "Your account was approved and you can begin using #{RadicalConfig.app_name!}."
    mail to: @recipient.formatted_email, subject: 'Your Account Was Approved'
  end

  def user_was_approved(recipients, user_and_approver)
    user = user_and_approver.first
    approver = user_and_approver.last

    @email_action = { message: 'You can review this approval if desired.',
                      button_text: 'Review User',
                      button_url: user_url(user) }

    approved_by_name = (approver ? approver.to_s : 'an admin')

    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @message = "#{user} was approved by #{approved_by_name} on #{RadicalConfig.app_name!}."
    mail(to: to_address, subject: "User Was Approved on #{RadicalConfig.app_name!}")
  end

  def simple_message(recipient, subject, message, options = {})
    recipient = User.find(recipient.first) if recipient.is_a?(Array) && recipient.count == 1

    if recipient.respond_to?(:email)
      @recipient = recipient
      to_address = "#{recipient} <#{recipient.email}>"
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

    maybe_attach options

    mail(to: to_address, subject: subject)
  end

  def global_validity(recipients, problems)
    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @problems = problems
    @message = "There #{@problems.count == 1 ? 'is' : 'are'} #{pluralize(@problems.count, 'invalid record')}."

    mail(to: to_address, subject: "Invalid data in #{RadicalConfig.app_name!}")
  end

  def global_validity_on_demand(recipient, problems)
    @recipient = recipient
    @problems = problems
    @message = "There #{@problems.count == 1 ? 'is' : 'are'} #{pluralize(@problems.count, 'invalid record')}."

    mail to: recipient.formatted_email,
         subject: "Invalid data in #{RadicalConfig.app_name!}",
         template_name: 'global_validity'
  end

  def global_validity_ran_long(recipients, run_stats)
    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @run_stats = run_stats
    total_time = Time.at((@run_stats.sum { |item| item[:run_seconds] })).utc.strftime('%H:%M:%S')
    @message = "The Global Validity task took #{total_time} to complete, which is beyond the configured timeout."

    mail(to: to_address, subject: "Global Validity in #{RadicalConfig.app_name!} Ran Long")
  end

  def email_report(user, csv, report_name, options = {})
    start_date = options[:start_date]
    end_date   = options[:end_date]

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
    attachments["#{report_name}#{attachment_date_string}.csv"] = { mime_type: 'text/csv', content: csv }

    mail to: @recipient.formatted_email, subject: "#{report_name}#{subject_date_string}"
  end

  def default_url_options
    # this won't work for links called using the route helpers outside of the mailer context
    # this won't detect when to use the portal host unless @recipient is a User

    return { host: RadicalConfig.portal_host_name! } if @recipient.is_a?(User) && @recipient.external?

    { host: RadicalConfig.host_name! }
  end

  private

    def set_defaults
      unless File.exist?('app/assets/images/app_logo.png') == File.exist?('public/app_logo.png')
        raise 'This mailer requires app_logo.png to be in both places.'
      end

      @include_yield = true
    end

    def parse_recipients_array(recipients)
      string_emails, user_ids = recipients.partition { |email| email.to_i.zero? }
      users_emails = User.where(id: user_ids).pluck(:email)
      users_emails + string_emails
    end

    def maybe_attach(options)
      return unless options[:attachment].present?

      attachment = options[:attachment][:record].send(options[:attachment][:method])
      return unless attachment.attached?

      attachments[attachment.filename.to_s] = { mime_type: attachment.content_type, content: attachment.blob.download }
    end

    def app_name(user)
      user.internal? ? RadicalConfig.app_name! : RadicalConfig.portal_app_name!
    end
end
