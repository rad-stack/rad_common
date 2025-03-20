namespace :rad_common do
  task :daily, [:override_model] => :environment do |task, args|
    session = RakeSession.new(task, 24.hours, 1)

    Timeout.timeout(session.time_limit) do
      session.reset_status

      Rails.cache.delete_matched('views/*')

      unless RadConfig.react_app?
        Duplicate.where.not(sort: 500).update_all sort: 500

        RadCommon::AppInfo.new.duplicate_models.each do |model_name|
          model_name.constantize.notify_high_duplicates
        end

        RadCommon::TwilioErrorThresholdChecker.new.check_threshold

        global_validity = GlobalValidation.new
        global_validity.override_model = args[:override_model]
        global_validity.run
      end

      session.finished
    end
  end

  task hourly: :environment do |task|
    session = RakeSession.new(task, 58.minutes, 10)

    Timeout.timeout(session.time_limit) do
      RadCommon::AppInfo.new.duplicate_models.each do |model_name|
        session.reset_status
        model_name.constantize.process_duplicates(session)
        break if session.timing_out?
      end

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

  task unused_security_roles: :environment do
    puts SecurityRole.unused.pluck(:id)
  end

  task unused_permissions: :environment do
    puts 'no users have these permissions:'

    RadPermission.unused_no_users.each do |item|
      puts item
    end

    puts
    puts

    puts 'all users have these permissions:'

    RadPermission.unused_all_users.each do |item|
      puts item
    end
  end

  task update_s3_cors_settings: :environment do
    S3CorsSettingsUpdater.new.update!
  end
end
