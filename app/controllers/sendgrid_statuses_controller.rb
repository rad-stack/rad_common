class SendgridStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    skip_authorization

    receiver = SendgridStatusReceiver.new(params['_json'])

    if receiver.valid?
      receiver.process!
      head :ok
    else
      render json: { message: 'These are not the droids you are looking for.' }, status: :unprocessable_entity
    end
  end
end
