#!/usr/bin/env ruby

require_relative '../lib/rad_common/config_updater'

RadCommon::ConfigUpdater.add_rad_config_setting 'last_first_user', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'timezone_detection', 'true'
RadCommon::ConfigUpdater.add_rad_config_setting 'portal', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'validate_user_domains', 'true'
RadCommon::ConfigUpdater.add_rad_config_setting 'show_sign_in_marketing', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'filter_toggle_default_behavior', 'always_open'
RadCommon::ConfigUpdater.add_rad_config_setting 'action_cable_enabled', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'expire_password_after_days', '90'
RadCommon::ConfigUpdater.add_rad_config_setting 'two_factor_auth_email_fallback', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'mailer_phone_number', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'additional_user_registration_params', '[]'
RadCommon::ConfigUpdater.add_rad_config_setting 'clone_local_exclude', '[]'
RadCommon::ConfigUpdater.add_rad_config_setting 'crawlable_subdomains', '[]'
RadCommon::ConfigUpdater.add_rad_config_setting 'always_crawl', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'allow_crawling', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'procfile_override', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'database_config_override', 'false'
RadCommon::ConfigUpdater.rename_rad_config_setting 'twilio_verify_enabled', 'two_factor_auth_enabled'

RadCommon::ConfigUpdater.rename_rad_config_setting 'twilio_verify_remember_device_days',
                                                   'two_factor_remember_device_days'

RadCommon::ConfigUpdater.rename_rad_config_setting 'twilio_verify_all_users', 'two_factor_auth_all_users'

devise_initializer = 'config/initializers/devise.rb'

if File.exist?(devise_initializer)
  content = File.read(devise_initializer)

  if content.include?('RadConfig.twilio_verify_remember_device!')
    content.gsub!('RadConfig.twilio_verify_remember_device!', 'RadConfig.two_factor_remember_device!')
    File.write(devise_initializer, content)
  end
end
