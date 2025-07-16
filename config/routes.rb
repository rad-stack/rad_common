RadCommon::Engine.routes.draw do
  # these will serve legacy permanent attachment links that include the engine name rad_common

  get 'attachments/:class_name/:id(.:format)/:variant(.:format)', to: 'rad_common/attachments#download_variant'
  get 'attachments/:id(.:format)', to: 'rad_common/attachments#download'
  get 'attachments/static/:id(.:format)', to: 'rad_common/attachments#download_static'
end
