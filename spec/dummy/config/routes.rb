Rails.application.routes.draw do
  mount RadCommon::Engine => '/rad_common'

  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    get :audit, on: :member
    get :audit_by, on: :member
    get :audit_search, on: :collection
  end

  resources :security_groups, only: [:show, :index] do
    get :audit, on: :member
  end

  resources :companies, only: %i[show edit update] do
    get :audit, on: :member
  end

  resources :divisions do
    get :audit, on: :member
  end

  root to: 'pages#home'
end
