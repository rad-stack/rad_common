class SentryTestsController < ApplicationController
  def new
    skip_authorization
    Sentry.capture_message "Sentry Exception Reporting Test on #{RadConfig.app_name!}"
    redirect_to root_path, notice: 'Sentry test was successfully executed.'
  end
end
