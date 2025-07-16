class ApplicationController < ActionController::Base
  include RadController

  before_action :redirect_root_domain
  before_action :authenticate_user!

  protect_from_forgery prepend: true, with: :exception

  private

    def redirect_root_domain
      return unless RadConfig.allow_marketing_site? && Rails.env.production? && request.host == root_host_name

      redirect_to "#{request.protocol}#{www_host_name}#{request.fullpath}",
                  status: :moved_permanently,
                  allow_other_host: true
    end

    def root_host_name
      RadConfig.host_name!.split('.').drop(1).join('.')
    end

    def www_host_name
      "www.#{root_host_name}"
    end
end
