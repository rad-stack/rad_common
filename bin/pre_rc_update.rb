#!/usr/bin/env ruby

require_relative '../lib/rad_common/config_updater'

RadCommon::ConfigUpdater.add_rad_config_setting 'action_cable_enabled', 'false'
RadCommon::ConfigUpdater.add_rad_config_setting 'expire_password_after_days', '90'
RadCommon::ConfigUpdater.rename_rad_config_setting 'twilio_verify_enabled', 'two_factor_auth_enabled'

RadCommon::ConfigUpdater.rename_rad_config_setting 'twilio_verify_remember_device_days',
                                                   'two_factor_remember_device_days'

RadCommon::ConfigUpdater.rename_rad_config_setting 'twilio_verify_all_users', 'two_factor_auth_all_users'
