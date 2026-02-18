RadCommon::Engine.routes.draw do
  # these will serve legacy permanent attachment links that include the engine name rad_common

  get 'attachments/:class_name/:id(.:format)/:variant(.:format)', to: 'attachments#download_variant'
  get 'attachments/:id(.:format)', to: 'attachments#download'

  # User preferences
  post 'user_preferences/sidebar', to: 'user_preferences#update_sidebar'
end
