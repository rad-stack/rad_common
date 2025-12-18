class Division < ApplicationRecord
  include Hashable
  include CreatedBy

  TAG_OPTIONS = %w[Finance Marketing Sales HR IT Operations Support R&D].freeze

  schema_validation_options do
    index :index_divisions_on_name, skip: true
  end

  belongs_to :owner, class_name: 'User'
  belongs_to :category, optional: true

  has_one_attached :logo
  has_one_attached :icon

  alias_attribute :to_s, :name
  enum :division_status, %i[status_pending status_active status_inactive]

  scope :sorted, -> { order(:name) }

  before_validation :sanitize_tags

  validates :name, uniqueness: { message: 'has already been taken for a pending division' }, if: -> { status_pending? }
  validates :logo, content_type: { in: RadCommon::VALID_IMAGE_TYPES, message: RadCommon::VALID_CONTENT_TYPE_MESSAGE }

  validates :icon,
            size: { less_than: 50.kilobytes, message: 'must be less than 50 KB' },
            content_type: { in: RadCommon::VALID_IMAGE_TYPES,
                            message: RadCommon::VALID_CONTENT_TYPE_MESSAGE }

  validates_with EmailAddressValidator, fields: [:invoice_email]
  validates_with InternalUserValidator, fields: [:owner]

  strip_attributes
  audited

  after_commit :notify_owner
  after_create_commit lambda {
    return if seeding

    broadcast_prepend_to 'divisions_calendar',
                         target: 'recent-divisions',
                         partial: 'divisions/division',
                         locals: { division: self }
    broadcast_update_to 'divisions_calendar',
                        target: 'divisions_calendar_frame',
                        partial: 'divisions/calendar_frame'
  }
  after_destroy_commit lambda {
    return if seeding

    broadcast_remove_to 'divisions_calendar', target: ApplicationController.helpers.dom_id(self)
    broadcast_update_to 'divisions_calendar',
                        target: 'divisions_calendar_frame',
                        partial: 'divisions/calendar_frame'
  }

  def logo_variant
    logo.variant(resize_to_limit: [290, 218])
  end

  private

    def notify_owner
      Notifications::DivisionUpdatedNotification.main(self).notify!
    end

    def sanitize_tags
      self.tags = tags.map(&:strip).compact_blank if tags.present?
    end
end
