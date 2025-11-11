class SearchPreference < ApplicationRecord
  belongs_to :user

  schema_validation_options do
    column :search_filters, skip: true
  end

  enum :toggle_behavior, {
    remember_state: 0,
    always_open: 1,
    always_closed: 2
  }

  scope :sorted, -> { order(:search_class) }

  validates :search_class, presence: true, uniqueness: { scope: :user_id }

  strip_attributes
  audited associated_with: :user

  alias_attribute :to_s, :search_class

  def set_defaults(sticky_filters:)
    return if persisted?

    self.toggle_behavior ||= RadConfig.filter_toggle_default_behavior!
    self.sticky_filters = sticky_filters.nil? ? false : sticky_filters
  end
end
