module RadDeviseHigh
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :registerable, :confirmable, :recoverable, :trackable, :lockable, :invitable,
           :twilio_verify_authenticatable, :timeoutable, :password_archivable, :password_expirable, :secure_validatable,
           :expirable
  end
end
