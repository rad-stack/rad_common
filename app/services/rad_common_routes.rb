module RadCommonRoutes
  def self.extended(router)
    router.instance_exec do
      devise_controllers = { confirmations: 'users/confirmations',
                             devise_twilio_verify: 'users/devise_twilio_verify',
                             invitations: 'users/invitations' }

      devise_paths = { verify_twilio_verify: '/verify-token',
                       enable_twilio_verify: '/enable-two-factor',
                       verify_twilio_verify_installation: '/verify-installation' }

      devise_for :users, path: 'auth', controllers: devise_controllers, path_names: devise_paths

      authenticate :user, ->(u) { u.internal? } do
        resources :users do
          get :export, on: :collection

          member do
            put :resend_invitation
            put :confirm
            put :reactivate
            put :test_email
            put :test_sms
            put :update_timezone
            put :ignore_timezone
          end

          resources :user_clients, only: :new
        end

        resources :security_roles do
          get :permission, on: :collection
        end

        resources :user_security_roles, only: :show
        resources :user_clients, only: %i[create destroy]
      end

      authenticate :user, ->(u) { u.admin? } do
        mount Sidekiq::Web => '/sidekiq'
      end

      resources :users, only: [] do
        member do
          get :setup_totp
          put :register_totp
        end
      end

      resources :user_profiles, only: %i[show edit update] if RadConfig.user_profiles?

      get 'contact_us', to: 'pages#contact_us'
      get 'terms', to: 'pages#terms'
      get 'privacy', to: 'pages#privacy'

      root to: 'pages#home'
    end
  end
end
