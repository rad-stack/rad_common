module RadbearUser
  extend ActiveSupport::Concern

  included do
    attr_accessor :approved_by

    validate :validate_authy

    before_validation :maybe_update_authy
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
      response.body || []
    else
      []
    end
  end

  private

    def validate_authy
      if authy_enabled
        if Rails.application.config.authy_user_opt_in && mobile_phone.blank?
          errors.add(:mobile_phone, 'is required two factor authentication')
          return
        end

        if authy_id.present? && mobile_phone.present?
          # ok
        elsif authy_id.blank? && mobile_phone.blank?
          # ok
        else
          errors.add(:base, 'user is not two factor authentication')
        end
      else
        errors.add(:base, 'user is not two factor authentication') if authy_id.present?
      end
    end

    def maybe_update_authy
      return unless ENV['AUTHY_API_KEY'].present? && (authy_enabled_changed? || mobile_phone_changed?)

      # delete the authy user if it exists
      if authy_id.present?
        response = Authy::API.user_status(id: authy_id)

        if response.ok?
          response = Authy::API.delete_user(id: authy_id)
          if response.ok?
            self.authy_id = nil
          else
            errors.add(:base, "Could not remove authy user: #{response.message}")
            throw :abort
          end
        else
          self.authy_id = nil
        end
      end

      return unless authy_enabled? && mobile_phone.present? && email.present?

      # create the authy user if applicable
      response = Authy::API.register_user(email: email, country_code: '1', cellphone: mobile_phone)

      if response.ok?
        self.authy_id = response.id
      else
        errors.add(:base, "Could not register authy user: #{response.message}")
        throw :abort
      end
    end

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
