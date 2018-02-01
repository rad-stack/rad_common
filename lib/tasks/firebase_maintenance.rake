namespace :firebase do
  task purge_all_data: :environment do
    raise "can't do it" if Rails.env.production?

    FirebaseApp.all.each do |app|
      app.client.delete '/'
    end
  end

  task update_rules: :environment do
    FirebaseApp.all.each do |app|
      app.update_rules
    end
  end

  task seed_test: :environment do
    FirebaseApp.all.each do |app|
      app.seed_test
    end
  end
end
