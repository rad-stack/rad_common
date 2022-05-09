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

        def translate_reply(sms_reply_key, params = {})
          raise 'Locale not set' if @locale.blank?

          params.merge!(locale: @locale)
          I18n.t(sms_reply_key, **params)
        end
    end
  end
end
