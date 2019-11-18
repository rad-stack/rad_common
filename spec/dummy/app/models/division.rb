class Division < ApplicationRecord
  include FirebaseSync
  include FirebaseAction
  include Hashable

  belongs_to :owner, class_name: 'User'

  has_one_attached :logo
  has_one_attached :avatar
  has_one_attached :icon

  alias_attribute :to_s, :name
  enum division_status: %i[status_pending status_active status_inactive]

  scope :sorted, -> { order(:name) }
  scope :authorized, ->(_) {}

  audited

  def firebase_sync
    data = { name: name }

    response = RadicalRetry.perform_request { firebase_client.update(firebase_reference, data) }
    return if response.success?

    raise RadicallyIntermittentException, response.raw_body
  end

  def logo_variant
    logo.variant(resize: '290x218>').processed
  end
end
