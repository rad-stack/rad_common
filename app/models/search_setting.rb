class SearchSetting < ApplicationRecord
  belongs_to :user

  has_many :saved_search_filters, dependent: :destroy

  before_validation :compact_columns

  def show_column?(column_name)
    columns.empty? || columns.include?(column_name.to_s)
  end

  private

    def compact_columns
      self.columns = columns.compact_blank
    end
end
