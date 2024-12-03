RadCommon::Engine.routes.draw do
  delete 'attachments/:id(.:format)', to: 'rad_common/attachments#destroy', as: :attachment

  get 'attachments/:class_name/:id(.:format)/:variant(.:format)', to: 'rad_common/attachments#download_variant'
  get 'attachments/:id(.:format)', to: 'rad_common/attachments#download'
end
