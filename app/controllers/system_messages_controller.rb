class SystemMessagesController < ApplicationController
  before_action :authenticate_user!

  authorize_actions_for Company
  authority_actions new: 'update', create: 'update'

  def new
    @super = params[:super].present? && params[:super] == 'true'
  end

  def create
    if params[:message] && params[:super]
      if params[:message][:message].present?
        if params[:super] == 'false'
          current_member.company.send_system_message(params[:message][:from], params[:message][:message])
        else
          raise 'Invalid parameters' unless current_member.user.super_admin
          Company.send_system_message_global(params[:message][:from], params[:message][:message])
        end

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
