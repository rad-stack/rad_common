# frozen_string_literal: true

# Register chat types after all initializers have run to ensure inflections are loaded
Rails.application.config.after_initialize do
  # Automatically register all chat types from app/services/llm/chat_types
  chat_types_path = Rails.root.join('app', 'services', 'llm', 'chat_types')

  if Dir.exist?(chat_types_path)
    Dir.glob(chat_types_path.join('*.rb')).each do |file|
      filename = File.basename(file, '.rb')

      # Skip base_chat as it's the parent class
      next if filename == 'base_chat'

      class_name = filename.camelize

      begin
        chat_class = "LLM::ChatTypes::#{class_name}".constantize
        RadAssistant.register(chat_class)
      rescue NameError => e
        Rails.logger.warn("Could not register chat type: #{class_name} - #{e.message}")
      end
    end
  end

  # Applications can register their own custom chat types in their own initializer:
  # RadAssistant.register(YourCustom::ChatType)
end
