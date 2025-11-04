# frozen_string_literal: true

# Register chat types after all initializers have run to ensure inflections are loaded
Rails.application.config.to_prepare do
  # Collect paths to check for chat types
  paths_to_check = []

  # Add gem's chat types path
  gem_path = Gem.loaded_specs['rad_common']&.full_gem_path
  paths_to_check << File.join(gem_path, 'app/services/llm/chat_types') if gem_path

  # Add host application's chat types path
  paths_to_check << Rails.root.join('app/services/llm/chat_types').to_s

  paths_to_check.each do |chat_types_path|
    next unless Dir.exist?(chat_types_path)

    Dir.glob(File.join(chat_types_path, '*.rb')).each do |file|
      filename = File.basename(file, '.rb')

      # Skip base_chat as it's the parent class
      next if filename == 'base_chat'

      class_name = filename.camelize

      begin
        chat_class = "LLM::ChatTypes::#{class_name}".constantize
        RadAssistant.register_chat_type(chat_class)
      rescue NameError => e
        Rails.logger.warn("Could not register chat type: #{class_name} - #{e.message}")
      end
    end
  end

  RadConfig.rad_assistant_system_tools!.each do |tool|
    RadAssistant.register_system_tool(tool.constantize)
  end

  # Applications can register their own custom chat types in their own initializer:
  # RadAssistant.register(YourCustom::ChatType)
end
