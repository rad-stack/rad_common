class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize Notification
    @notifications = policy_scope(Notification).recent_first
  end
end
