class CustomReport < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :report_model, presence: true
  validates :configuration, presence: true

  scope :active, -> { where(active: true) }
  scope :by_name, -> { order(:name) }

  alias_attribute :to_s, :name

  store_accessor :configuration, :columns, :filters, :sort_columns, :joins

  before_validation :set_configuration_defaults

  validate :columns_presence

  private

    def set_configuration_defaults
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
