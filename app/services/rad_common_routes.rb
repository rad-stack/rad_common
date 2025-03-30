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

        resources :audits, only: :index
        resources :login_activities, only: :index
        resources :system_messages, only: %i[new create show]
        resources :system_usages, only: %i[index]
        resources :notification_types, only: %i[index edit update]
        resources :global_validations, only: %i[new create]
        resources :sentry_tests, only: :new
        resources :contact_logs, only: %i[index show]
        resources :contact_log_recipients, only: :show
        resources :saved_search_filters, only: :destroy
        resources :user_security_roles, only: :show
        resources :user_clients, only: %i[create destroy]
        resources :json_web_tokens, only: :new
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

      resources :notifications, only: :index
      resources :notification_settings, only: %i[index create]
      resources :user_profiles, only: %i[show edit update] if RadConfig.user_profiles?
      resources :twilio_statuses, only: :create
      resources :twilio_replies, only: :create
      resources :sendgrid_statuses, only: :create
      resources :company_contacts, only: %i[new create]

      delete 'attachments/:id(.:format)', to: 'rad_common/attachments#destroy', as: :attachment

      get 'attachments/:class_name/:id(.:format)/:variant(.:format)', to: 'rad_common/attachments#download_variant'
      get 'attachments/:id(.:format)', to: 'rad_common/attachments#download'

      get 'attachments/:class_name/:id(.:format)/:variant(.:format)/:filename(.:format)',
          to: 'rad_common/attachments#download_variant'

      get 'attachments/:id(.:format)/:filename(.:format)', to: 'rad_common/attachments#download'

      get 'contact_us', to: 'pages#contact_us'
      get 'terms', to: 'pages#terms'
      get 'privacy', to: 'pages#privacy'

      root to: 'pages#home'
    end
  end
end
