class NotificationTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification_type, only: %i[edit update]

  authorize_actions_for NotificationType

  def index
    @notification_types = NotificationType.by_name
  end

  def edit; end

  def update
    @notification_type.security_roles = resolve_roles(params[:notification_type][:security_roles])

    if @notification_type.save
      flash[:success] = 'Notification Type updated.'
      redirect_to '/rad_common/notification_types'
    else
      flash[:error] = "Unable to update notification type: #{@notification_type.errors.full_messages.join(',')}"
      render :edit
    end
  end

  private

    def set_notification_type
      @notification_type = NotificationType.find(params[:id])
    end

    def resolve_roles(role_ids)
      if role_ids
        ids = role_ids.select { |id| id != '' }.map { |id| id.to_i }
        SecurityRole.where(id: ids)
      else
        []
      end
    end
end
