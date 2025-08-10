module RadDeviseMedium
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :registerable, :confirmable, :recoverable, :trackable, :lockable, :invitable,
           :twilio_verify_authenticatable, :rememberable, :password_archivable, :password_expirable,
           :secure_validatable, :expirable, :omniauthable, omniauth_providers: [:google_oauth2]
  end
end
