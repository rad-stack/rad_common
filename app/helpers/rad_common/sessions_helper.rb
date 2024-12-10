module RadCommon
  module SessionsHelper
    DEVELOPMENT_DEFAULT_EMAIL = 'admin@example.com'.freeze
    DEVELOPMENT_DEFAULT_PASSWORD = 'password'.freeze

    def email_input_defaults(params)
      input_defaults = { autocomplete: 'email' }
      return input_defaults unless Rails.env.development?

      input_defaults.merge({ value: params.dig(:user, :email).presence || DEVELOPMENT_DEFAULT_EMAIL })
    end

    def password_input_defaults(params)
      input_defaults = { autocomplete: 'current-password' }
      return input_defaults unless Rails.env.development?

      input_defaults.merge({ value: params.dig(:user, :password).presence || DEVELOPMENT_DEFAULT_PASSWORD })
    end

    def remember_me_input_defaults
      { checked: Rails.env.development? }
    end
  end
end
