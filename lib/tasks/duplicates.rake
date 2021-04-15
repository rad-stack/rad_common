require 'rake_session'

namespace :duplicates do
  task process: :environment do
    session = RakeSession.new(20.minutes, 100)

    Timeout.timeout(session.time_limit) do
      [Patient, Prescriber, Attorney].each do |klass|
        session.reset_status
        records = klass.duplicates_to_process
        count = records.count

        records.each do |record|
          break if session.check_status('checking records for duplicates', count)

          record.process_duplicates
        end
      end
    end
  end

  task reset_sort: :environment do
    session = RakeSession.new(5.minutes, 1)

    Timeout.timeout(session.time_limit) do
      if Date.current.wday == 1
        Prescriber.where('duplicate_sort <> 500').update_all(duplicate_sort: 500)
        Patient.where('duplicate_sort <> 500').update_all(duplicate_sort: 500)
        Attorney.where('duplicate_sort <> 500').update_all(duplicate_sort: 500)
      end
    end
  end
end
