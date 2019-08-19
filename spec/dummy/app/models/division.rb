class Division < ApplicationRecord
  include Authority::Abilities
  include FirebaseSync
  include FirebaseAction

  belongs_to :owner, class_name: 'User'

  has_one_attached :logo
  has_one_attached :avatar
  has_one_attached :icon

  alias_attribute :to_s, :name
  enum division_status: %i[status_pending status_active status_inactive]

  scope :authorized, ->(_) {}

  audited

  def firebase_sync
    data = { name: name }

    response = RadicalRetry.perform_request { firebase_client.update(firebase_reference, data) }
    return if response.success?

    raise RadicallyIntermittentException, response.raw_body
  end
end
