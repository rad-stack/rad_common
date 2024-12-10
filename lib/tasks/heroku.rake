namespace :heroku do
  task :local_backup, [:heroku_app] => :environment do |_t, args|
    HerokuCommands.backup args[:heroku_app]
  end

  task :clone_local, %i[heroku_app backup_id] => :environment do |_t, args|
    # to run this with multiple args, the brackets must be escaped like this:
    # rails heroku:clone_local\[better-way-ars,a1010\]

    HerokuCommands.clone args[:heroku_app], args[:backup_id]
  end

  task :copy_production_to_staging, %i[production_heroku_app staging_heroku_app] => :environment do |_t, args|
    # to run this with multiple args, the brackets must be escaped like this:
    # rails heroku:copy_production_to_staging\[elo-roofing,elo-roofing-staging\]

    HerokuCommands.copy_production_data args[:production_heroku_app], args[:staging_heroku_app]
  end

  task :reset_staging, [:heroku_app] => :environment do |_t, args|
    HerokuCommands.reset_staging args[:heroku_app]
  end
end

namespace :local do
  task :restore_from_backup, [:file_name] => :environment do |_t, args|
    HerokuCommands.restore_from_backup args[:file_name]
  end

  task :dump, [:file_name] => :environment do |_t, args|
    HerokuCommands.dump args[:file_name]
  end
end
