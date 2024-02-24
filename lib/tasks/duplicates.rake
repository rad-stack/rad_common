require 'rake_session'

namespace :duplicates do
  task process: :environment do |task|
    session = RakeSession.new(task, 58.minutes, 10)

    Timeout.timeout(session.time_limit) do
      RadCommon::AppInfo.new.duplicate_models.each do |model_name|
        DuplicatesProcessor.new(model_name, rake_session: session).all!
        break if session.timing_out?
      end

      session.finished
    end
  end
end
