Rails.application.routes.draw do
  mount RadCommon::Engine => '/rad_common'

  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  resources :users, only: %i[index show edit update destroy] do
    get :audit, on: :member
    get :audit_by, on: :member
    get :audit_search, on: :collection
  end

  resources :security_roles do
    get :audit, on: :member
    get :permission, on: :collection
  end

  resources :companies, only: %i[show edit update] do
    get :audit, on: :member
  end

  resources :divisions do
    get :audit, on: :member
  end

  resources :firebase_logs, only: %i[index destroy]

  root to: 'pages#home'
end
