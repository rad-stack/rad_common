class ApplicationController < ActionController::Base
  include RadbearController

  before_action :authenticate_user!

  protect_from_forgery prepend: true, with: :exception
end
