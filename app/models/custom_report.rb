class CustomReport < ApplicationRecord
  alias_attribute :to_s, :name

  store_accessor :configuration, :columns, :filters, :sort_columns, :joins

  scope :by_name, -> { order(:name) }

  before_validation :set_configuration_defaults

  validates :name, presence: true, uniqueness: true
  validates :report_model, presence: true
  validates :configuration, presence: true

  validate :columns_presence

  audited
  strip_attributes

  private

    def set_configuration_defaults
      self.user_id ||= 1
      self.configuration ||= {}
      self.columns ||= []
      self.filters ||= []
      self.sort_columns ||= []
      self.joins ||= []
    end

    def columns_presence
      errors.add(:columns, 'must have at least one column') if columns.blank? || columns.empty?
    end
end
