class CustomReport < ApplicationRecord
  alias_attribute :to_s, :name

  store_accessor :configuration, :columns, :filters, :sort_columns, :joins

  scope :by_name, -> { order(:name) }

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
      self.sort_columns ||= []
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
      valid_columns = column_discovery.all_columns

      columns.each do |column_config|
        column_name = column_config['name']
        select_clause = column_config['select']

        next if column_name.blank? && select_clause.blank?

        if select_clause.present?
          table_or_association, col_name = select_clause.split('.', 2)

          matching_column = valid_columns.find do |vc|
            vc[:name] == col_name &&
              (vc[:association] == table_or_association || vc[:table] == table_or_association)
          end

          errors.add(:columns, "contains invalid column reference '#{select_clause}'") unless matching_column
        elsif column_name.present?
          unless valid_columns.any? { |vc| vc[:name] == column_name && vc[:association].nil? }
            errors.add(:columns, "contains invalid column '#{column_name}'")
          end
        end
      end
    end

    def validate_filters_configuration
      return if report_model.blank? || filters.blank?

      column_discovery = RadReports::ColumnDiscovery.new(report_model, joins || [])
      valid_columns = column_discovery.all_columns

      filters.each do |filter_config|
        column_path = filter_config['column']
        next if column_path.blank?

        table_or_association, col_name = column_path.split('.', 2)

        matching_column = valid_columns.find do |vc|
          vc[:name] == col_name &&
            (vc[:association] == table_or_association ||
             (vc[:association].nil? && vc[:table] == table_or_association))
        end

        unless matching_column
          errors.add(:filters, "contains invalid column reference '#{column_path}'. " \
                               "Available columns can be found using the model and joins you've specified.")
        end
      end
    end
end
