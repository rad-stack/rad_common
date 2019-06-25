namespace :firebase do
  task purge_all_data: :environment do
    raise "can't do it" if Rails.env.production? && !Company.staging?

    FirebaseApp.new.client.delete '/'
  end

  task update_rules: :environment do
    FirebaseApp.new.update_rules
  end

  task seed_test: :environment do
    FirebaseApp.new.seed_test
  end
end
