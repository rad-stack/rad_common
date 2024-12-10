module RadCommon
  module SMS
    class OptIn < BaseCommand
      def initialize(incoming_message:, phone_number:, sms_users:, locale:)
        super(incoming_message: incoming_message, phone_number: phone_number, sms_users: sms_users, locale: locale)
      end

      def process
        @sms_users.each { |user| user.sms_opt_in(@incoming_message) }

        CommandResults.new(sms_reply: translate_reply(:communication_sms_opt_in),
                           incoming_message: @incoming_message)
      end

      def self.codes
        ['START', 'UNSTOP']
      end
    end
  end
end
