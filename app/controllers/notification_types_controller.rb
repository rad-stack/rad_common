class NotificationTypesController < ApplicationController
  before_action :set_notification_type, only: %i[edit update]

  def index
    authorize NotificationType
    skip_policy_scope
    @notification_types = NotificationType.sorted
  end

  def edit; end

  def update
    type_params = params[type_param_name]
    @notification_type.active = type_params[:active]
    @notification_type.bcc_recipient = type_params[:bcc_recipient]
    @notification_type.default_email = type_params[:default_email] if type_params.key?(:default_email)
    @notification_type.default_feed = type_params[:default_feed] if type_params.key?(:default_feed)
    @notification_type.default_sms = type_params[:default_sms] if type_params.key?(:default_sms)
    @notification_type.security_roles = resolve_roles(type_params[:security_roles])

    if @notification_type.save
      redirect_to notification_types_path, notice: 'Notification Type updated.'
    else
      render :edit
    end
  end

  private

    def set_notification_type
      @notification_type = NotificationType.find(params[:id])
      authorize @notification_type
    end

    def resolve_roles(role_ids)
      if role_ids
        ids = role_ids.reject { |id| id == '' }.map(&:to_i)
        SecurityRole.where(id: ids)
      else
        []
      end
    end

    def type_param_name
      @notification_type.class.name.underscore.gsub('/', '_')
    end
end
