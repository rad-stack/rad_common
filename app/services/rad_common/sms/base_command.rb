module RadCommon
  module SMS
    class BaseCommand
      include Utilities
      include PatientUtilities
      include OrderUtilities

      def initialize(incoming_message:, phone_number:)
        @incoming_message = incoming_message
        @phone_number = phone_number
      end

      def self.matches?(incoming_message)
        codes.include?(incoming_message)
      end

      private

      def communication_method
        CommunicationMethod.method_sms
      end

      def command_name
        self.class.name.demodulize.titleize
      end
    end
  end
end
