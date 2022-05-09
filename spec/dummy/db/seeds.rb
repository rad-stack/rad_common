Dir[Rails.root.join('../factories/**/*.rb')].each { |f| require f }

Seeder.new.seed!
