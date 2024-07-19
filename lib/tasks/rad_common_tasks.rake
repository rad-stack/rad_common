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

      RadCommon::TwilioErrorThresholdChecker.new.check_threshold

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

  task unused_security_roles: :environment do
    puts SecurityRole.unused.pluck(:id)
  end

  task unused_permissions: :environment do
    admin_role_id = SecurityRole.admin_role
    where_clause = 'users.id NOT IN (SELECT user_security_roles.user_id FROM user_security_roles ' \
      'WHERE user_security_roles.security_role_id = ?)'

    RadPermission.all.each do |item|
      next if item == 'admin'
      next unless User.active.where(where_clause, admin_role_id).by_permission(item).count < 1

      puts item
    end

    RadPermission.all.each do |item|
      next if item == 'admin'

      permission = RadPermission.new(item)
      next unless permission.users.count == User.active.count

      puts item
    end
  end
end
