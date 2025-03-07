class NotificationMailer < RadMailer
  before_action :enable_settings_link

  def new_user_signed_up(recipients, user)
    auto_approve = user.auto_approve?

    action_message = 'Review their user registration information'
    action_message += auto_approve ? ' if desired.' : ' and approve them if desired.'

    @email_action = { message: action_message,
                      button_text: auto_approve ? 'Review' : 'Review & Approve',
                      button_url: edit_user_url(user) }

    @message = "#{user} has signed up on #{app_name(user)}"
    @message += auto_approve ? '.' : ' and is awaiting approval.'

    send_notification_mail recipients, "New User on #{app_name(user)}"
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

  def global_validity(recipients, problems)
    @problems = problems
    @message = "There #{@problems.count == 1 ? 'is' : 'are'} #{pluralize(@problems.count, 'invalid record')}."

    send_notification_mail recipients, "Invalid data in #{RadConfig.app_name!}"
  end

  def global_validity_ran_long(recipients, run_stats)
    @run_stats = run_stats
    total_time = Time.at((@run_stats.sum { |item| item[:run_seconds] })).utc.strftime('%H:%M:%S')
    @message = "The Global Validity task took #{total_time} to complete, which is beyond the configured timeout."

    send_notification_mail recipients, "Global Validity in #{RadConfig.app_name!} Ran Long"
  end

  private

    def send_notification_mail(recipients, subject)
      @recipient = User.where(id: recipients)
      mail to: @recipient.map(&:formatted_email), subject: subject
    end
end
