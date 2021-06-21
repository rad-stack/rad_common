module RadCommon
  module Sms
    class IncomingProcessor
      include Utilities

      COMMAND_PROCESSORS = [OptOut, OptIn].freeze

      def initialize(params)
        @incoming_message = params[:Body]
        @phone_number = format_twilio_number(params[:From])
        @command_results = nil
        @sms_reply = nil
      end

      def process
        @command_results = process_sms
        @sms_reply = @command_results.sms_reply
        return unless @command_results.reply

        send_reply
      end

      private

      def process_sms
        matched_processor = COMMAND_PROCESSORS.find { |processor| processor.matches?(@incoming_message) }
        if matched_processor
          processor = matched_processor.new(incoming_message: @incoming_message, phone_number: @phone_number)
          return processor.process
        end

        CommandResults.new(command_matched: false, incoming_message: @incoming_message)
      end

      def send_reply

      end
    end
  end
end
