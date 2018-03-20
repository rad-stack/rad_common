namespace :rad_common do
  task global_validity: :environment do
    Timeout.timeout(Rails.application.config.global_validity_timeout) do
      RadCommon::GlobalValidity.check_all_companies
    end
  end

  task redo_authy: :environment do
    Timeout.timeout(1.hour) do
      User.where(authy_enabled: true).find_each do |user|
        user.update!(authy_enabled: false)
        user.update!(authy_enabled: true)
        sleep 2 # avoid DDOS throttling
      end
    end
  end
end
