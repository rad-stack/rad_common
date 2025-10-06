module RadDeviseLow
  extend ActiveSupport::Concern

  included do
    devise :registerable, :confirmable, :recoverable, :trackable, :lockable, :invitable, :two_factor_authenticatable,
           :validatable, :rememberable
  end
end
