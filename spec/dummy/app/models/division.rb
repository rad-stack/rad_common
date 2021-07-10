class Division < ApplicationRecord
  SKIP_SCHEMA_VALIDATION_INDEXES = [:index_divisions_on_name].freeze
  include Hashable

  belongs_to :owner, class_name: 'User'

  has_one_attached :logo
  has_one_attached :icon

  alias_attribute :to_s, :name
  enum division_status: %i[status_pending status_active status_inactive]

  scope :sorted, -> { order(:name) }

  validates :name, uniqueness: { message: 'has already been taken for a pending division' }, if: -> { status_pending? }

  validates :icon,
            size: { less_than: 50.kilobytes, message: 'must be less than 50 KB' },
            content_type: { in: %w[image/png image/jpg],
                            message: 'has an invalid content type of %<content_type>s, must be %<authorized_types>s' }

  validates_with EmailAddressValidator, fields: %i[invoice_email]

  strip_attributes
  audited

  after_update :notify_owner

  def logo_variant
    logo.variant(resize: '290x218>')
  end

  private

    def notify_owner
      Notifications::DivisionUpdatedNotification.main.notify! self
    end
end
