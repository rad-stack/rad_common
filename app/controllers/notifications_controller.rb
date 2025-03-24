class NotificationsController < ApplicationController
  def index
    authorize Notification

    @notification_search = NotificationSearch.new(params, current_user)
    @notifications = policy_scope(@notification_search.results).page(params[:page])
  end

  def update
    notification = current_user.notifications.find(params[:id])
    authorize notification

    notification = current_user.notifications.find(params[:id])
    snooze_until = params[:notification][:snooze_until]

    if notification.update(unread: false, snooze_until: snooze_until)
      redirect_to notifications_path, notice: 'Notification marked as read.'
    else
      redirect_to notifications_path, alert: 'Failed to mark notification as read.'
    end
  end

  def mark_all_read
    authorize Notification, :index?

    current_user.read_notifications!
    redirect_to notifications_path, notice: 'All notifications marked as read.'
  end
end
