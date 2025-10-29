class CustomReport < ApplicationRecord
  alias_attribute :to_s, :name

  store_accessor :configuration, :columns, :filters, :joins

  scope :by_name, -> { order(:name) }

  after_initialize :set_configuration_defaults
  before_validation :set_configuration_defaults

  validates :name, presence: true, uniqueness: true
  validates :report_model, presence: true
  validates :configuration, presence: true

  validate :columns_presence
  validate :validate_report_model
  validate :validate_joins_configuration
  validate :validate_columns_configuration
  validate :validate_filters_configuration

  audited
  strip_attributes

  private

    def set_configuration_defaults
      self.configuration ||= {}
      self.columns ||= []
      self.filters ||= []
      self.filters.reject! { |f| f['column'].blank? }
      self.joins ||= []
      self.joins.compact_blank!
    end

    def columns_presence
      errors.add(:columns, 'must have at least one column') if columns.blank? || columns.empty?
    end

    def validate_report_model
      return if report_model.blank? || RadReports::ModelDiscovery.model_available?(report_model)

      errors.add(:report_model, 'is not an allowed model for custom reports')
    end

    def validate_joins_configuration
      return if report_model.blank? || joins.blank?

      available_associations = RadReports::AssociationDiscovery.new(report_model, []).available_associations
      available_join_paths = available_associations.pluck(:name)

      valid_paths = []

      joins.each do |join_path|
        parts = join_path.split('.')
        base_join = parts.first

        unless available_join_paths.include?(base_join) || valid_paths.include?(base_join)
          errors.add(:joins, "contains invalid association '#{join_path}'")
          next
        end

        valid_paths << join_path
        next unless parts.length > 1

        nested_available = RadReports::AssociationDiscovery.new(report_model, valid_paths[0..-2])
                                                           .available_associations
        nested_paths = nested_available.map { |a| a[:name] }

        errors.add(:joins, "contains invalid nested association '#{join_path}'") unless nested_paths.include?(join_path)
      end
    end

    def validate_columns_configuration
      return if report_model.blank? || columns.blank?

      column_discovery = RadReports::ColumnDiscovery.new(report_model, joins || [])

      columns.each do |column_config|
        column_name = column_config['name']
        select_clause = column_config['select']
        is_calculated = column_config['is_calculated']

        next if !is_calculated && column_name.blank? && select_clause.blank?

        if is_calculated
          calculated_column = CalculatedColumn.from_column_config(
            column_config,
            report_model: report_model,
            joins: joins || []
          )

          unless calculated_column.valid?
            identifier = calculated_column.label.presence || calculated_column.name.presence || 'calculated column'
            calculated_column.errors.full_messages.each do |message|
              errors.add(:columns, "calculated column '#{identifier}': #{message}")
            end
          end
          next
        end

        if select_clause.present?
          errors.add(:columns, "contains invalid column reference '#{select_clause}'") unless column_discovery.column_exists?(select_clause)
        elsif column_name.present?
          errors.add(:columns, "contains invalid column '#{column_name}'") unless column_discovery.column_exists?(column_name)
        end
      end
    end

    def validate_filters_configuration
      return if report_model.blank? || filters.blank?

      filters.each do |filter_config|
        filter_obj = CustomReportFilter.from_filter_config(
          filter_config,
          report_model: report_model,
          joins: joins || []
        )

        next if filter_obj.valid?

        identifier = filter_obj.label.presence || filter_obj.column
        filter_obj.errors.full_messages.each do |message|
          errors.add(:filters, "filter '#{identifier}': #{message}")
        end
      end
    end
end
