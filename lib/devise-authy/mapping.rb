module DeviseAuthy
  module Mapping
    private
    def default_controllers(options)
      options[:controllers] ||= {}
      options[:controllers][:passwords] ||= "devise_authy/passwords"
      super
    end

    def default_path_names(options)
      options[:path_names] ||= {}
      options[:path_names][:request_sms] ||= 'request-sms'
      options[:path_names][:request_phone_call] ||= 'request-phone-call'
      super
    end
  end
end
