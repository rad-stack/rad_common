class PagesController < ApplicationController
  def home
    skip_authorization
  end
end
