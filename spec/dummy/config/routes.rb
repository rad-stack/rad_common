Rails.application.routes.draw do
  mount RadCommon::Engine => '/rad_common'
  extend RadCommonRoutes

  resources :onboardings, only: :index

  resources :attorneys
  resources :clients
  resources :divisions do
    get :calendar, on: :collection
  end

  resources :client_reports, only: :index

  namespace :api, defaults: { format: :json } do
    resources :divisions, only: :show
  end
end
