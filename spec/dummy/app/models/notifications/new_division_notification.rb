module Notifications
  class NewDivisionNotification < ::NotificationType
    class << self
      protected

        def mailer_class
          'RadbearMailer'
        end

        def mailer_method
          'simple_message'
        end

        def mailer_subject(payload)
          "Division '#{payload}' was Updated"
        end

        def mailer_message(payload)
          "Your division '#{payload}' was updated and we thought you might like to know."
        end

        def mailer_options(payload)
          { email_action: { message: 'Click here to view the details.',
                            button_text: 'View',
                            button_url: Rails.application.routes.url_helpers.division_url(payload) } }
        end

        def feed_content(payload)
          mailer_subject(payload)
        end

        def feed_record(payload)
          payload
        end

        def sms_content(payload)
          "Division '#{payload}' was updated: #{Rails.application.routes.url_helpers.division_url(payload)}"
        end

        def absolute_user_id(payload)
          payload.owner_id
        end
    end
  end
end
