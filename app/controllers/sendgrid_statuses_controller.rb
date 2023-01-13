class SendgridStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    skip_authorization

    RadbearMailer.simple_message(User.active.admins.first, 'Sendgrid Status', params.to_s).deliver_later
  end
end
