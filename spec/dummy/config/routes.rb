Rails.application.routes.draw do
  mount RadCommon::Engine => '/rad_common'
  extend RadCommonRoutes

  resources :onboardings, only: :index

  resources :attorneys
  resources :clients
  resources :direct_messages, except: :show do
    get :chat, on: :member
    post :typing, on: :member
  end
  resources :divisions do
    get :calendar, on: :collection
    get :quick_view, on: :member
  end

  resources :client_reports, only: :index

  namespace :api, defaults: { format: :json } do
    resources :divisions, only: :show
  end
end
