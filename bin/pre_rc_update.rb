#!/usr/bin/env ruby

require_relative '../lib/rad_common/config_updater'

RadCommon::ConfigUpdater.add_rad_config_setting('action_cable_enabled', 'false')
RadCommon::ConfigUpdater.add_rad_config_setting('expire_password_after_days', '90')
