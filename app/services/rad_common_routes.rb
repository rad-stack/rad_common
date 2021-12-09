module RadCommonRoutes
  def self.extended(router)
    router.instance_exec do
      devise_for :users,
                 path: 'auth',
                 controllers: { confirmations: 'users/confirmations', invitations: 'users/invitations' }

      resources :users, only: %i[index show edit update destroy] do
        member do
          put :resend_invitation
          put :confirm
          put :reset_authy
        end
      end

      resources :security_roles do
        get :permission, on: :collection
      end

      resources :user_security_roles, only: :show

      authenticate :user, ->(u) { u.admin? } do
        mount Sidekiq::Web => '/sidekiq'
      end

      root to: 'pages#home'
    end
  end
end
