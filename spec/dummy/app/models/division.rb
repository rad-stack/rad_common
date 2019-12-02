class Division < ApplicationRecord
  SKIP_SCHEMA_VALIDATION_INDEXES = [:index_divisions_on_name].freeze
  include FirebaseSync
  include FirebaseAction
  include Hashable

  belongs_to :owner, class_name: 'User'

  has_one_attached :logo
  has_one_attached :avatar
  has_one_attached :icon
  has_one_attached :attachment

  alias_attribute :to_s, :name
  enum division_status: %i[status_pending status_active status_inactive]

  scope :authorized, lambda { |user| where(owner_id: user.id) unless user.admin? }
  scope :sorted, -> { order(:name) }

  validates :name, uniqueness: true, if: -> { status_pending? }

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
