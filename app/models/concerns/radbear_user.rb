module RadbearUser
  extend ActiveSupport::Concern

  USER_AUDIT_COLUMNS_DISABLED = %i[password password_confirmation encrypted_password reset_password_token
                                   confirmation_token authentication_token unlock_token].freeze

  included do
    belongs_to :user_status

    has_many :notification_settings, dependent: :destroy
    has_many :system_messages, dependent: :destroy
    has_many :notifications, dependent: :destroy
    has_many :security_roles_users, dependent: :destroy
    has_many :security_roles, through: :security_roles_users, dependent: :destroy

    has_one_attached :avatar

    attr_accessor :approved_by, :do_not_notify_approved

    scope :active, -> { joins(:user_status).where('user_statuses.active = TRUE') }
    scope :admins, -> { active.where('users.id IN (SELECT user_id FROM security_roles_users INNER JOIN security_roles ON security_roles_users.security_role_id = security_roles.id WHERE security_roles.admin = TRUE)') }
    scope :pending, -> { where(user_status_id: UserStatus.default_pending_status.id) }
    scope :by_name, -> { order(:first_name, :last_name) }
    scope :with_mobile_phone, -> { where.not(mobile_phone: ['', nil]) }
    scope :without_mobile_phone, -> { where(mobile_phone: ['', nil]) }
    scope :recent_first, -> { order('users.created_at DESC') }
    scope :by_permission, ->(permission_attr) { joins(:security_roles).where("#{permission_attr} = TRUE").active.distinct }
    scope :inactive, -> { joins(:user_status).where('user_statuses.active = FALSE OR (invitation_sent_at IS NOT NULL AND invitation_accepted_at IS NULL)') }
    scope :internal, -> { where(external: false) }
    scope :external, -> { where(external: true) }

    validate :validate_email_address
    validate :validate_sms_mobile_phone, on: :update
    validate :password_excludes_name

    validates_with PhoneNumberValidator, fields: [:mobile_phone]
    validates_with TwilioPhoneValidator, fields: [{ field: :mobile_phone, type: :mobile }]

    before_validation :check_defaults
    before_validation :set_timezone, on: :create
    after_save :notify_user_approved

    after_invitation_accepted :notify_user_accepted
  end

  def to_s
    "#{first_name} #{last_name}"
  end

  def active
    active_for_authentication?
  end

  def formatted_email
    "\"#{self}\" <#{email}>"
  end

  def internal?
    !external?
  end

  def permission?(permission)
    security_roles.select { |x| x[permission] }.length.positive?
  end

  def permission_or_pending?(permission)
    if persisted?
      permission?(permission)
    else
      security_roles.collect.pluck(permission).include?(true)
    end
  end

  def all_permissions
    permissions = []

    security_roles.each do |role|
      permissions += role.permission_attributes.to_a.select { |item| item[1] }.to_h.keys
    end

    permissions
  end

  def admin?
    permission?(:admin)
  end

  def auto_approve?
    # override this as needed in model
    false
  end

  def greeting
    "Hello #{first_name}"
  end

  def audits_created
    Audited::Audit.where(user_id: id).order(created_at: :desc)
  end

  def update_firebase_info
    firebase_user = get_firebase_data(firebase_reference)
    return unless firebase_user

    Audited.audit_class.as_user(self) do
      update!(mobile_client_platform: firebase_user['platform'],
              mobile_client_version: firebase_user['version'],
              current_device_type: firebase_user['deviceType'])
    end
  end

  def firebase_device_tokens(app)
    response = RadicalRetry.perform_request { app.client.get(firebase_reference + '/messagingTokens') }
    raise response.raw_body unless response.success?

    if response.body && response.body.count != 0
      response.body
    else
      []
    end
  end

  def display_style
    if user_status.active || user_status == UserStatus.default_pending_status
      external? ? 'table-warning' : ''
    else
      'table-danger'
    end
  end

  def portal?
    external? && RadCommon.portal_namespace.present?
  end

  def read_notifications!
    notifications.unread.update_all unread: false
  end

  def active_for_authentication?
    super && user_status && user_status.active
  end

  def inactive_message
    if !user_status.active
      :not_approved
    else
      super
    end
  end

  def send_devise_notification(notification, *args)
    # background devise emails
    # https://github.com/plataformatec/devise#activejob-integration

    devise_mailer.send(notification, self, *args).deliver_later
  end

  def send_reset_password_instructions
    if invited_to_sign_up?
      errors.add :email, :not_found
    else
      super
    end
  end

  private

    def check_defaults
      status = auto_approve? ? UserStatus.default_active_status : UserStatus.default_pending_status
      self.user_status = status if new_record? && !user_status
    end

    def validate_email_address
      return if email.blank? || user_status_id.nil? || !user_status.validate_email || external? || Company.main.blank?

      domains = Company.main.valid_user_domains
      components = email.split('@')
      return if components.count == 2 && domains.include?(components[1])

      errors.add(:email, 'is not authorized for this application, please contact the system administrator')
    end

    def validate_sms_mobile_phone
      return if !RadicalTwilio.twilio_enabled? || mobile_phone.present?
      return if notification_settings.enabled.where(sms: true).count.zero?

      errors.add(:mobile_phone, 'is required when SMS notification settings are enabled')
    end

    def password_excludes_name
      return unless password.present? && first_name.present? && last_name.present?

      if password.downcase.include?(first_name.downcase) || password.downcase.include?(last_name.downcase)
        errors.add(:password, 'cannot contain your name')
      end
    end

    def set_timezone
      self.timezone = Company.main.timezone if new_record? && timezone.blank?
    end

    def notify_user_approved
      return if auto_approve?

      return unless saved_change_to_user_status_id? && user_status &&
                    user_status.active && (!respond_to?(:invited_to_sign_up?) || !invited_to_sign_up?)

      RadbearMailer.your_account_approved(self).deliver_later
      Notifications::UserWasApprovedNotification.main.notify!([self, approved_by]) unless do_not_notify_approved
    end

    def notify_user_accepted
      Notifications::UserAcceptedInvitationNotification.main.notify!(self)
    end
end
