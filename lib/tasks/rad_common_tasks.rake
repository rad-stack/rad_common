namespace :rad_common do
  task :daily, [:override_model] => :environment do |task, args|
    session = RakeSession.new(task, 24.hours, 1)

    Timeout.timeout(session.time_limit) do
      session.reset_status

      Rails.cache.delete_matched('views/*')

      Duplicate.where.not(sort: 500).update_all sort: 500 if Date.current.wday == 1

      RadCommon::AppInfo.new.duplicate_models.each do |model_name|
        model_name.constantize.notify_high_duplicates
      end

      global_validity = GlobalValidation.new
      global_validity.override_model = args[:override_model]
      global_validity.run

      session.finished
    end
  end

  task ten_minutes: :environment do |task|
    session = RakeSession.new(task, 5.minutes, 1)

    Timeout.timeout(session.time_limit) do
      ContactLogRecipient.sms_assumed_failed.each do |record|
        record.sms_assume_failed!
        session.reset_status
        break if session.timing_out?
      end

      session.finished
    end
  end

  task check_database_use: :environment do
    Timeout.timeout(30.minutes) do
      DatabaseUseChecker.generate_report
    end
  end
end
