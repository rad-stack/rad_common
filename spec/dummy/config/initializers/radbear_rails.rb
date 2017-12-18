Rails.application.config.assets.precompile += %w[radbear_rails/radbear_mailer.css]

Rails.configuration.enable_facebook = true
Rails.configuration.use_avatar = false

Rails.configuration.global_validity_days = 3
Rails.configuration.global_validity_timeout = 1.hour
Rails.configuration.global_validity_exclude = []
Rails.configuration.global_validity_include = []
Rails.configuration.global_validity_supress = []

Devise.setup do |config|
  config.mailer = 'RadbearDeviseMailer'
end
