class ManifestController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def show
    render json: {
      name: RadConfig.app_name!,
      short_name: RadConfig.app_name!,
      start_url: '/',
      display: 'standalone',
      background_color: '#ffffff',
      theme_color: '#ffffff',
      icons: [
        { src: '/manifest-icon-192.maskable.png', sizes: '192x192', type: 'image/png', purpose: 'maskable' },
        { src: '/manifest-icon-512.maskable.png', sizes: '512x512', type: 'image/png', purpose: 'maskable' },
        { src: '/manifest-icon-192.maskable.png', sizes: '192x192', type: 'image/png', purpose: 'any' },
        { src: '/manifest-icon-512.maskable.png', sizes: '512x512', type: 'image/png', purpose: 'any' }
      ],
      screenshots: [
        { src: '/screenshot-wide.png', sizes: '1280x720', type: 'image/png', form_factor: 'wide', label: RadConfig.app_name! },
        { src: '/screenshot-narrow.png', sizes: '720x1280', type: 'image/png', form_factor: 'narrow', label: RadConfig.app_name! }
      ]
    }
  end
end
