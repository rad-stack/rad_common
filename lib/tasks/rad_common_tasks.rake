namespace :rad_common do
  task :daily, [:override_model] => :environment do |task, args|
    session = RakeSession.new(task, 24.hours, 1)

    Timeout.timeout(session.time_limit) do
      session.reset_status

      Rails.cache.delete_matched('views/*')

      # disabling this, see Task 2576 - this won't be needed when we can combine cp-deals-public and cp-deals-admin
      # Duplicate.where.not(sort: 500).update_all sort: 500 if Date.current.wday == 1
      #
      # RadCommon::AppInfo.new.duplicate_models.each do |model_name|
      #   model_name.constantize.notify_high_duplicates
      # end
      #
      # RadCommon::TwilioErrorThresholdChecker.new.check_threshold
      #
      # global_validity = GlobalValidation.new
      # global_validity.override_model = args[:override_model]
      # global_validity.run

      session.finished
    end
  end

  task check_database_use: :environment do
    Timeout.timeout(30.minutes) do
      DatabaseUseChecker.generate_report
    end
  end
end
