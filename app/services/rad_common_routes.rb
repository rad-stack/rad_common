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
          end

          resources :user_clients, only: :new
        end

        resources :security_roles do
          get :permission, on: :collection
        end

        resources :duplicates, only: [] do
          collection do
            get :resolve
            get :not
            put :do_later
            put :reset
            put :switch
            patch :merge
            post :check_duplicate
          end
        end

        resources :contact_logs, only: %i[index show]
        resources :saved_search_filters, only: :destroy
        resources :user_security_roles, only: :show
        resources :user_clients, only: %i[create destroy]
        resources :json_web_tokens, only: :new
      end

      authenticate :user, ->(u) { u.external? } do
        resources :users, only: %i[index show]
      end

      authenticate :user, ->(u) { u.admin? } do
        mount Sidekiq::Web => '/sidekiq'
      end

      resources :user_profiles, only: %i[show edit update] if RadConfig.user_profiles?
      resources :twilio_statuses, only: :create
      resources :twilio_replies, only: :create
      resources :sendgrid_statuses, only: :create
      resources :company_contacts, only: %i[new create]

      get 'terms', to: 'pages#terms'
      get 'privacy', to: 'pages#privacy'

      root to: 'pages#home'

      get '/robots.:format', to: 'robots#robots'
    end
  end
end
