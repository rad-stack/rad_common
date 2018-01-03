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
