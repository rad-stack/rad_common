module RadCommon
  class GlobalValidity
    def self.check_company
      company = Company.main

      return unless company.validity_checked_at.blank? ||
                    company.validity_checked_at <= Rails.application.config.global_validity_days.days.ago

      admins = User.super_admins
      raise 'no super admins are configured' if admins.blank?

      error_messages = company.check_global_validity
      RadbearMailer.global_validity(admins, error_messages).deliver_now if error_messages.any?
      company.global_validity_ran!
    end
  end
end
