class Users::RegistrationsController < Devise::RegistrationsController
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    copied_params = account_update_params.dup
    copied_params.delete('current_password')
    copied_params.delete('password')
    copied_params.delete('password_confirmation')
    resource.assign_attributes(copied_params)

    if twilio_needs_update?
      if update_twilio
        super
      else
        flash[:alert] = 'Your account update failed. Please try again later.'
        render :edit
      end
    else
      super
    end
  end

  private

  def twilio_needs_update?
    resource.valid? && (mobile_phone_changed? || mobile_phone_removed?)
  end

  def mobile_phone_changed?
    resource.mobile_phone.present? && resource.mobile_phone_changed?
  end

  def mobile_phone_removed?
    resource.mobile_phone.blank? && resource.authy_id.present?
  end

  def update_twilio
    twilio = TwilioApi.new(resource, account_update_params)
    return twilio.update_user if mobile_phone_changed?
    twilio.delete_old_user if mobile_phone_removed?
  end
end
