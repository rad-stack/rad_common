module RadCommon
  class GlobalValidity
    def self.check_all_companies
      Company.where('validity_checked_at IS NULL OR validity_checked_at <= ?', Rails.application.config.global_validity_days.days.ago).by_id.limit(2).each do |company|
        admins = User.super_admins
        raise 'no super admins are configured' if admins.blank?

        error_messages = company.check_global_validity
        RadbearMailer.global_validity(admins, error_messages).deliver_now if error_messages.any?
        company.global_validity_ran!
      end
    end
  end
end
