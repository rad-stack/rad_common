module RadClient
  extend ActiveSupport::Concern

  included do
    has_many :user_clients, foreign_key: :client_id, dependent: :destroy
    has_many :users, through: :user_clients

    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
  end
end
