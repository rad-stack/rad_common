module LLM
  module Tools
    class ListAvailableModels < Base
      def description
        'Lists all available models that can be used as the base for a custom report'
      end

      def call
        models = RadReports::ModelDiscovery.available_model_names
        models_list = models.map { |m| "- #{m}" }.join("\n")

        "Available models for custom reports:\n#{models_list}"
      end
    end
  end
end
