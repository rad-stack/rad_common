module LLM
  module Tools
    class ToolList
      def self.tools
        [
          AttorneyDataTool,
          ListAvailableModels,
          ListModelColumns,
          ListModelAssociations,
          ListAvailableFilters,
          ListAvailableFormulas,
          GenerateReportConfiguration
        ]
      end

      def self.chat_list
        { basic: LLM::ChatTypes::AttorneyChat, report_builder: LLM::ChatTypes::ReportBuilderChat }
      end

      def self.default_chat_type
        'basic'
      end
    end
  end
end
