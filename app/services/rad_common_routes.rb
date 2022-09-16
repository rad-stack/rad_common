module RadCommonRoutes
  def self.extended(router)
    router.instance_exec do
      devise_controllers = { confirmations: 'users/confirmations',
                             devise_authy: 'users/devise_authy',
                             invitations: 'users/invitations' }

      devise_paths = { verify_authy: '/verify-token',
                       enable_authy: '/enable-two-factor',
                       verify_authy_installation: '/verify-installation' }

      devise_for :users, path: 'auth', controllers: devise_controllers, path_names: devise_paths

      authenticate :user, ->(u) { u.internal? } do
        resources :users do
          get :export, on: :collection

          member do
            put :resend_invitation
            put :confirm
            put :reset_authy
            put :reactivate
            put :test_email
            put :test_sms
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

      get 'contact_us', to: 'pages#contact_us'
      get 'terms', to: 'pages#terms'
      get 'privacy', to: 'pages#privacy'

      root to: 'pages#home'
    end
  end
end
