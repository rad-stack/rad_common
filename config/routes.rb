RadCommon::Engine.routes.draw do
  get 'global_search', to: 'search#global_search'
  get 'global_search_result', to: 'search#global_search_result'

  post :email_error, to: 'rad_common/sendgrid#email_error'

  delete 'attachments/:id(.:format)', to: 'rad_common/attachments#destroy', as: :attachment

  resources :companies, only: [] do
    post :global_validity_check, on: :member
  end

  resources :system_messages, only: %i[new create show]
  resources :attachments, only: [] do
    get :download
  end

  resources :system_usages, only: %i[index]
  resources :notification_types, only: %i[index edit update]
  resources :notification_settings, only: %i[index create]
end
