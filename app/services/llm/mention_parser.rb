module LLM
  class MentionParser
    # Matches @[Type:ID:Label] format
    # Example: @[User:123:John Smith]
    MENTION_PATTERN = /@\[(\w+):(\d+):([^\]]+)\]/

    attr_reader :message, :mentions

    def initialize(message)
      @message = message
      @mentions = []
    end

    def parse
      @mentions = []
      message.scan(MENTION_PATTERN) do |type, id, label|
        @mentions << {
          type: type,
          id: id.to_i,
          label: label,
          full_match: "@[#{type}:#{id}:#{label}]"
        }
      end
      @mentions
    end

    def mentions?
      parse if @mentions.empty? && message.present?
      @mentions.any?
    end

    def expand_mentions
      return [] unless mentions?

      @mentions.filter_map { |mention| find_record(mention)&.to_llm_context }
    end

    def build_context_string
      contexts = expand_mentions
      return nil if contexts.empty?

      contexts.map { |ctx|
        "#{ctx[:type]} (ID: #{ctx[:id]}): #{ctx[:data].to_json}"
      }.join("\n")
    end

    def message_for_display
      return message unless mentions?

      result = message.dup
      @mentions.each do |mention|
        result.gsub!(mention[:full_match], "@#{mention[:label]}")
      end
      result
    end

    private

      def find_record(mention)
        klass = mention[:type].safe_constantize
        return nil unless klass&.include?(LLMMentionable)

        klass.find_by(id: mention[:id])
      rescue StandardError
        nil
      end
  end
end
