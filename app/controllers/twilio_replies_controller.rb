class TwilioRepliesController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    skip_authorization
    TwilioReply.new(params)
    head :ok, content_type: 'text/html'
  end
end
