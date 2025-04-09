class Seeder < RadSeeder
  def seed
    user_role.update! read_attorney: true

    if Division.count.zero?
      display_log 'seeding divisions'

      30.times { FactoryBot.create :division, owner: users.internal.sample }
    end

    seed_attorneys

    3.times { FactoryBot.create :client } if Client.count.zero?
  end

  private

    def seed_attorneys
      return if Attorney.exists?

      display_log 'seeding attorneys'

      20.times { FactoryBot.create :attorney }

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

      Attorney.find_each { |item| item.process_duplicates(bypass_notifications: true) }
    end
end
