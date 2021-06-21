module ReplyCommands
  module Sms
    class OptOut < BaseCommand
      def initialize(incoming_message:, phone_number:)
        super(incoming_message: incoming_message, phone_number: phone_number)
      end

      def process
        patients = Patient.where(phone_number: @phone_number, communication_method_id: communication_method.id)
        patients.each { |patient| patient.sms_opt_out(@incoming_message) }
        CommandResults.new(reply: false)
      end

      def self.codes
        ['STOP', 'STOPALL', 'STOP ALL', 'UNSUBSCRIBE', 'CANCEL', 'END', 'QUIT']
      end
    end
  end
end
