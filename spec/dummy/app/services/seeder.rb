class Seeder < RadSeeder
  def seed
    if Division.count.zero?
      display_log 'seeding divisions'

      30.times { FactoryBot.create :division, owner: users.internal.sample }
    end

    if Attorney.count.zero?
      FactoryBot.create_list :attorney, 20

      display_log 'seeding duplicate attorneys'

      Audited.audit_class.as_user(random_internal_user) do
        2.times do
          FactoryBot.build(:attorney,
                           first_name: 'Bruh',
                           last_name: 'Bro',
                           company_name: 'Bruh, Bro and Brah',
                           city: 'Atlanta',
                           state: 'GA',
                           email: 'bruh_bro@example.com').save!(validate: false)
        end
      end

      DuplicatesProcessor.new('Attorney').all!
    end

    3.times { FactoryBot.create :client } if Client.count.zero?

    return unless TwilioLog.count.zero?

    display_log 'seeding twilio logs'

    30.times do
      from_user = random_internal_user
      to_user = [1, 2].sample == 1 ? users.sample : nil

      FactoryBot.create :twilio_log, from_user: from_user, to_user: to_user
    end
  end
end
