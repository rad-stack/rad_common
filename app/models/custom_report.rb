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

      validated_joins = []

      joins.each do |join_path|
        if validate_join_path_incrementally(join_path, validated_joins)
          validated_joins << join_path
        else
          errors.add(:joins, "contains invalid association '#{join_path}'")
        end
      end
    end

    def validate_join_path_incrementally(join_path, existing_validated_joins)
      parts = join_path.split('.')

      (1..parts.length).each do |depth|
        current_path = parts[0, depth].join('.')
        next if existing_validated_joins.include?(current_path)

        context_joins = existing_validated_joins.dup

        (1...depth).each do |i|
          intermediate_path = parts[0, i].join('.')
          context_joins << intermediate_path unless context_joins.include?(intermediate_path)
        end

        discovery = RadReports::AssociationDiscovery.new(report_model, context_joins.uniq)
        available_paths = discovery.available_associations.map { |a| a[:name] }

        return false unless available_paths.include?(current_path)
      end

      true
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
          unless column_discovery.column_exists?(select_clause)
            errors.add(:columns,
                       "contains invalid column reference '#{select_clause}'")
          end
        elsif column_name.present?
          unless column_discovery.column_exists?(column_name)
            errors.add(:columns,
                       "contains invalid column '#{column_name}'")
          end
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
