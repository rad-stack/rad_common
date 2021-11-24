Rails.application.routes.draw do
  mount RadCommon::Engine => '/rad_common'

  devise_for :users,
             path: 'auth',
             controllers: { confirmations: 'users/confirmations', invitations: 'users/invitations' }

  resources :security_roles do
    get :permission, on: :collection
  end

  resources :users
  resources :user_security_roles, only: :show
  resources :divisions
  resources :attorneys

  namespace :api, defaults: { format: :json } do
    resources :divisions, only: :show
  end

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'pages#home'
end
