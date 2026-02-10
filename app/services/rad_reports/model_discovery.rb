module RadReports
  class ModelDiscovery
    DEFAULT_EXCLUDED_MODELS = %w[
      AssistantSession
      ContactLog
      ContactLogRecipient
      CustomReport
      Duplicate
      Embedding
      LoginActivity
      Notification
      NotificationSecurityRole
      NotificationSetting
      NotificationType
      OldPassword
      SavedSearchFilter
      SecurityRole
      SystemMessage
      UserSecurityRole
    ].freeze

    class << self
      def available_models
        # TODO: Confirm this is the best way, maybe should be handled in an initializer and cached?
        Rails.application.eager_load! unless Rails.application.config.eager_load

        ApplicationRecord.descendants.filter_map { |model|
          next if should_exclude_model?(model)

          [model.model_name.human, model.name]
        }.sort_by(&:first)
      end

      def available_model_names
        available_models.map(&:last)
      end

      def model_available?(model_class_or_name)
        model_name = model_class_or_name.is_a?(String) ? model_class_or_name : model_class_or_name.name
        available_model_names.include?(model_name)
      end

      private

        def should_exclude_model?(model)
          return true if model.abstract_class?
          return true if model.name.blank?
          return true if model.name.include?('::') && !model.name.start_with?('ActiveStorage::', 'ActionText::')
          return true if model.name.start_with?('ActiveStorage::', 'ActionText::', 'Audited::')
          return true if excluded_models.include?(model.name)
          return true if DEFAULT_EXCLUDED_MODELS.include?(model.name)

          false
        end

        def excluded_models
          @excluded_models ||= begin
            config = RadConfig.custom_reports_config || {}
            Array(config[:excluded_models]).map(&:to_s)
          end
        end
    end
  end
end
