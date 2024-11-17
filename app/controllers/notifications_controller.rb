class NotificationsController < ApplicationController
  def index
    authorize Notification

    @notification_search = NotificationSearch.new(params, current_user)
    @notifications = policy_scope(@notification_search.results).page(params[:page])
  end
end
