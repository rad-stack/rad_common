Dir[Rails.root.join('../factories/**/*.rb')].sort.each { |f| require f }

seeder = Seeder.new
seeder.seed!
