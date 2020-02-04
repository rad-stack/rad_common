module RadCommon
  require 'raven'

  class SentryRemoveParameters < Raven::Processor
    def process(data)
      process_if_symbol_keys(data) if data[:request]
      process_if_string_keys(data) if data['request']

      data
    end

    private

      def process_if_symbol_keys(data)
        data[:request][:data] = STRING_MASK if data[:request][:data].present?
      end

      def process_if_string_keys(data)
        data['request']['data'] = STRING_MASK if data['request']['data'].present?
      end
  end
end
