module RadbearUser
  extend ActiveSupport::Concern

  included do
    attr_accessor :approved_by
    after_save :notify_user_approved
  end

  def company
    Company.main
  end

  def notify_new_user
    User.admins.each do |admin|
      RadbearMailer.new_user_signed_up(admin, self).deliver_later
    end
  end

  def permission?(permission)
    security_roles.where("#{permission} = TRUE").count.positive?
  end

  def auto_approve?
    # override this as needed in model
    false
  end

  def greeting
    "Hello #{first_name}"
  end

  def audits_created(_)
    Audited::Audit.unscoped.where('user_id = ?', id).order('created_at DESC')
  end

  def update_firebase_info(app)
    firebase_user = get_firebase_data(app, firebase_reference)
    return unless firebase_user

    Audited.audit_class.as_user(self) do
      update!(mobile_client_platform: firebase_user['platform'], mobile_client_version: firebase_user['version'], current_device_type: firebase_user['deviceType'])
    end
  end

  def firebase_device_tokens(app)
    response = app.client.get firebase_reference + '/messagingTokens'

    unless response.success?
      raise response.body
    end

    if response.body && response.body.count != 0
      response.body
    else
      []
    end
  end

  private

    def notify_user_approved
      return if auto_approve?
      return unless user_status_id_changed? && user_status && user_status.active && (!respond_to?(:invited_to_sign_up?) || !invited_to_sign_up?)

      RadbearMailer.your_account_approved(self).deliver_later

      User.admins.each do |admin|
        if admin.id != id
          RadbearMailer.user_was_approved(admin, self, approved_by).deliver_later
        end
      end
    end
end
