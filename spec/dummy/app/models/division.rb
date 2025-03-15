class Division < ApplicationRecord
  SKIP_SCHEMA_VALIDATION_INDEXES = [:index_divisions_on_name].freeze
  include Hashable

  belongs_to :owner, class_name: 'User'
  belongs_to :category, optional: true

  attr_accessor :category_name

  has_one_attached :logo
  has_one_attached :icon

  alias_attribute :to_s, :name
  enum division_status: %i[status_pending status_active status_inactive]

  scope :sorted, -> { order(:name) }

  validates :name, uniqueness: { message: 'has already been taken for a pending division' }, if: -> { status_pending? }
  validates :logo, content_type: { in: RadCommon::VALID_IMAGE_TYPES, message: RadCommon::VALID_CONTENT_TYPE_MESSAGE }

  validates :icon,
            size: { less_than: 50.kilobytes, message: 'must be less than 50 KB' },
            content_type: { in: RadCommon::VALID_IMAGE_TYPES,
                            message: RadCommon::VALID_CONTENT_TYPE_MESSAGE }

  validates_with EmailAddressValidator, fields: [:invoice_email]
  validates_with InternalUserValidator, fields: [:owner]

  before_validation :set_category

  strip_attributes
  audited

  after_update :notify_owner

  def logo_variant
    logo.variant(resize: '290x218>')
  end

  private

    def notify_owner
      Notifications::DivisionUpdatedNotification.main(self).notify!
    end

    def set_category
      return if category.present? || category_name.blank?

      self.category = Category.find_or_create_by!(name: category_name.strip)
    end
end
