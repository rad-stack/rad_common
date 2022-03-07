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
      return if NotificationType.count.positive?

      Notifications::NewUserSignedUpNotification.create! security_roles: [SecurityRole.admin_role]
      Notifications::UserWasApprovedNotification.create! security_roles: [SecurityRole.admin_role]
      Notifications::UserAcceptedInvitationNotification.create! security_roles: [SecurityRole.admin_role]
      Notifications::InvalidDataWasFoundNotification.create! security_roles: [SecurityRole.admin_role]
      Notifications::GlobalValidityRanLongNotification.create! security_roles: [SecurityRole.admin_role]
    end

    def seed_users
      return if User.count.positive?

      display_log 'seeding users'

      seeded_user_config.each do |seeded_user|
        attributes = { email: seeded_user[:email],
                       user_status: user_status,
                       first_name: seeded_user[:first_name],
                       last_name: seeded_user[:last_name],
                       mobile_phone: seeded_user_mobile_phone(seeded_user),
                       timezone: seeded_user[:timezone],
                       security_roles: user_security_roles(seeded_user),
                       authy_enabled: RadicalConfig.authy_enabled? }

        if seeded_user[:trait].present?
          FactoryBot.create seeded_user[:factory], seeded_user[:trait], attributes
        else
          FactoryBot.create seeded_user[:factory], attributes
        end
      end
    end

    def seed_security_roles
      return if SecurityRole.count.positive?

      seed_admin
      seed_user

      return true unless RadicalConfig.external_users?

      seed_portal_admin
      seed_portal_user
    end

    def seed_admin(role_name = 'Admin')
      role = get_role(role_name)
      seed_all role
      role.save!

      NotificationType.all.find_each do |notification_type|
        role.notification_security_roles.create! notification_type: notification_type
      end

      true
    end

    def seed_all(role)
      SecurityRole.permission_fields.each { |item| role.send("#{item}=", true) }
    end

    def seed_user
      role = get_role('User')
      role.save!
    end

    def seed_portal_admin
      role = get_role('Portal Admin')
      role.external = true
      role.save!
    end

    def seed_portal_user
      role = get_role('Portal User')
      role.external = true
      role.save!
    end

    def get_role(name)
      role = SecurityRole.find_or_initialize_by(name: name)

      # init all perms to false
      SecurityRole.permission_fields.each do |field|
        role.send("#{field}=", false)
      end

      role
    end

    def seed_user_statuses
      return if UserStatus.count.positive?

      UserStatus.create! name: 'Pending', active: false, validate_email: true
      UserStatus.create! name: 'Active', active: true, validate_email: true
      UserStatus.create! name: 'Inactive', active: false, validate_email: false
    end

    def seed_company
      return if Company.count.positive?

      FactoryBot.create :company, email: seeded_user_config.first[:email], valid_user_domains: seeded_user_domains
    end

    def seeded_user_config
      RadicalConfig.seeded_users!
    end

    def seeded_user_mobile_phone(seeded_user)
      if (Rails.env.development? || Rails.env.test?) &&
         RadCommon::AppInfo.new.user_requires_mobile_phone? &&
         seeded_user[:mobile_phone].blank?
        return FactoryBot.create(:phone_number, :mobile)
      end

      seeded_user[:mobile_phone]
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

    def admin_user
      first_user_in_role 'Admin'
    end

    def first_user_in_role(name)
      role_by_name(name).users.by_id.first
    end

    def role_by_name(name)
      SecurityRole.find_by!(name: name)
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
