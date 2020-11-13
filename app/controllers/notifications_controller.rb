class NotificationsController < ApplicationController
  def index
    authorize Notification
    @notifications = policy_scope(Notification).recent_first.page(params[:page])
  end
end
