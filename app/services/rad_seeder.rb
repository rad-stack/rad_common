class RadSeeder
  DEV_NOTIFICATION_TYPES = %w[Notifications::DuplicateFoundAdminNotification
                              Notifications::GlobalValidityRanLongNotification
                              Notifications::HighDuplicatesNotification
                              Notifications::InvalidDataWasFoundNotification
                              Notifications::TwilioErrorThresholdExceededNotification
                              Notifications::MissingAuditModelsNotification].freeze

  attr_accessor :users

  def seed!
    ApplicationRecord.seeding = true
    display_log 'seeding base tables'

    seed_security_roles
    seed_user_statuses
    seed_company
    seed_users
    @users = User.all
    seed_contact_logs if development?

    mute_staging_notifications if staging?

    seed
  ensure
    ApplicationRecord.seeding = false
  end

  private

    def seed
      raise 'Seeder class must implement #seed'
    end

    def display_log(message)
      puts message
    end

    def seed_users
      return if User.exists?

      display_log 'seeding users'

      seeded_user_config.each do |seeded_user|
        attributes = { email: seeded_user[:email],
                       user_status: user_status,
                       first_name: seeded_user[:first_name],
                       last_name: seeded_user[:last_name],
                       mobile_phone: seeded_user_mobile_phone(seeded_user),
                       timezone: seeded_user[:timezone],
                       security_roles: user_security_roles(seeded_user) }

        if seeded_user[:trait].present?
          FactoryBot.create seeded_user[:factory], seeded_user[:trait], attributes
        else
          FactoryBot.create seeded_user[:factory], attributes
        end
      end
    end

    def seed_contact_logs
      return if ContactLog.exists?

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

    def mute_staging_notifications
      DEV_NOTIFICATION_TYPES.each do |notification_type_class|
        notification_type = notification_type_class.constantize.main

        notification_type.security_roles.each do |security_role|
          security_role.users.active.each do |user|
            next if user.developer?

            NotificationSetting.init_for_user(notification_type, user).update! enabled: false
          end
        end
      end
    end

    def seed_security_roles
      return if SecurityRole.count.positive?

      seed_admin
      seed_user

      return true unless RadConfig.external_users?

      seed_client_user
    end

    def seed_admin(role_name = 'Admin')
      role = get_role(role_name)
      role.allow_invite = !RadConfig.disable_invite?
      seed_all role
      role.save!

      true
    end

    def seed_all(role)
      RadPermission.all.each { |item| role.send("#{item}=", true) }
    end

    def seed_user
      return unless seeded_user_role?

      role = get_role('User')
      role.allow_invite = !RadConfig.disable_invite?
      role.save!
    end

    def seed_client_user
      role = get_role('Client User')
      role.external = true
      role.allow_invite = !RadConfig.disable_invite?
      role.allow_sign_up = !RadConfig.disable_sign_up?
      role.save!
    end

    def get_role(name)
      role = SecurityRole.find_or_initialize_by(name: name)

      # init all perms to false
      RadPermission.all.each do |field|
        role.send("#{field}=", false)
      end

      role
    end

    def seed_user_statuses
      return if UserStatus.count.positive?

      UserStatus.create! name: 'Pending', active: false, validate_email_phone: true if RadConfig.pending_users?

      UserStatus.create! name: 'Active', active: true, validate_email_phone: true
      UserStatus.create! name: 'Inactive', active: false, validate_email_phone: false
    end

    def seed_company
      return if Company.count.positive?

      FactoryBot.create :company, email: seeded_user_config.first[:email], valid_user_domains: seeded_user_domains
    end

    def seeded_user_config
      RadConfig.seeded_users!
    end

    def seeded_user_mobile_phone(seeded_user)
      return FactoryBot.create(:phone_number, :mobile) if (development? || test?) && seeded_user[:mobile_phone].blank?

      seeded_user[:mobile_phone]
    end

    def staging_safe_email
      # this is helpful when sendgrid email validation is enabled on staging, the faker emails would then fail
      return seeded_user_config.first[:email] if staging?

      Faker::Internet.email
    end

    def seeded_user_domains
      internal_user_emails.map { |item| item.split('@').last }.uniq.sort
    end

    def seeded_user_role?
      seeded_user_config.pluck(:security_role).include?('User')
    end

    def internal_user_emails
      seeded_user_config.map { |item|
        next if item[:trait] == 'external'

        item[:email]
      }.compact
    end

    def user_security_roles(seeded_user)
      return [] if seeded_user[:security_role].blank?

      [role_by_name(seeded_user[:security_role])]
    end

    def user_role
      role_by_name 'User'
    end

    def client_user_role
      role_by_name 'Client User'
    end

    def admin_user
      first_user_in_role 'Admin'
    end

    def first_user_in_role(name)
      role_by_name(name).users.by_id.first
    end

    def role_by_name(name)
      role = SecurityRole.find_by(name: name)
      return role if role.present?

      raise "Couldn't find security role named #{name}"
    end

    def random_user
      users.sample
    end

    def random_internal_user
      users.internal.sample
    end

    def user_status
      UserStatus.default_active_status
    end

    def month_begin
      Date.current.beginning_of_month
    end

    def random_date(from_date, to_date)
      Faker::Date.unique.between(from: from_date, to: to_date)
    end

    def production?
      Rails.env.production?
    end

    def staging?
      Rails.env.staging?
    end

    def development?
      Rails.env.development?
    end

    def test?
      Rails.env.test?
    end
end
