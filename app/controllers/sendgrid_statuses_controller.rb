class SendgridStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    skip_authorization

    Notifications::SendgridEmailNotification.main.notify! payload
  end

  private

    def payload
      sendgrid_alert_info.slice(payload_keys)
    end

    def sendgrid_alert_info
      raise "unexpected format: #{params}" unless params['_json'].size == 1

      params['_json'].first
    end

    def payload_keys
      # TODO: remove unused keys
      %w[email event bounce_classification sg_event_id sg_message_id type reason]
    end
end
