module RadCustomer
  extend ActiveSupport::Concern

  included do
    has_many :user_customers, foreign_key: :customer_id, dependent: :restrict_with_error
    has_many :users, through: :user_customers
  end
end
