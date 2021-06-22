module RadCommon
  module SMS
    class CommandResults
      attr_reader :sms_reply, :incoming_message, :command_matched, :reply, :data
      alias command_matched? command_matched

      def initialize(sms_reply: nil, incoming_message: nil, command_matched: true, data: {}, reply: true)
        @sms_reply = sms_reply
        @incoming_message = reply_command_message(incoming_message) if command_matched
        @incoming_message = incoming_message unless command_matched
        @command_matched = command_matched
        @reply = reply
        @data = data
      end

      private

        def reply_command_message(command)
          "Patient successfully replied with valid command #{command}"
        end
    end
  end
end
