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

  task :migrate_paperclip_data, %i[model_class attachment_names] => :environment do |_t, _args|
    model_class = model_class.constantize
    attachment_names = attachment_names.split(' ')
    MigratePaperclipData.perform(model_class, attachment_names)
  end

  task :migrate_paperclip_files, %i[model_class attachment_names] => :environment do |_t, _args|
    model_class = model_class.constantize
    attachment_names = attachment_names.split(' ')
    MigratePaperclipData.perform(model_class, attachment_names)
  end
end
