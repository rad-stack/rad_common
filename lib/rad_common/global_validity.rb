module RadCommon
  class GlobalValidity
    def self.check_all_companies
      Company.where('validity_checked_at IS NULL OR validity_checked_at <= ?', Rails.application.config.global_validity_days.days.ago).by_id.limit(2).each do |company|
        error_messages = company.check_global_validity

        if error_messages.any?
          User.super_admins.each { |super_admin| RadbearMailer.global_validity(company, super_admin, error_messages).deliver_later }
        end

        company.update_column(:validity_checked_at, DateTime.now)
      end
    end
  end
end
