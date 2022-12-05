namespace :rad_common do
  task :daily_rad_tasks, [:override_model] => :environment do |task, args|
    session = RakeSession.new(task, 24.hours, 1)

    Timeout.timeout(session.time_limit) do
      session.reset_status

      global_validity = GlobalValidation.new
      global_validity.override_model = args[:override_model]
      global_validity.run

      checker = TwilioErrorThresholdChecker.new
      Notifications::TwilioErrorThresholdPassedNotification.main.notify! if checker.passed_error_threshold?

      session.finished
    end
  end

  task redo_authy: :environment do
    Timeout.timeout(1.hour) do
      User.where(authy_enabled: true).find_each do |user|
        user.update!(authy_enabled: false)
        user.update!(authy_enabled: true)
        sleep 2 # avoid DDOS throttling
      end
    end
  end

  task check_database_use: :environment do
    Timeout.timeout(30.minutes) do
      DatabaseUseChecker.generate_report
    end
  end
end
