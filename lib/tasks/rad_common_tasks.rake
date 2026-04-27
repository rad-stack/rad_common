namespace :rad_common do
  task :daily, [:override_model] => :environment do |task, args|
    session = RakeSession.new(task, 23.hours, 1)

    Timeout.timeout(session.time_limit) do
      session.reset_status

      Rails.cache.delete_matched('views/*')

      unless RadConfig.shared_database?
        Duplicate.where.not(sort: 500).update_all sort: 500

        AppInfo.new.duplicate_models.each do |model_name|
          model_name.constantize.notify_high_duplicates
        end

        TwilioErrorThresholdChecker.new.check_threshold

        missing_audited_models = RadAudit.missing_audited_models

        if missing_audited_models.any?
          Notifications::MissingAuditModelsNotification.main(missing_audited_models).notify!
        end

        global_validity = GlobalValidation.new
        global_validity.override_model = args[:override_model]
        global_validity.run

        StalePendingUserCleaner.new.run
        ExistingDataEmbedder.new.run(session)
      end

      session.finished
    end
  end

  task hourly: :environment do |task|
    session = RakeSession.new(task, 58.minutes, 10)

    Timeout.timeout(session.time_limit) do
      AppInfo.new.duplicate_models.each do |model_name|
        session.reset_status
        model_name.constantize.process_duplicates(session)
        break if session.timing_out?
      end

      session.finished
    end
  end

  task ten_minutes: :environment do |task|
    session = RakeSession.new(task, 8.minutes, 1)

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

  task build_js_css: :environment do
    system('yarn build')
  end
  Rake::Task['assets:precompile'].enhance(['rad_common:build_js_css']) if Rake::Task.task_defined?('assets:precompile')

  task check_schema_standards: :environment do
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.columns(table).each do |column|
        next unless invalid_boolean_schema?(column) || invalid_jsonb_schema?(column) || invalid_array_schema?(column)

        raise "column #{table}.#{column.name}: type: #{column.type}, null: #{column.null}, default: #{column.default}"
      end
    end
  end

  def invalid_boolean_schema?(column)
    return false if column.array?
    return false unless column.type == :boolean

    column.null || column.default.blank?
  end

  def invalid_jsonb_schema?(column)
    return false unless column.type == :jsonb

    column.null || column.default.nil?
  end

  def invalid_array_schema?(column)
    return false unless column.array?

    column.null || column.default.nil?
  end
end
