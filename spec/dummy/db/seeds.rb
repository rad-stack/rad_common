Dir[Rails.root.join('../factories/**/*.rb')].each { |f| require f }

user_status = UserStatus.default_active_status
SecurityRole.seed_items if SecurityRole.count.zero?

if User.count.zero?
  FactoryBot.create :super_admin, email: 'admin@example.com', first_name: 'Test', last_name: 'Admin', user_status: user_status
  user = FactoryBot.create :user, email: 'user@example.com', first_name: 'Test', last_name: 'User', user_status: user_status
  user.security_roles << SecurityRole.find_by(name: 'User')
end
