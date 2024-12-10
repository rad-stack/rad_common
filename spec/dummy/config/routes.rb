Rails.application.routes.draw do
  mount RadCommon::Engine => '/rad_common'
  extend RadCommonRoutes

  resources :attorneys
  resources :clients
  resources :divisions

  namespace :api, defaults: { format: :json } do
    resources :divisions, only: :show
  end
end
