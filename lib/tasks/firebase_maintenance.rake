namespace :firebase do
  task purge_all_data: :environment do
    raise "can't do it" if Rails.env.production?

    firebase_client = Firebase::Client.new(ENV['FIREBASE_DATA_URL'], ENV['FIREBASE_SECRET_KEY'])
    firebase_client.delete '/'
  end

  task update_rules: :environment do
    rules = File.read(Rails.root.join('config', 'firebase_rules.json'))

    url = "#{ENV['FIREBASE_DATA_URL']}.settings/rules.json?auth=#{ENV['FIREBASE_SECRET_KEY']}"
    abort unless `curl '#{url}'`
    abort unless `curl -X PUT -d '#{rules}' '#{url}'`
  end

  task seed_test: :environment do
    dev_firebase_client = Firebase::Client.new(ENV['FIREBASE_DATA_URL'], ENV['FIREBASE_SECRET_KEY'])
    dev_data = dev_firebase_client.get('/').body

    test_firebase_client = Firebase::Client.new(Dotenv.load('.env.test')['FIREBASE_DATA_URL'], Dotenv.load('.env.test')['FIREBASE_SECRET_KEY'])
    test_firebase_client.update('/', dev_data)

    rules = File.read(Rails.root.join('config', 'firebase_rules.json'))

    url = "#{Dotenv.load('.env.test')['FIREBASE_DATA_URL']}.settings/rules.json?auth=#{Dotenv.load('.env.test')['FIREBASE_SECRET_KEY']}"
    abort unless `curl '#{url}'`
    abort unless `curl -X PUT -d '#{rules}' '#{url}'`
  end
end
