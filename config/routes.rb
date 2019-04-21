RadCommon::Engine.routes.draw do
  get 'global_search', to: 'search#global_search'
  get 'global_search_result', to: 'search#global_search_result'

  post :email_error, to: 'rad_common/sendgrid#email_error'

  resources :companies, only: [] do
    get :usage, on: :member
    post :global_validity_check, on: :member
  end

  resources :system_messages, only: %i[new create]

  resources :notification_settings, only: %i[index create]
end
