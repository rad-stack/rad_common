require 'rake_session'

namespace :duplicates do
  task process: :environment do
    session = RakeSession.new(20.minutes, 10)

    Timeout.timeout(session.time_limit) do
      Rails.application.config.duplicate_model_names.each do |model_name|
        session.reset_status
        records = model_name.constantize.duplicates_to_process
        count = records.count

        records.each do |record|
          break if session.check_status('checking records for duplicates', count)

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
      if Date.current.wday == 1
        Rails.application.config.duplicate_model_names.each do |model_name|
          model_name.constantize.where('duplicate_sort <> 500').update_all(duplicate_sort: 500)
        end
      end
    end
  end
end

namespace :duplicates do
  task reset_all: :environment do
    session = RakeSession.new(5.minutes, 1)

    Timeout.timeout(session.time_limit) do
      Rails.application.config.duplicate_model_names.each do |model_name|
        model_name.constantize.update_all duplicate_sort: 500,
                                          duplicates_not: nil,
                                          duplicate_score: nil,
                                          duplicates_processed_at: nil
      end
    end
  end
end
