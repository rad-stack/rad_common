module ActionDispatch
  module Routing
    class Mapper

      protected

        def devise_twilio_verify(mapping, controllers)
          get_verify_twilio_verify(mapping, controllers)
          post_verify_twilio_verify(mapping, controllers)
          match "/#{mapping.path_names[:request_sms]}", controller: controllers[:devise_twilio_verify],
                                                        action: :request_sms, as: :request_sms, via: :post
        end

        def get_verify_twilio_verify(mapping, controllers)
          match "/#{mapping.path_names[:verify_twilio_verify]}", controller: controllers[:devise_twilio_verify],
                                                                 action: :GET_verify_twilio_verify,
                                                                 as: :verify_twilio_verify, via: :get
        end

        def post_verify_twilio_verify(mapping, controllers)
          match "/#{mapping.path_names[:verify_twilio_verify]}", controller: controllers[:devise_twilio_verify],
                                                                 action: :POST_verify_twilio_verify, as: nil, via: :post
        end
    end
  end
end
