require 'factory_bot_rails'

Dir[Rails.root.join('../factories/**/*.rb')].sort.each { |f| require f }

Seeder.new(Logger.new($stdout)).seed!
