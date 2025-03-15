class TwilioRepliesController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    skip_authorization

    twilio_reply = TwilioReply.new(params)

    # curious what might occur here, can handle more gracefully when/if we receive some errors
    raise "bad request: #{params}" unless twilio_reply.valid?

    twilio_reply.process!
    head :ok, content_type: 'text/html'
  end
end
