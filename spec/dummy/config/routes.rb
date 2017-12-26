Rails.application.routes.draw do
  mount RadCommon::Engine => "/rad_common"

  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  root to: "pages#home"

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    get :audit, on: :member
    get :audit_by, on: :member
    get :audit_search, on: :collection
  end

  resources :security_groups, only: [:show, :index] do
    get :audit, on: :member
  end

  resources :companies, only: :show

  resources :divisions do
    get :audit, on: :member
  end
end
