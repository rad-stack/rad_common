module RadbearUser
  extend ActiveSupport::Concern

  included do
    has_many :notification_settings, dependent: :destroy
    has_many :system_messages, dependent: :destroy
    has_many :notifications, dependent: :destroy

    attr_accessor :approved_by, :do_not_notify_approved

    scope :by_permission, ->(permission_attr) { joins(:security_roles).where("#{permission_attr} = TRUE").active.distinct }
    scope :inactive, -> { joins(:user_status).where('user_statuses.active = FALSE OR (invitation_sent_at IS NOT NULL AND invitation_accepted_at IS NULL)') }
    scope :internal, -> { where(external: false) }
    scope :external, -> { where(external: true) }

    validate :validate_email_address
    validate :validate_sms_mobile_phone, on: :update

    before_validation :set_timezone, on: :create
    after_save :notify_user_approved
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

  def audits_created(_user)
    Audited::Audit.unscoped.where('user_id = ?', id).order('created_at DESC')
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

  private

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

    def set_timezone
      self.timezone = Company.main.timezone if new_record? && timezone.blank?
    end

    def notify_user_approved
      return if auto_approve?

      return unless saved_change_to_user_status_id? && user_status &&
                    user_status.active && (!respond_to?(:invited_to_sign_up?) || !invited_to_sign_up?)

      RadbearMailer.your_account_approved(self).deliver_later
      Notifications::UserWasApprovedNotification.new.notify!([self, approved_by]) unless do_not_notify_approved
    end

    def notify_user_accepted
      Notifications::UserAcceptsInvitationNotification.new.notify!(self)
    end
end
