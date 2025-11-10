module LLM
  module Tools
    class ListAvailableModels < Base
      def description
        'Lists all available models that can be used as the base for a custom report'
      end

      def call
        "Available models for custom reports:\n" \
          "#{RadReports::ModelDiscovery.available_model_names.map { |m| "- #{m}" }.join("\n")}"
      end
    end
  end
end
