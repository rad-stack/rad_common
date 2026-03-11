class PushSubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def vapid_public_key
    authorize PushSubscription, :vapid_public_key?
    skip_policy_scope

    if RadConfig.browser_notifications_enabled?
      render json: { vapid_public_key: RadConfig.vapid_public_key! }
    else
      render json: { error: 'Browser notifications not configured' }, status: :not_found
    end
  end

  def create
    authorize PushSubscription

    subscription = current_user.push_subscriptions.find_or_initialize_by(endpoint: permitted_params[:endpoint])
    subscription.assign_attributes(permitted_params)

    if subscription.save
      render json: { status: 'Subscription saved successfully' }, status: :ok
    else
      render json: { error: subscription.errors.full_messages.join(', ') }, status: :unprocessable_content
    end
  end

  def destroy
    subscription = find_subscription

    if subscription.blank?
      skip_authorization
      render json: { status: 'Subscription not found' }, status: :ok
      return
    end

    authorize subscription

    subscription.destroy
    render json: { status: 'Subscription removed' }, status: :ok
  end

  private

    def find_subscription
      # Support lookup by ID (from URL) or endpoint (from params)
      if params[:id].present? && params[:id].to_s.match?(/\A\d+\z/)
        current_user.push_subscriptions.find_by(id: params[:id])
      elsif params[:endpoint].present?
        current_user.push_subscriptions.find_by(endpoint: params[:endpoint])
      end
    end

    def permitted_params
      params.require(:push_subscription).permit(:endpoint, :p256dh, :auth, :user_agent)
    end
end
