require 'rake_session'

namespace :duplicates do
  task process: :environment do
    session = RakeSession.new(58.minutes, 10)

    Timeout.timeout(session.time_limit) do
      RadCommon::AppInfo.new.duplicate_models.each do |model_name|
        session.reset_status
        records = model_name.constantize.duplicates_to_process
        count = records.count

        records.each do |record|
          break if session.check_status("checking #{model_name} records for duplicates", count)

          record.process_duplicates
        end
      end
    end
  end
end

namespace :duplicates do
  task reset_sort: :environment do
    session = RakeSession.new(5.minutes, 1)

    Timeout.timeout(session.time_limit) do
      Duplicate.where.not(sort: 500).update_all sort: 500 if Date.current.wday == 1
    end
  end
end

namespace :duplicates do
  task reset_all: :environment do
    session = RakeSession.new(5.minutes, 1)

    Timeout.timeout(session.time_limit) do
      Duplicate.delete_all
    end
  end
end
