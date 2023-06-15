class JsonWebTokensController < ApplicationController
  def new
    authorize Company.main, :jwt?

    flash[:success] = "Your token is as follows: #{RadJwtGenerator.new.token}"
    redirect_to root_path
  end
end
