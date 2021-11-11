class Division < ApplicationRecord
  SKIP_SCHEMA_VALIDATION_INDEXES = [:index_divisions_on_name].freeze
  include Hashable

  belongs_to :owner, class_name: 'User'

  has_one_attached :logo
  has_one_attached :avatar
  has_one_attached :icon
  has_one_attached :attachment

  alias_attribute :to_s, :name
  enum division_status: %i[status_pending status_active status_inactive]

  scope :sorted, -> { order(:name) }

  validates :name, uniqueness: { message: 'has already been taken for a pending division' }, if: -> { status_pending? }

  audited

  after_update :notify_owner

  def firebase_sync
    data = { name: name }

    response = RadicalRetry.perform_request { firebase_client.update(firebase_reference, data) }
    return if response.success?

    raise RadicallyIntermittentException, response.raw_body
  end

  def logo_variant
    logo.variant(resize: '290x218>').processed
  end

  private

  def notify_owner
    Notifications::DivisionUpdatedNotification.main.notify! self
  end
end
