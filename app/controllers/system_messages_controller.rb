class SystemMessagesController < ApplicationController
  before_action :authenticate_user!

  authorize_actions_for Company
  authority_actions new: 'update', create: 'update'

  def new; end

  def create
    if params[:message]
      if params[:message][:message].present?
        Company.main.send_system_message(params[:message][:from], params[:message][:message])
        flash[:success] = 'The message was successfully sent.'
      else
        flash[:error] = 'Please enter a message and try again.'
      end
    else
      flash[:error] = 'Missing parameters'
    end

    redirect_to root_path
  end
end
