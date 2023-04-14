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

    # TwilioLog.create! to_number: to_number,
    #                   from_number: from_number,
    #                   to_user: to_user,
    #                   from_user_id: from_user_id,
    #                   message: message,
    #                   media_url: media_url,
    #                   sent: sent,
    #                   message_sid: message_sid,
    #                   opt_out_message_sent: opt_out_message_sent
  end
end
