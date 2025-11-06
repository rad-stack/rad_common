class CustomReportFilter
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :column, :string
  attribute :type, :string
  attribute :label, :string
  attribute :default_value, :string

  attr_accessor :report_model, :joins

  validates :column, presence: true
  validates :type, presence: true
  validates :label, presence: true
  validate :validate_column_exists
  validate :validate_filter_type

  def self.model_name
    ActiveModel::Name.new(self, nil, 'CustomReportFilter')
  end

  def initialize(attributes = {})
    super
    self.joins = Array(joins).reject(&:blank?)
    self.report_model = report_model
  end

  def self.from_filter_config(filter_config, report_model:, joins: [])
    new(
      column: filter_config['column'],
      type: filter_config['type'],
      label: filter_config['label'],
      default_value: filter_config['default_value'],
      report_model: report_model,
      joins: joins
    )
  end

  def to_filter_config
    {
      'column' => column,
      'type' => type,
      'label' => label,
      'default_value' => default_value
    }
  end

  private

    def validate_column_exists
      return if column.blank? || report_model.blank?

      column_discovery = RadReports::ColumnDiscovery.new(report_model, joins || [])

      return if column_discovery.column_exists?(column)

      errors.add(:column, "contains invalid column reference '#{column}'. " \
                          "Available columns can be found using the model and joins you've specified.")
    end

    def validate_filter_type
      return if type.blank?

      return if RadReports::FilterRegistry.find(type)

      errors.add(:type, "invalid filter type '#{type}'")
    end
end
