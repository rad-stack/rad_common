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
      configuration['sort_columns'] = build_sort_columns if @params[:sort_columns]
      configuration['joins'] = self.class.sanitize_joins(@params[:joins]) if @params[:joins]
      configuration
    end

    private

      def build_columns
        extract_config_array(@params[:columns], parse_formula: true)
      end

      def build_filters
        extract_config_array(@params[:filters])
      end

      def build_sort_columns
        extract_config_array(@params[:sort_columns])
      end

      def extract_config_array(params, parse_formula: false)
        return [] unless params

        items = params.is_a?(Array) ? params : params.values

        items.map do |param|
          if parse_formula && param[:formula].present? && param[:formula].is_a?(String)
            begin
              parsed_formula = JSON.parse(param[:formula])
              param_hash = param.to_h
              param_hash['formula'] = parsed_formula
              param_hash
            rescue JSON::ParserError
              param.to_h
            end
          else
            param.to_h
          end
        end
      end
  end
end
