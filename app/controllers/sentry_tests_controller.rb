class SentryTestsController < ApplicationController
  before_action :authenticate_user!

  def edit
    skip_authorization

    @user = current_user
    @user.first_name = 'Test'
    @user.last_name = 'Sentry'
  end

  def update
    skip_authorization
    raise 'sentry test'
  end
end
