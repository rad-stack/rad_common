class RadSeeder
  attr_accessor :users

  def seed!
    display_log 'seeding base tables'

    seed_security_roles
    seed_user_statuses
    seed_company
    seed_notification_types
    seed_users

    @users = User.all
  end

  private

    def display_log(message)
      puts message
    end

    def seed_notification_types
      return if NotificationType.exists?

      Notifications::NewUserSignedUpNotification.create! security_roles: [SecurityRole.admin_role]
      Notifications::UserWasApprovedNotification.create! security_roles: [SecurityRole.admin_role]
      Notifications::UserAcceptedInvitationNotification.create! security_roles: [SecurityRole.admin_role]
      Notifications::InvalidDataWasFoundNotification.create! security_roles: [SecurityRole.admin_role]
      Notifications::GlobalValidityRanLongNotification.create! security_roles: [SecurityRole.admin_role]
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
                       security_roles: user_security_roles(seeded_user),
                       twilio_verify_enabled: RadConfig.twilio_verify_enabled? }

        if seeded_user[:trait].present?
          FactoryBot.create seeded_user[:factory], seeded_user[:trait], attributes
        else
          FactoryBot.create seeded_user[:factory], attributes
        end
      end
    end

    def seed_security_roles
      return if SecurityRole.exists?

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

      NotificationType.all.find_each do |notification_type|
        role.notification_security_roles.create! notification_type: notification_type
      end

      true
    end

    def seed_all(role)
      RadPermission.all.each { |item| role.send("#{item}=", true) }
    end

    def seed_user
      # don't seed this if there are no additional permissions than the 2 standard ones
      return if RadPermission.only_standard?

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
      return if UserStatus.exists?

      UserStatus.create! name: 'Pending', active: false, validate_email_phone: true
      UserStatus.create! name: 'Active', active: true, validate_email_phone: true
      UserStatus.create! name: 'Inactive', active: false, validate_email_phone: false
    end

    def seed_company
      return if Company.exists?

      FactoryBot.create :company, email: seeded_user_config.first[:email], valid_user_domains: seeded_user_domains
    end

    def seeded_user_config
      RadConfig.seeded_users!
    end

    def seeded_user_mobile_phone(seeded_user)
      if (Rails.env.development? || Rails.env.test?) && seeded_user[:mobile_phone].blank?
        return FactoryBot.create(:phone_number, :mobile)
      end

      seeded_user[:mobile_phone]
    end

    def staging_safe_email
      # this is helfpul when sendgrid email validaiton is enabled on staging, the faker emails would then fail
      return seeded_user_config.first[:email] if Rails.env.staging?

      Faker::Internet.email
    end

    def seeded_user_domains
      internal_user_emails.map { |item| item.split('@').last }.uniq.sort
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

    def user_status
      UserStatus.default_active_status
    end

    def month_begin
      Date.current.beginning_of_month
    end

    def random_date(from_date, to_date)
      Faker::Date.unique.between(from: from_date, to: to_date)
    end
end
