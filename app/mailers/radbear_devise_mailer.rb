class RadbearDeviseMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  helper RadCommon::ApplicationHelper

  layout 'radbear_mailer'

  before_action :set_defaults
  default reply_to: Rails.application.config.app_admin_email

  def confirmation_instructions(record, token, opts = {})
    @token = token
    initialize_from_record(record)

    @recipient = @resource
    @message = I18n.t('rad_common.confirmation_instructions', default: 'Here are your confirmation instructions.')

    @email_action = { message: 'You can confirm your account email through this link.',
                      button_text: 'Confirm My Account',
                      button_url: confirmation_url(@resource, confirmation_token: @token) }

    super
  end

  def reset_password_instructions(record, token, opts = {})
    @token = token
    initialize_from_record(record)

    @recipient = @resource
    @message = "Someone has requested a link to change your password. If you didn't request this, please ignore this email."

    @email_action = { message: "Your password won't change until you click this link and create a new one.",
                      button_text: 'Change My Password',
                      button_url: edit_password_url(@resource, reset_password_token: @token) }

    super
  end

  def unlock_instructions(record, token, opts = {})
    @token = token
    initialize_from_record(record)

    @recipient = @resource
    @message = 'Your account has been locked due to an excessive number of unsuccessful sign in attempts.'

    @email_action = { message: 'Click the link to unlock your account.',
                      button_text: 'Unlock My Account',
                      button_url: unlock_url(@resource, unlock_token: @token) }

    super
  end

  def invitation_instructions(record, token, opts = {})
    @token = token
    initialize_from_record(record)

    @recipient = @resource
    @message = "Someone has invited you to #{app_name}, you can accept it through the link below. If you don't want to accept the invitation, please ignore this email. Your account won't be created until you access the link and set your password."

    @email_action = { message: 'Click the link to accept the invitation.',
                      button_text: 'Accept',
                      button_url: accept_invitation_url(@resource, invitation_token: @token) }

    super
  end

  private

    def app_name
      return t(:app_name) unless company_exists?
      Company.main.respond_to?(:app_name) ? Company.main.app_name : t(:app_name)
    end

    def company_exists?
      ActiveRecord::Base.connection.data_source_exists?('companies') && Company.respond_to?(:main) && Company.main
    end

    def set_defaults
      unless File.exist?('app/assets/images/app_logo.png') == File.exist?('public/app_logo.png')
        raise 'This mailer requires app_logo.png to be in both places.'
      end

      @company = Company.main if Company.respond_to?(:main)

      @include_yield = false
      @optional = false
      @require_company = false
    end
end
