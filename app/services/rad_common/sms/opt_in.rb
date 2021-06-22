module RadCommon
  module SMS
    class OptIn < BaseCommand
      def initialize(incoming_message:, phone_number:, sms_users:)
        super(incoming_message: incoming_message, phone_number: phone_number, sms_users: sms_users)
      end

      def process
        patients = Patient.where(phone_number: @phone_number)
                          .where('communication_method_id != ? OR communication_method_id is null',
                                 communication_method.id)

        patients.each do |patient|
          patient.update! communication_method_id: communication_method.id
          patient.patient_notes.create! note: 'A patient opted IN to text messages from mobile phone '\
                                            "number #{@phone_number} with command #{@incoming_message}."
        end

        CommandResults.new(sms_reply: translate_reply(:communication_sms_opt_in),
                           incoming_message: @incoming_message)
      end

      def self.codes
        ['START']
      end
    end
  end
end
