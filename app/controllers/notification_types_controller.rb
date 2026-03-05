class NotificationTypesController < ApplicationController
  before_action :set_notification_type, only: %i[edit update]

  def index
    authorize NotificationType
    skip_policy_scope
    @notification_types = NotificationType.sorted
  end

  def edit; end

  def update
    apply_to_all = ActiveModel::Type::Boolean.new.cast(permitted_params[:apply_to_all_settings])
    @notification_type.assign_attributes(permitted_params.except(:apply_to_all_settings))
    @notification_type.security_roles = resolve_roles(params[type_param_name][:security_roles])

    if @notification_type.save
      apply_defaults_to_settings if apply_to_all
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

    def permitted_params
      params.require(type_param_name).permit(:active, :bcc_recipient, :default_email, :default_feed, :default_sms,
                                             :apply_to_all_settings)
    end

    def resolve_roles(role_ids)
      if role_ids
        ids = role_ids.reject { |id| id == '' }.map(&:to_i)
        SecurityRole.where(id: ids)
      else
        []
      end
    end

    def apply_defaults_to_settings
      @notification_type.notification_settings.update!(email: @notification_type.default_email,
                                                       feed: @notification_type.default_feed,
                                                       sms: @notification_type.default_sms)
    end

    def type_param_name
      @notification_type.class.name.underscore.gsub('/', '_')
    end
end
