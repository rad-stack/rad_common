class PushSubscriptionsController < ApplicationController
  def vapid_public_key
    authorize PushSubscription, :vapid_public_key?
    skip_policy_scope

    render json: { vapid_public_key: RadConfig.vapid_public_key! }
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

  def unsubscribe
    subscription = current_user.push_subscriptions.find_by(endpoint: params[:endpoint])

    if subscription.blank?
      skip_authorization
    else
      authorize subscription
      subscription.destroy
    end

    render json: { status: 'Subscription removed' }, status: :ok
  end

  private

    def permitted_params
      params.require(:push_subscription).permit(:endpoint, :p256dh, :auth, :user_agent)
    end
end
