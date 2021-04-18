Dir[Rails.root.join('../factories/**/*.rb')].sort.each { |f| require f }

puts 'seeding standard items'

SecurityRole.seed_items if SecurityRole.count.zero?
FactoryBot.create :company if Company.count.zero?
UserStatus.seed_items if UserStatus.count.zero?

if NotificationType.count.zero?
  NotificationType.seed_items
  Notifications::DivisionUpdatedNotification.create!
end

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

if Division.count.zero?
  puts 'seeding divisions'
  30.times { FactoryBot.create :division, owner: users.sample }
end

if Attorney.count.zero?
  20.times { FactoryBot.create :attorney }

  puts 'seeding duplicate attorneys'

  2.times do
    FactoryBot.build(:attorney,
                     first_name: 'Bruh',
                     last_name: 'Bro',
                     company_name: 'Bruh, Bro and Brah',
                     city: 'Atlanta',
                     state: 'GA',
                     email: 'bruh_bro@example.com').save!(validate: false)
  end

  Attorney.all.each(&:process_duplicates)
end

if TwilioLog.count.zero?
  puts 'seeding twilio logs'

  30.times do
    from_user = users.sample
    to_user = [1, 2].sample == 1 ? users.sample : nil

    FactoryBot.create :twilio_log, from_user: from_user, to_user: to_user
  end
end
