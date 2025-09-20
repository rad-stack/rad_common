class Attorney < ApplicationRecord
  include Contactable
  include DuplicateFixable
  include Embeddable

  has_rich_text :notes

  scope :sorted, -> { order(:first_name, :last_name) }

  scope :created_between, lambda { |start_date, end_date|
    where('created_at >= ? and created_at <= ?', start_date, end_date)
  }

  scope :with_cities, ->(cities) { where(city: cities) }
  scope :without_cities, ->(cities) { where.not(city: cities) }

  validates_with PhoneNumberValidator, fields: [{ field: :mobile_phone, type: :mobile }, { field: :phone_number }]
  validates_with EmailAddressValidator, fields: [:email]

  strip_attributes
  audited

  def to_s
    the_name = "#{last_name}, #{first_name}"
    the_name = "#{the_name} #{middle_name}" if middle_name.present?
    the_name
  end

  def update_embedding!
    content = generate_embedding_content

    embedding_vector = EmbeddingService.generate(content)
    return unless embedding_vector

    embedding_record = embedding || build_embedding
    embedding_record.update! embedding: embedding_vector, metadata: embedding_metadata
  end

  private

    def embedding_metadata
      { attorney_id: id }
    end

    def generate_embedding_content
      [first_name, last_name].compact.join("\n")
    end
end
