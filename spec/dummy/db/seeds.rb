Dir[Rails.root.join('../factories/**/*.rb')].each { |f| require f }

FactoryBot.create :super_admin, email: "admin@example.com"
