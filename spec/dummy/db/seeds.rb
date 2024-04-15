require 'factory_bot_rails'
require 'rad_rspec/rad_factories'

Dir[Rails.root.join('../factories/*.rb')].each { |f| require f }

RadFactories.load!
Seeder.new.seed!
