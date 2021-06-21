module RadCommon
  module Sms
    class CommandResults
      attr_reader :sms_reply, :incoming_message, :command_matched, :reply, :data
      alias command_matched? command_matched

      def initialize(sms_reply: nil, incoming_message: nil, command_matched: true, data: true, reply: true)
        @sms_reply = sms_reply
        @incoming_message = incoming_message if command_matched
        @incoming_message = incoming_message unless command_matched
        @command_matched = command_matched
        @reply = reply
        @data = data
      end
    end
  end
end
