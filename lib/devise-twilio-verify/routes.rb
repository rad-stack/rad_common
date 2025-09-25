module ActionDispatch
  module Routing
    class Mapper
      protected

        def devise_twilio_verify(mapping, controllers)
          match "/#{mapping.path_names[:verify_twilio_verify]}", controller: controllers[:devise_twilio_verify],
                                                                 action: :GET_verify_twilio_verify,
                                                                 as: :verify_twilio_verify, via: :get
          match "/#{mapping.path_names[:verify_twilio_verify]}", controller: controllers[:devise_twilio_verify],
                                                                 action: :POST_verify_twilio_verify, as: nil, via: :post

          match "/#{mapping.path_names[:enable_twilio_verify]}", controller: controllers[:devise_twilio_verify],
                                                                 action: :GET_enable_twilio_verify,
                                                                 as: :enable_twilio_verify, via: :get
          match "/#{mapping.path_names[:enable_twilio_verify]}", controller: controllers[:devise_twilio_verify],
                                                                 action: :POST_enable_twilio_verify,
                                                                 as: nil, via: :post

          match "/#{mapping.path_names[:disable_twilio_verify]}", controller: controllers[:devise_twilio_verify],
                                                                  action: :POST_disable_twilio_verify,
                                                                  as: :disable_twilio_verify, via: :post

          match "/#{mapping.path_names[:verify_twilio_verify_installation]}",
                controller: controllers[:devise_twilio_verify], action: :GET_verify_twilio_verify_installation,
                as: :verify_twilio_verify_installation, via: :get
          match "/#{mapping.path_names[:verify_twilio_verify_installation]}",
                controller: controllers[:devise_twilio_verify], action: :POST_verify_twilio_verify_installation,
                as: nil, via: :post

          match "/#{mapping.path_names[:request_sms]}", controller: controllers[:devise_twilio_verify],
                                                        action: :request_sms, as: :request_sms, via: :post
        end
    end
  end
end
