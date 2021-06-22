module RadCommon
  module SMS
    class BaseCommand
      include Utilities

      def initialize(incoming_message:, phone_number:, sms_users:)
        @sms_users = sms_users
        @incoming_message = incoming_message
        @phone_number = phone_number
      end

      def self.matches?(incoming_message)
        codes.include?(incoming_message)
      end

      private

      def command_name
        self.class.name.demodulize.titleize
      end
    end
  end
end
