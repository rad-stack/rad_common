class NotificationTypesController < ApplicationController
  before_action :authenticate_user!

  authorize_actions_for NotificationType

  def index
    @notification_types = NotificationType.by_name
  end

  def show
    @notification_type = NotificationType.find(params[:id])
  end
end
