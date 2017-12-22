namespace :rad_common do
  task global_validity: :environment do
    Timeout.timeout(Rails.application.config.global_validity_timeout) do
      RadCommon::GlobalValidity.check_all_companies
    end
  end
end
