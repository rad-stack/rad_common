class TwilioRepliesController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    skip_authorization

    twilio_reply = TwilioReply.new(params)

    if twilio_reply.valid?
      head :ok, content_type: 'text/html'
    else
      head :bad_request
    end
  end
end
