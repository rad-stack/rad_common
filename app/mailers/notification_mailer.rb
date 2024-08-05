class NotificationMailer < RadMailer
  before_action :enable_settings_link

  def new_user_signed_up(recipients, user)
    user_is_active = user.active?

    action_message = 'Review their user registration information'
    action_message += user_is_active ? ' if desired.' : ' and approve them if desired.'

    @email_action = { message: action_message,
                      button_text: user_is_active ? 'Review' : 'Review & Approve',
                      button_url: edit_user_url(user) }

    @message = "#{user} has signed up on #{RadConfig.app_name!}"
    @message += user_is_active ? '.' : ' and is awaiting approval.'

    send_notification_mail recipients, "New User on #{RadConfig.app_name!}"
  end

  def user_was_approved(recipients, user_and_approver)
    user = user_and_approver.first
    approver = user_and_approver.last

    @email_action = { message: 'You can review this approval if desired.',
                      button_text: 'Review User',
                      button_url: user_url(user) }

    approved_by_name = (approver ? approver.to_s : 'an admin')

    @message = "#{user} was approved by #{approved_by_name} on #{RadConfig.app_name!}."
    send_notification_mail recipients, "User Was Approved on #{RadConfig.app_name!}"
  end

  def global_validity(recipients, payload)
    @problems = payload[:error_messages]
    @message = global_validity_message(payload)

    send_notification_mail recipients, "Invalid data in #{RadConfig.app_name!}"
  end

  def global_validity_ran_long(recipients, run_stats)
    @run_stats = run_stats
    total_time = Time.at((@run_stats.sum { |item| item[:run_seconds] })).utc.strftime('%H:%M:%S')
    @message = "The Global Validity task took #{total_time} to complete, which is beyond the configured timeout."

    send_notification_mail recipients, "Global Validity in #{RadConfig.app_name!} Ran Long"
  end

  def outgoing_contact_failed(recipients, contact_log_recipient)
    @contact_log_recipient = contact_log_recipient
    @contact_log = contact_log_recipient.contact_log

    contact_description = RadEnum.new(ContactLog, 'service_type').translation(@contact_log.service_type)

    @message = "An #{contact_description} message that was sent has failed."

    contacted_item = contact_log_recipient.to_user.presence ||
                     contact_log_recipient.email.presence ||
                     contact_log_recipient.phone_number.presence

    subject = "Outgoing #{contact_description} Failed for #{contacted_item} in #{RadConfig.app_name!}"

    send_notification_mail recipients, subject
  end

  def high_duplicates(recipients, payload)
    model_name = payload[:model_name]

    threshold = ActiveSupport::NumberHelper.number_to_percentage(payload[:threshold] * 100,
                                                                 strip_insignificant_zeros: true,
                                                                 precision: 2)

    formatted_percent = ActiveSupport::NumberHelper.number_to_percentage(payload[:percentage] * 100,
                                                                         strip_insignificant_zeros: true,
                                                                         precision: 2)

    @message = "The threshold of #{threshold} for potential duplicate #{model_name.titleize} records has been " \
               "exceeded with #{formatted_percent} of records to review."

    @email_action = { message: 'You can review the records here.',
                      button_text: 'Review Records',
                      button_url: resolve_duplicates_url(model: model_name) }

    send_notification_mail recipients, "Too Many Potential Duplicate #{model_name.titleize} Records"
  end

  private

    def send_notification_mail(recipients, subject, options = {})
      @recipient = User.where(id: recipients)
      mail to: @recipient.map(&:formatted_email), subject: subject, cc: options[:cc]
    end

    def global_validity_message(payload)
      message_count = payload[:error_messages].size
      return standard_global_validity_message(payload) if payload[:error_count] == message_count

      "#{standard_global_validity_message(payload)} Only the first #{message_count} records are included here."
    end

    def standard_global_validity_message(payload)
      "There #{payload[:error_count] == 1 ? 'is' : 'are'} #{pluralize(payload[:error_count], 'invalid record')}."
    end
end
