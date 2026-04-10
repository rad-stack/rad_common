module RadDeviseHigh
  extend ActiveSupport::Concern

  included do
    devise :registerable, :confirmable, :recoverable, :trackable, :lockable, :invitable, :two_factor_authenticatable,
           :timeoutable, :password_archivable, :password_expirable, :secure_validatable, :expirable
  end
end
