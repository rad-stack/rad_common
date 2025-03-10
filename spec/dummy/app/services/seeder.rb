class Seeder < RadSeeder
  def seed
    user_role.update! read_attorney: true

    if Division.count.zero?
      display_log 'seeding divisions'

      30.times { FactoryBot.create :division, owner: users.internal.sample }
    end

    3.times { FactoryBot.create :client } if Client.count.zero?

    return unless ContactLog.count.zero?

    display_log 'seeding contact logs'

    30.times do
      from_user = random_internal_user
      to_user = [1, 2].sample == 1 ? users.sample : nil

      if [1, 2].sample == 1
        FactoryBot.create :contact_log, from_user: from_user, to_user: to_user
      else
        FactoryBot.create :contact_log, :email, from_user: from_user, to_user: to_user
      end
    end
  end

  private

    def seed_attorneys
      return if Attorney.exists?

      20.times { FactoryBot.create :attorney }

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

      Attorney.find_each { |item| item.process_duplicates(bypass_notifications: true) }
    end
end
