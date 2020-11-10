# for projects with multiple heroku apps, run like this with the app name:
#   rake heroku:clone_local["myappname"]

namespace :heroku do
  task :local_backup, [:heroku_app] => :environment do |_t, args|
    HerokuCommands.backup args[:heroku_app]
  end

  task :clone_local, %i[heroku_app keep_dump_file] => :environment do |_t, args|
    HerokuCommands.clone args[:heroku_app], keep_dump_file: args[:keep_dump_file]
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
