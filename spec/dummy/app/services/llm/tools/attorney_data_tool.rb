module LLM
  module Tools
    class AttorneyDataTool < Base
      TOOL_DESCRIPTION = <<~EXAMPLES.freeze
        This tool is designed to provide basic data about attorneys.
        It provides the contact information for attorneys.
      EXAMPLES

      include RadHelper
      def call
        Attorney.all.as_json.to_s
      end

      def description
        TOOL_DESCRIPTION
      end
    end
  end
end
