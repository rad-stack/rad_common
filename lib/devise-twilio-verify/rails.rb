module DeviseTwilioVerify
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:action_controller) do
      include DeviseTwilioVerify::Controllers::Helpers
    end
    ActiveSupport.on_load(:action_view) do
      include DeviseTwilioVerify::Views::Helpers
    end

    # extend mapping with after_initialize because it's not reloaded
    config.after_initialize do
      Devise::Mapping.send :prepend, DeviseTwilioVerify::Mapping
    end
  end
end

