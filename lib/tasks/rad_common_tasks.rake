namespace :rad_common do
  task :global_validity, [:override_model] => :environment do |t, args|
    Timeout.timeout(Rails.application.config.global_validity_timeout) do
      global_validity = GlobalValidity.new
      global_validity.override_model = args[:override_model]
      global_validity.run
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

  task migrate_paperclip_data: :environment do |_t, args|
    session = RakeSession.new(48.hours, 10)
    Timeout.timeout(session.time_limit) do
      sql_prepared = false
      args.extras.each do |model_and_attachments|
        model_and_attachments_array = model_and_attachments.split(' ')
        model_class = model_and_attachments_array.first.constantize
        attachment_names = model_and_attachments_array.drop(1)
        MigratePaperclipData.perform(model_class, attachment_names, sql_prepared, session)
        sql_prepared = true
      end
    end
  end

  task migrate_paperclip_files: :environment do |_t, args|
    session = RakeSession.new(48.hours, 10)
    Timeout.timeout(session.time_limit) do
      args.extras.each do |model_and_attachments|
        model_and_attachments_array = model_and_attachments.split(' ')
        model_class = model_and_attachments_array.first.constantize
        attachment_names = model_and_attachments_array.drop(1)
        MigratePaperclipFiles.perform(model_class, attachment_names, session)
      end
    end
  end

  task paperclip_data_precheck: :environment do |_t, args|
    session = RakeSession.new(12.hours, 10)
    Timeout.timeout(session.time_limit) do
      args.extras.each do |model_and_attachments|
        model_and_attachments_array = model_and_attachments.split(' ')
        model_class = model_and_attachments_array.first.constantize
        attachment_names = model_and_attachments_array.drop(1)
        PaperclipDataPrecheck.perform(model_class, attachment_names, session)
      end
    end
  end
end
