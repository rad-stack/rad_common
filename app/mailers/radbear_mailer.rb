class RadbearMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper
  include RadCommon::ApplicationHelper

  layout 'radbear_mailer'
  before_action :set_defaults

  default from: Devise.mailer_sender
  default reply_to: Rails.application.config.app_admin_email

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

    mail(to: to_address, subject: "New User on #{I18n.t(:app_name)}")
  end

  def your_account_approved(user)
    @email_action = { button_text: 'Get Started',
                      button_url: root_url }

    @recipient = user
    @message = "Your account was approved and you can begin using #{I18n.t(:app_name)}."
    mail to: @recipient.formatted_email, subject: 'Your Account Was Approved'
  end

  def user_was_approved(recipients, user, approver)
    @email_action = { message: 'You can review this approval if desired.',
                      button_text: 'Review User',
                      button_url: user_url(user) }

    approved_by_name = (approver ? approver.to_s : 'an admin')

    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @message = "#{user} was approved by #{approved_by_name} on #{I18n.t(:app_name)}."
    mail(to: to_address, subject: "User Was Approved on #{I18n.t(:app_name)}")
  end

  def simple_message(recipient, subject, message, options = {})
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

    @message = simple_format(message)
    @email_action = options[:email_action] if options[:email_action]

    mail(to: to_address, subject: subject)
  end

  def global_validity(recipients, problems)
    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @problems = problems

    mail(to: to_address, subject: "Invalid data in #{I18n.t(:app_name)}")
  end

  def global_validity_on_demand(recipient, problems)
    @recipient = recipient
    @problems = problems

    mail to: recipient.formatted_email,
         subject: "Invalid data in #{I18n.t(:app_name)}",
         template_name: 'global_validity'
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
    @message = "Attached is the #{report_name}" + message_date_string + '.'
    attachments["#{report_name}#{attachment_date_string}.csv"] = { mime_type: 'text/csv', content: csv }

    mail to: @recipient.formatted_email, subject: "#{report_name}#{subject_date_string}"
  end

  def default_url_options
    # this won't work for links called using the route helpers outside of the mailer context
    # this won't detect when to use the portal host unless @recipient is a User

    return { host: RadCommon::AppInfo.new.portal_host_name } if @recipient.is_a?(User) && @recipient.external?

    { host: RadCommon::AppInfo.new.host_name }
  end

  private

    def set_defaults
      unless File.exist?('app/assets/images/app_logo.png') == File.exist?('public/app_logo.png')
        raise 'This mailer requires app_logo.png to be in both places.'
      end

      @include_yield = true
      @optional = false
    end

    def parse_recipients_array(recipients)
      string_emails, user_ids = recipients.partition { |email| email.to_i.zero? }
      users_emails = User.where(id: user_ids).pluck(:email)
      users_emails + string_emails
    end

    def app_name(user)
      user.internal? ? I18n.t(:app_name) : I18n.t(:portal_app_name)
    end
end
