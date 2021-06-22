module RadCommon
  module SMS
    class IncomingProcessor
      attr_reader :matched_processor

      include Utilities

      COMMAND_PROCESSORS = [OptOut, OptIn].freeze

      def initialize(params)
        @incoming_message = params[:Body]
        @phone_number = Utilities.format_twilio_number(params[:From])
        @command_results = nil
        @sms_reply = nil
        @reply_command = cleanup_command(@incoming_message)
        @matched_processor = nil
      end

      def process
        @command_results = process_sms
        @sms_reply = @command_results.sms_reply
        return unless @command_results.reply

        after_process
      end

      private

        def process_sms
          @matched_processor = command_processors.find { |processor| processor.matches?(@reply_command) }
          if @matched_processor
            processor = @matched_processor.new(incoming_message: @reply_command, phone_number: @phone_number, sms_users: sms_users)
            return processor.process
          end

          CommandResults.new(command_matched: false, incoming_message: @incoming_message)
        end

        def sms_users
          @sms_users ||= []
        end

        def command_processors
          COMMAND_PROCESSORS
        end

        def after_process
          send_reply
        end
    end
  end
end
