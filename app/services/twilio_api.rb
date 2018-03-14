class TwilioApi
  attr_reader :user, :attributes, :new_twilio_user

  def initialize(user, attributes)
    @user, @attributes = user, attributes
  end

  def update_user
    if register_user.ok?
      delete_old_user
      user.update!(authy_id: new_twilio_user.id)
      true
    else
      false
    end
  end

  def delete_old_user
    Authy::API.delete_user({ id: user.authy_id })
    user.update!(authy_id: nil)
  end

  def register_user
    @new_twilio_user ||= Authy::API.register_user(user_attributes_hash)
  end

  def user_attributes_hash
    {
      email: attributes[:email] || user.email,
      country_code: '1',
      cellphone: attributes[:mobile_phone] || user.mobile_phone
    }
  end
end
