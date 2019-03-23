Rails.application.routes.draw do
  mount RadCommon::Engine => '/rad_common'

  devise_for :users, controllers: { confirmations: 'users/confirmations', invitations: 'users/invitations' }

  resources :users, only: %i[index show edit update destroy] do
    member do
      put :resend_invitation
      put :confirm
      put :reset_authy
      get :audit
      get :audit_by
    end

    get :audit_search, on: :collection
  end

  resources :security_roles do
    get :audit, on: :member
    get :permission, on: :collection
  end

  resources :security_roles_users, only: :show
  resources :notification_settings, only: %i[index update create]

  resources :companies, only: %i[show edit update] do
    get :audit, on: :member
  end

  resources :divisions do
    get :audit, on: :member
  end

  resources :firebase_logs, only: %i[index destroy]

  root to: 'pages#home'
end
