module RadbearUser
  extend ActiveSupport::Concern

  included do
    attr_accessor :approved_by
    scope :by_permission, ->(permission_attr) { joins(:security_roles).where("#{permission_attr} = TRUE").active.distinct }

    validate :validate_email_address
    validate :validate_super_admin

    after_save :notify_user_approved
  end

  def notify_new_user
    User.admins.each do |admin|
      RadbearMailer.new_user_signed_up(admin, self).deliver_later
    end
  end

  def permission?(permission)
    security_roles.where("#{permission} = TRUE").count.positive?
  end

  def all_permissions
    permissions = []

    security_roles.each do |role|
      permissions += role.permission_attributes.to_a.reject { |item| !item[1] }.to_h.keys
    end

    permissions
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
    response = app.client.get firebase_reference + '/messagingTokens'
    raise response.raw_body unless response.success?

    if response.body && response.body.count != 0
      response.body
    else
      []
    end
  end

  private

    def validate_email_address
      return if email.blank? || user_status_id.nil? || !user_status.validate_email

      domains = Company.main.valid_user_domains
      components = email.split('@')
      return if components.count == 2 && domains.include?(components[1])

      errors.add(:email, 'is not authorized for this application, please contact the system administrator')
    end

    def validate_super_admin
      return unless super_admin

      errors.add(:super_admin, 'can only be enabled for an admin') unless permission?(:admin)
    end

    def notify_user_approved
      return if auto_approve?

      return unless saved_change_to_user_status_id? && user_status &&
                    user_status.active && (!respond_to?(:invited_to_sign_up?) || !invited_to_sign_up?)

      RadbearMailer.your_account_approved(self).deliver_later

      User.admins.each do |admin|
        RadbearMailer.user_was_approved(admin, self, approved_by).deliver_later if admin.id != id
      end
    end
end
