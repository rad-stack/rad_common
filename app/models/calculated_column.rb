class CalculatedColumn
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name
  attribute :label
  attribute :formula_type

  attr_accessor :formula_params, :report_model, :joins

  validates :label, presence: true
  validates :formula_type, presence: true
  validate :validate_formula

  def self.model_name
    ActiveModel::Name.new(self, nil, 'CalculatedColumn')
  end

  def initialize(attributes = {})
    super

    self.formula_params = normalize_raw_params(formula_params || {})
    self.label = label.to_s.strip if label.present?
    self.name = (name.presence || label).to_s.parameterize(separator: '_')
    self.joins = Array(joins).reject(&:blank?)
    self.report_model = report_model.presence

    @normalized_params = nil
  end

  def formula_definition
    RadReports::FormulaRegistry.find(formula_type)
  end

  def calculated_formula?
    formula_definition&.fetch(:is_calculated, false)
  end

  def normalized_params
    @normalized_params ||= build_normalized_params
  end

  def to_column_config
    {
      'name' => name,
      'label' => label,
      'is_calculated' => true,
      'formula' => [
        { 'type' => formula_type, 'params' => normalized_params }
      ]
    }
  end

  def self.from_column_config(column_config, report_model:, joins: [])
    formula_entry = Array(column_config['formula']).first || {}

    new(
      name: column_config['name'],
      label: column_config['label'],
      formula_type: formula_entry['type'],
      formula_params: formula_entry['params'] || {},
      report_model: report_model,
      joins: joins
    )
  end

  def param_value(param)
    key = param[:name].to_s
    value = formula_params[key]
    return param[:default] if value.nil?

    param[:type] == 'column_selector' ? Array(value) : value
  end

  private

    def normalize_raw_params(raw)
      return {} if raw.blank?
      return raw if raw.is_a?(Hash)

      raw.to_h.transform_keys(&:to_s)
    end

    def normalize_param_value(param, raw_value)
      case param[:type]
      when 'column_selector'
        Array(raw_value).reject(&:blank?)
      when 'number'
        raw_value.presence
      else
        raw_value.is_a?(String) ? raw_value.strip : raw_value
      end
    end

    def build_normalized_params
      params_hash = {}
      definition = formula_definition
      return params_hash unless definition

      definition[:params]&.each do |param|
        key = param[:name].to_s
        raw_value = formula_params[key]
        raw_value = param[:default] if raw_value.nil?

        value = normalize_param_value(param, raw_value)
        params_hash[key] = value if include_param_value?(value, param)
      end
      params_hash
    end

    def include_param_value?(value, param)
      return value.present? unless param[:type] == 'column_selector'

      value.present?
    end

    def validate_formula
      definition = formula_definition
      unless definition
        errors.add(:formula_type, 'is invalid')
        return
      end

      errors.add(:formula_type, 'must be a calculated formula') unless calculated_formula?

      definition[:params]&.each do |param|
        value = normalized_params[param[:name].to_s]
        next unless %w[column_selector number].include?(param[:type])

        errors.add(:base, "#{param[:label]} must be provided") if value.blank?
      end

      validate_column_types if definition[:allowed_column_types].present?

      return if definition[:validator].blank?

      definition[:validator].call(normalized_params, errors)
    end

    def validate_column_types
      definition = formula_definition
      return unless definition
      return if report_model.blank? || normalized_params['columns'].blank?

      allowed_types = definition[:allowed_column_types]
      return if allowed_types == :all

      discovery = RadReports::ColumnDiscovery.new(report_model, joins)
      selected_columns = Array(normalized_params['columns'])

      selected_columns.each do |column_path|
        column_info = discovery.find_column_by_path(column_path)
        next unless column_info

        column_type = column_info[:type].to_s
        next if allowed_types.include?(column_type)

        errors.add(:base,
                   "Column '#{column_path}' has type '#{column_type}' which is not valid for this formula. Allowed types: #{allowed_types.join(', ')}")
      end
    end
end
