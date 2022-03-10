class NotificationMailer < RadbearMailer
  before_action :enable_settings_link

  def new_user_signed_up(recipients, user)
    auto_approve = user.auto_approve?

    action_message = 'Review their user registration information'
    action_message += auto_approve ? ' if desired.' : ' and approve them if desired.'

    @email_action = { message: action_message,
                      button_text: auto_approve ? 'Review' : 'Review & Approve',
                      button_url: edit_user_url(user) }

    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @message = "#{user} has signed up on #{app_name(user)}"
    @message += auto_approve ? '.' : ' and is awaiting approval.'

    mail(to: to_address, subject: "New User on #{app_name(user)}")
  end

  def user_was_approved(recipients, user_and_approver)
    user = user_and_approver.first
    approver = user_and_approver.last

    @email_action = { message: 'You can review this approval if desired.',
                      button_text: 'Review User',
                      button_url: user_url(user) }

    approved_by_name = (approver ? approver.to_s : 'an admin')

    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @message = "#{user} was approved by #{approved_by_name} on #{RadicalConfig.app_name!}."
    mail(to: to_address, subject: "User Was Approved on #{RadicalConfig.app_name!}")
  end

  def global_validity(recipients, problems)
    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @problems = problems
    @message = "There #{@problems.count == 1 ? 'is' : 'are'} #{pluralize(@problems.count, 'invalid record')}."

    mail(to: to_address, subject: "Invalid data in #{RadicalConfig.app_name!}")
  end

  def global_validity_ran_long(recipients, run_stats)
    @recipient = User.where(id: recipients)
    to_address = @recipient.map(&:formatted_email)

    @run_stats = run_stats
    total_time = Time.at((@run_stats.sum { |item| item[:run_seconds] })).utc.strftime('%H:%M:%S')
    @message = "The Global Validity task took #{total_time} to complete, which is beyond the configured timeout."

    mail(to: to_address, subject: "Global Validity in #{RadicalConfig.app_name!} Ran Long")
  end
end
