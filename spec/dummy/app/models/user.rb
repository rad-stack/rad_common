class User < ApplicationRecord
  devise :authy_authenticatable, :database_authenticatable, :registerable, :confirmable, :recoverable,
         :trackable, :timeoutable, :lockable, :password_archivable, :password_expirable,
         :secure_validatable, :expirable, :invitable

  include RadbearUser
  include RadAuthy
  include FirebaseSync

  validates_with TwilioPhoneValidator, fields: [{ field: :mobile_phone, type: :mobile }]

  audited except: %i[password password_confirmation encrypted_password reset_password_token confirmation_token
                     authentication_token unlock_token]
end
