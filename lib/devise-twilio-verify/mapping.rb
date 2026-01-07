module DeviseTwilioVerify
  module Mapping
    private
      def default_controllers(options)
        options[:controllers] ||= {}
        options[:controllers][:passwords] ||= "devise_twilio_verify/passwords"
        super
      end

      def default_path_names(options)
        options[:path_names] ||= {}
        options[:path_names][:request_sms] ||= 'request-sms'
        super
      end
  end
end

