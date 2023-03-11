namespace :rad_common do
  task :daily, [:override_model] => :environment do |task, args|
    session = RakeSession.new(task, 24.hours, 1)

    Timeout.timeout(session.time_limit) do
      session.reset_status

      RadCommon::TwilioErrorThresholdChecker.new.check_threshold

      global_validity = GlobalValidation.new
      global_validity.override_model = args[:override_model]
      global_validity.run

      session.finished
    end
  end

  task check_database_use: :environment do
    Timeout.timeout(30.minutes) do
      DatabaseUseChecker.generate_report
    end
  end
end
