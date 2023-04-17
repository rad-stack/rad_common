class TwilioLogsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :authenticate_user!, only: :create
  def index
    authorize TwilioLog

    @twilio_log_search = TwilioLogSearch.new(params, current_user)
    @twilio_logs = policy_scope(@twilio_log_search.results).page(params[:page])
  end

  def create
    skip_authorization

    TwilioLog.create! to_number: params['To'],
                      from_number: params['From'],
                      to_user: nil,
                      from_user_id: nil,
                      message: params['Body'],
                      media_url: nil,
                      message_sid: params['SmsMessageSid']
  end
end
