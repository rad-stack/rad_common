class Division < ApplicationRecord
  include Hashable
  include CreatedBy
  include Embeddable

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

  def logo_variant
    logo.variant(resize_to_limit: [290, 218])
  end

  def update_embedding!
    content = generate_embedding_content

    embedding_vector = EmbeddingService.generate(content)
    return unless embedding_vector

    embedding_record = embedding || build_embedding
    embedding_record.update! embedding: embedding_vector, metadata: embedding_metadata
  end

  private

    def notify_owner
      Notifications::DivisionUpdatedNotification.main(self).notify!
    end

    def sanitize_tags
      self.tags = tags.map(&:strip).compact_blank if tags.present?
    end

    def embedding_metadata
      { division_id: id }
    end

    def generate_embedding_content
      [name, code].compact.join("\n")
    end
end
