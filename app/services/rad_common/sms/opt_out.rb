module RadCommon
  module SMS
    class OptOut < BaseCommand
      def initialize(incoming_message:, phone_number:, sms_users:, locale:)
        super(incoming_message: incoming_message, phone_number: phone_number, sms_users: sms_users, locale: locale)
      end

      def process
        @sms_users.each { |user| user.sms_opt_out(@incoming_message) }
        CommandResults.new(reply: false)
      end

      def self.codes
        ['STOP', 'STOPALL', 'STOP ALL', 'UNSUBSCRIBE', 'CANCEL', 'END', 'QUIT']
      end
    end
  end
end
