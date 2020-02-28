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

        def mailer_subject(subject)
          "Division '#{subject}' was Updated"
        end

        def mailer_message(subject)
          "Your division '#{subject}' was updated and we thought you might like to know."
        end

        def mailer_options(subject)
          { email_action: { message: 'Click here to view the details.',
                            button_text: 'View',
                            button_url: Rails.application.routes.url_helpers.division_url(subject) } }
        end

        def feed_content(subject)
          mailer_subject(subject)
        end

        def sms_content(subject)
          feed_content(subject)
        end

        def absolute_user_id(subject)
          subject.owner_id
        end
    end
  end
end
