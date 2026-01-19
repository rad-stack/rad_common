module RadCommon
  class ConfigUpdater
    CONFIG_FILE = 'config/rad_common.yml'.freeze

    def self.add_rad_config_setting(setting_name, default_value)
      standard_config_end = /\n(  system_usage_models:)/
      new_config = "  #{setting_name}: #{default_value}\n\n"

      return if rad_config_setting_exists?(setting_name)

      content = File.read(CONFIG_FILE)
      updated_content = content.gsub(standard_config_end, "#{new_config}\\1")
      File.write(CONFIG_FILE, updated_content)
    end

    def self.rename_rad_config_setting(old_name, new_name)
      return unless rad_config_setting_exists?(old_name)
      return if rad_config_setting_exists?(new_name)

      content = File.read(CONFIG_FILE)
      updated_content = content.gsub(/^(\s*)#{old_name}:/, "\\1#{new_name}:")
      File.write(CONFIG_FILE, updated_content)
    end

    def self.rad_config_setting_exists?(setting_name)
      File.readlines(CONFIG_FILE).grep(/#{setting_name}:/).any?
    end
  end
end
