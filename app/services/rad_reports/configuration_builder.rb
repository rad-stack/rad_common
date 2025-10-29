module RadReports
  class ConfigurationBuilder
    def self.build(params)
      new(params).build
    end

    def self.sanitize_joins(joins)
      return [] unless joins

      Array(joins).reject(&:blank?)
    end

    def initialize(params)
      @params = params
    end

    def build
      configuration = {}
      configuration['columns'] = build_columns if @params[:columns]
      configuration['filters'] = build_filters if @params[:filters]
      configuration['joins'] = self.class.sanitize_joins(@params[:joins]) if @params[:joins]
      configuration
    end

    private

      def build_columns
        extract_config_array(@params[:columns], parse_formula: true, normalize_sortable: true)
      end

      def build_filters
        extract_config_array(@params[:filters])
      end

      def extract_config_array(params, parse_formula: false, normalize_sortable: false)
        return [] unless params

        items = params.is_a?(Array) ? params : params.values
        items.map { |param| process_config_item(param, parse_formula, normalize_sortable) }
      end

      def process_config_item(param, parse_formula, normalize_sortable)
        param_hash = param.to_h
        param_hash = parse_formula_if_needed(param_hash, parse_formula)
        normalize_sortable_if_needed(param_hash, normalize_sortable)
      end

      def parse_formula_if_needed(param_hash, parse_formula)
        return param_hash unless parse_formula && param_hash['formula'].is_a?(String)

        begin
          param_hash['formula'] = JSON.parse(param_hash['formula'])
        rescue JSON::ParserError
        end

        param_hash
      end

      def normalize_sortable_if_needed(params, normalize_sortable)
        return params unless normalize_sortable && params.key?('sortable')

        params['sortable'] = normalize_boolean(params['sortable'])
        params['is_calculated'] = normalize_boolean(params['is_calculated']) if params.key?('is_calculated')
        params
      end

      def normalize_boolean(value)
        [true, 'true', '1', 1].include?(value)
      end
  end
end
