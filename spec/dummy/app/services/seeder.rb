class Seeder < RadSeeder
  def seed!
    super

    if Division.count.zero?
      display_log 'seeding divisions'

      30.times { FactoryBot.create :division, owner: users.sample }
    end

    if Attorney.count.zero?
      FactoryBot.create_list :attorney, 20

      display_log 'seeding duplicate attorneys'

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

    3.times { FactoryBot.create :client } if Client.count.zero?

    return unless TwilioLog.count.zero?

    display_log 'seeding twilio logs'

    30.times do
      from_user = users.sample
      to_user = [1, 2].sample == 1 ? users.sample : nil

      FactoryBot.create :twilio_log, from_user: from_user, to_user: to_user
    end
  end

  private

    def seed_notification_types
      return if NotificationType.count.positive?

      NotificationType.seed_items
      Notifications::DivisionUpdatedNotification.create!
    end
end
