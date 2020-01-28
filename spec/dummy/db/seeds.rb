Dir[Rails.root.join('../factories/**/*.rb')].sort.each { |f| require f }

puts 'seeding standard items'
NotificationType.seed_items if NotificationType.count.zero?
SecurityRole.seed_items if SecurityRole.count.zero?
FactoryBot.create :company if Company.count.zero?
UserStatus.seed_items if UserStatus.count.zero?

if User.count.zero?
  puts 'seeding users'

  user_status = UserStatus.default_active_status

  FactoryBot.create :admin, email: 'admin@example.com',
                            first_name: 'Test',
                            last_name: 'Admin',
                            user_status: user_status,
                            security_roles: [SecurityRole.admin_role]

  FactoryBot.create :user, email: 'user@example.com',
                           first_name: 'Test',
                           last_name: 'User',
                           user_status: user_status,
                           security_roles: [SecurityRole.find_by(name: 'User')]

  FactoryBot.create :user, :external, email: 'admin@abc.com',
                                      first_name: 'Portal',
                                      last_name: 'Admin',
                                      user_status: user_status,
                                      security_roles: [SecurityRole.find_by(name: 'Portal Admin')]

  FactoryBot.create :user, :external, email: 'user@abc.com',
                                      first_name: 'Portal',
                                      last_name: 'User',
                                      user_status: user_status,
                                      security_roles: [SecurityRole.find_by(name: 'Portal User')]
end

users = User.all

puts 'seeding divisions'
FactoryBot.create_list :division, 30, owner: users.sample if Division.count.zero?
