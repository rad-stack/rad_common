namespace :firebase do
  require 'rake_session.rb'

  task event_cleanup: :environment do
    session = RakeSession.new(5.minutes, 1)

    Timeout.timeout(session.time_limit) do
      FirebaseApp.process_transactions
    end
  end
end
