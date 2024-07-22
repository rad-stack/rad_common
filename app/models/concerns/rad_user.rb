module RadUser
  extend ActiveSupport::Concern

  USER_AUDIT_COLUMNS_DISABLED = %i[password password_confirmation encrypted_password reset_password_token
                                   confirmation_token unlock_token remember_created_at].freeze

  included do
    belongs_to :user_status

    has_many :notification_settings, dependent: :destroy
    has_many :system_messages, dependent: :destroy
    has_many :notifications, dependent: :destroy
    has_many :user_security_roles, dependent: :destroy
    has_many :security_roles, through: :user_security_roles, dependent: :destroy
    has_many :login_activities, as: :user, dependent: :destroy
    has_many :user_clients, dependent: :destroy
    has_many :clients, through: :user_clients, source: :client
    has_many :saved_search_filters, dependent: :destroy

    has_many :contact_logs_from, class_name: 'ContactLog',
                                 foreign_key: 'from_user_id',
                                 dependent: :destroy,
                                 inverse_of: :from_user

    has_many :contact_logs_to, class_name: 'ContactLogRecipient',
                               foreign_key: 'to_user_id',
                               dependent: :destroy,
                               inverse_of: :to_user

    has_one_attached :avatar

    enum language: { English: 'en', Spanish: 'es' }

    attr_accessor :approved_by, :do_not_notify_approved, :initial_security_role_id

    scope :active, -> { joins(:user_status).where(user_statuses: { active: true }) }
    scope :admins, -> { active.by_permission 'admin' }
    scope :pending, -> { where(user_status_id: UserStatus.default_pending_status.id) }
    scope :by_id, -> { order(:id) }
    scope :with_mobile_phone, -> { where.not(mobile_phone: ['', nil]) }
    scope :without_mobile_phone, -> { where(mobile_phone: ['', nil]) }
    scope :recent_first, -> { order('users.created_at DESC') }
    scope :recent_last, -> { order('users.created_at') }
    scope :except_user, ->(user) { where.not(id: user.id) }

    scope :sorted, lambda {
      if RadConfig.last_first_user?
        order(:last_name, :first_name)
      else
        order(:first_name, :last_name)
      end
    }

    scope :by_permission, lambda { |permission|
      raise "missing permission column: #{permission}" unless RadPermission.exists?(permission)

      where('users.id IN (' \
            'SELECT user_id FROM user_security_roles ' \
            'INNER JOIN security_roles ON user_security_roles.security_role_id = security_roles.id ' \
            "WHERE security_roles.#{permission} = TRUE)")
    }

    scope :inactive, lambda {
      joins(:user_status)
        .where('user_statuses.active = FALSE OR (invitation_sent_at IS NOT NULL AND invitation_accepted_at IS NULL)')
    }

    scope :not_inactive, -> { where.not(user_status_id: UserStatus.default_inactive_status.id) }
    scope :internal, -> { where(external: false) }
    scope :external, -> { where(external: true) }

    validate :validate_email_address
    validate :validate_internal, on: :update
    validate :validate_twilio_verify
    validate :validate_mobile_phone
    validate :password_excludes_name
    validates :security_roles, presence: true, if: :active?

    validates :avatar, content_type: { in: RadCommon::VALID_IMAGE_TYPES,
                                       message: RadCommon::VALID_CONTENT_TYPE_MESSAGE }

    validates_with PhoneNumberValidator, fields: [{ field: :mobile_phone, type: :mobile }],
                                         if: :fully_validate_email_phone?

    validates_with EmailAddressValidator, fields: %i[email], if: :fully_validate_email_phone?

    after_initialize :twilio_verify_default, if: :new_record?
    before_validation :check_defaults
    before_validation :set_timezone, on: :create
    after_commit :notify_user_approved, only: :update
    after_invitation_accepted :notify_user_accepted

    strip_attributes
  end

  def to_s
    if RadConfig.last_first_user?
      "#{last_name}, #{first_name}"
    else
      "#{first_name} #{last_name}"
    end
  end

  def active?
    active_for_authentication?
  end

  def needs_confirmation?
    RadConfig.user_confirmable? && !confirmed? && !needs_accept_invite?
  end

  def needs_accept_invite?
    invitation_sent_at.present? && invitation_accepted_at.blank?
  end

  def needs_reactivate?
    RadConfig.user_expirable? && expired?
  end

  def stale?
    updated_at < 4.months.ago
  end

  def not_inactive?
    user_status != UserStatus.default_inactive_status
  end

  def formatted_email
    "\"#{self}\" <#{email}>"
  end

  def internal?
    !external?
  end

  def permission?(permission)
    raise "missing permission column: #{permission}" unless RadPermission.exists?(permission)

    security_roles.select { |x| x[permission] }.length.positive?
  end

  def permission_or_pending?(permission)
    if persisted?
      permission?(permission)
    else
      security_roles.collect.pluck(permission).include?(true)
    end
  end

  def admin?
    permission?(:admin)
  end

  def greeting
    "Hello #{first_name}"
  end

  def audits_created
    Audited::Audit.where(user_id: id).order(created_at: :desc)
  end

  def other_audits_created
    audits_created.where.not(auditable_id: id).where.not(auditable_type: 'User')
  end

  def display_style
    if user_status.active? || (RadConfig.pending_users? && user_status == UserStatus.default_pending_status)
      external? ? 'table-warning' : ''
    else
      'table-danger'
    end
  end

  def read_notifications!
    notifications.unread.update_all unread: false
  end

  def active_for_authentication?
    super && user_status && user_status.active?
  end

  def inactive_message
    if user_status.active?
      super
    else
      :not_approved
    end
  end

  def notify_new_user_signed_up
    Notifications::NewUserSignedUpNotification.main(self).notify!
  end

  def send_devise_notification(notification, *args)
    # background devise emails
    # https://github.com/plataformatec/devise#activejob-integration

    devise_mailer.send(notification, self, *args).deliver_later
  end

  def send_reset_password_instructions
    if needs_accept_invite?
      Notifications::UserHasOpenInvitationNotification.main(user: self, method_name: __method__).notify!
      return
    end

    super
  end

  def pending_any_confirmation
    if needs_accept_invite?
      Notifications::UserHasOpenInvitationNotification.main(user: self, method_name: __method__).notify!
      return
    end

    super
  end

  def test_email!
    RadMailer.simple_message(self, 'Test Email', 'This is a test.').deliver_later
  end

  def test_sms!(from_user)
    UserSMSSenderJob.perform_later 'Test SMS', from_user.id, id, nil, false
  end

  def reactivate
    update(last_activity_at: nil)
  end

  def locale
    User.languages[language]
  end

  # TODO: this should be a db attribute when we enable the TOTP feature
  def twilio_totp_factor_sid; end

  def timeout_in
    external? ? Devise.timeout_in : RadConfig.timeout_hours!.hours
  end

  private

    def twilio_verify_default
      self.twilio_verify_enabled = RadConfig.twilio_verify_enabled? && (RadConfig.twilio_verify_all_users? || admin?)
    end

    def check_defaults
      if security_roles.none? && initial_security_role_id.present?
        self.security_roles = [initial_security_role]
        self.external = initial_security_role.external?
      elsif security_roles.any?
        self.external = security_roles.first.external
      end

      self.user_status = default_user_status if new_record? && !user_status
    end

    def default_user_status
      return UserStatus.default_active_status unless RadConfig.pending_users?
      return UserStatus.default_active_status if invited_by.present?

      UserStatus.default_pending_status
    end

    def initial_security_role
      SecurityRole.find(initial_security_role_id)
    end

    def fully_validate_email_phone?
      user_status&.validate_email_phone?
    end

    def validate_email_address
      return if email.blank? || user_status_id.nil? || !user_status.validate_email_phone? || Company.main.blank?

      domains = Company.main.valid_user_domains
      components = email.split('@')
      match_domains = components.count == 2 && domains.include?(components[1])
      return if (internal? && match_domains) || (external? && !match_domains)

      errors.add(:email, 'is not authorized for this application, please contact the system administrator')
    end

    def validate_internal
      return if external? || user_clients.none?

      errors.add :external, 'not allowed when clients are assigned to this user'
    end

    def validate_twilio_verify
      return unless RadConfig.twilio_verify_enabled?
      return if twilio_verify_enabled?
      return unless RadConfig.twilio_verify_all_users? || admin?

      errors.add(:twilio_verify_enabled, 'is required')
    end

    def validate_mobile_phone
      return if mobile_phone.present? || user_status.blank? || !user_status.validate_email_phone?

      if RadConfig.require_mobile_phone?
        errors.add(:mobile_phone, "can't be blank")
      elsif require_mobile_phone_sms?
        errors.add(:mobile_phone, 'is required when SMS notification settings are enabled')
      elsif require_mobile_phone_two_factor?
        errors.add(:mobile_phone, 'is required for two factor authentication')
      end
    end

    def require_mobile_phone_sms?
      RadConfig.twilio_enabled? && persisted? && notification_settings.enabled.where(sms: true).count.positive?
    end

    def require_mobile_phone_two_factor?
      RadConfig.twilio_verify_enabled? && twilio_verify_enabled?
    end

    def password_excludes_name
      return if new_record? && invited_by_id.present?
      return unless password.present? && first_name.present? && last_name.present?
      return unless password.downcase.include?(first_name.downcase) || password.downcase.include?(last_name.downcase)

      errors.add(:password, 'cannot contain your name')
    end

    def set_timezone
      self.timezone = Company.main.timezone if new_record? && timezone.blank?
    end

    def notify_user_approved
      return unless RadConfig.pending_users?
      return if invited_to_sign_up?

      return unless user_status_id_previously_changed?(from: UserStatus.default_pending_status.id,
                                                       to: UserStatus.default_active_status.id)

      notify_user_approved_user
      notify_user_approved_admins
    end

    def notify_user_approved_user
      RadMailer.your_account_approved(self).deliver_later
    end

    def notify_user_approved_admins
      return if do_not_notify_approved

      Notifications::UserWasApprovedNotification.main([self, approved_by]).notify!
    end

    def notify_user_accepted
      Notifications::UserAcceptedInvitationNotification.main(self).notify!
    end
end
