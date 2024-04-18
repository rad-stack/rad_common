RadCommon::Engine.routes.draw do
  get 'global_search', to: 'search#global_search'
  get 'global_search_result', to: 'search#global_search_result'

  post :email_error, to: 'rad_common/sendgrid#email_error'

  delete 'attachments/:id(.:format)', to: 'rad_common/attachments#destroy', as: :attachment

  get 'attachments/:class_name/:id(.:format)/:variant(.:format)', to: 'rad_common/attachments#download_variant'
  get 'attachments/:id(.:format)', to: 'rad_common/attachments#download'

  get 'company', to: 'companies#show'
  get 'company/edit', to: 'companies#edit'
  put 'company/update', to: 'companies#update'

  resources :impersonations, only: [] do
    collection do
      post :start
      delete :stop
    end
  end

  resources :audits, only: :index
  resources :system_messages, only: %i[new create show]
  resources :system_usages, only: %i[index]
  resources :notification_types, only: %i[index edit update]
  resources :notification_settings, only: %i[index create]
  resources :notifications, only: :index
  resources :sentry_tests, only: %i[edit update]
  resources :login_activities, only: :index
  resources :contact_logs, only: :index
  resources :global_validations, only: %i[new create]
end
