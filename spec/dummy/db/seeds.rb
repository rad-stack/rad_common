Dir[Rails.root.join('../factories/**/*.rb')].sort.each { |f| require f }

Seeder.new.seed!
