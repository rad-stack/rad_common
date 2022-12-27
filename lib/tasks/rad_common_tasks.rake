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

  # Temporary task - remove when all project audits are converted to json
  task update_audits_json: :environment do
    session = RakeSession.new(task, 6.hours, 10_000)
    Timeout.timeout(session.time_limit) do
      session.reset_status

      records = Audited::Audit.where(audited_changes: nil)
      count = records.count
      records.select(:id, :audited_changes, :legacy_audited_changes).find_each(order: :desc) do |audit|
        break if session.check_status('migrating audited changes from YAML to JSONB', count)

        audit.update_column(:audited_changes, ActiveRecord::Coders::YAMLColumn.new(Object).load(audit.legacy_audited_changes))
      end
      session.finished
    end
  end
end
