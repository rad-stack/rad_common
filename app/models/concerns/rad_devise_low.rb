module RadDeviseLow
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :registerable, :confirmable, :recoverable, :trackable, :lockable, :invitable,
           :twilio_verify_authenticatable, :validatable, :rememberable, :omniauthable,
           omniauth_providers: [:google_oauth2]
  end
end
