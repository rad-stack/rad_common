module FirebaseAction
  extend ActiveSupport::Concern

  module ClassMethods
    def firebase_cleanup(app, user, error, path, data)
      if error
        data['error'] = error
        RadbearMailer.simple_message(Company.main, user, 'Problem', error).deliver_later if user

        User.super_admins.each do |admin|
          user_description = if user.nil?
                               'a user'
                             else
                               "#{user} on version #{user.mobile_client_version}"
                             end

          email_action = { message: 'Check out the logs here.',
                           button_text: 'View Logs',
                           button_url:  Rails.application.routes.url_helpers.firebase_logs_url }

          RadbearMailer.simple_message(Company.main, admin,
                                       "User Error on #{I18n.t(:app_name)}",
                                       "An operation attempted by #{user_description} failed: #{error}.",
                                       email_action: email_action).deliver_later
        end
      end

      data['timestamp'] = Time.zone.now.to_s

      response = RadicalRetry.perform_request { app.client.update("logs#{path}", data) }
      raise response.body unless response.success?

      response = RadicalRetry.perform_request { app.client.delete("transactions#{path}") }
      raise response.body unless response.success?

      user&.update_firebase_info(app)
    end
  end
end
