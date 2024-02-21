require 'rake_session'

namespace :duplicates do
  task process: :environment do |task|
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
end

namespace :duplicates do
  task reset_all: :environment do |task|
    session = RakeSession.new(task, 5.minutes, 1)

    Timeout.timeout(session.time_limit) do
      Duplicate.delete_all
      session.finished
    end
  end
end
