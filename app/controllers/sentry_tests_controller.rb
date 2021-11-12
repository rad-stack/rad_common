class SentryTestsController < ApplicationController
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
