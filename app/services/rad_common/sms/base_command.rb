module RadCommon
  module SMS
    class BaseCommand
      def initialize(incoming_message:, phone_number:, sms_users:, locale:)
        @sms_users = sms_users
        @incoming_message = incoming_message
        @phone_number = phone_number
        @locale = locale
      end

      def self.matches?(incoming_message)
        codes.include?(incoming_message)
      end

      private

        def command_name
          self.class.name.demodulize.titleize
        end

        def translate_reply(sms_reply_key)
          raise 'Locale not set' if @locale.blank?

          I18n.t(sms_reply_key, locale: @locale)
        end
    end
  end
end
