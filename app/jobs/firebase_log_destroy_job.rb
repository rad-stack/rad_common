class FirebaseLogDestroyJob < ActiveJob::Base
  queue_as :firebase

  def perform(app_id, type, log_id, current_user_id)
    app = FirebaseApp.find(app_id)
    type == 'all' ? delete_all_logs(app, log_id, current_user_id) : delete_logs_individually(app, log_id, current_user_id)
  end

  private

    def send_failure_email(current_user_id, log_id, response)
      user = User.find(current_user_id)
      RadbearMailer.simple_message(Company.main, user, "Firebase error on #{I18n.t(:app_name)}", "Could not delete the #{log_id.titleize} logs: #{response.body}").deliver_now
    end

    def delete_all_logs(app, log_id, current_user_id)
      response = RadicalRetry.perform_request { app.client.delete("logs/#{log_id}") }

      return if response.success?
      send_failure_email(current_user_id, log_id, response)
    end

    def delete_logs_individually(app, log_id, current_user_id)
      response = RadicalRetry.perform_request { app.client.get("logs/#{log_id}") }

      if response.success?
        delete_each_log(app, response, log_id, current_user_id)
      else
        send_failure_email(current_user_id, log_id, response)
      end
    end

    def delete_each_log(app, response, log_id, current_user_id)
      logs = response.body
      return if logs.nil?

      logs.each do |log|
        next if log.last['error']

        response = RadicalRetry.perform_request { app.client.delete("logs/#{log_id}/#{log.first}") }

        unless response.success?
          send_failure_email(current_user_id, log_id, response)
          break
        end
      end
    end
end
