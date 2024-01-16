namespace :sidekiq do
  task merge_config_file: :environment do
    return unless RadConfig.additional_sidekiq_queues.present? || RadConfig.sidekiq_limits.present?

    config = YAML.load_file(Rails.root.join('config/sidekiq.yml'))
    config[:queues] += RadConfig.additional_sidekiq_queues if RadConfig.additional_sidekiq_queues.present?
    config[:limits] = RadConfig.sidekiq_limits if RadConfig.sidekiq_limits.present?

    merged_config_path = Rails.root.join('tmp/sidekiq_merged_config.yml')
    File.write(merged_config_path, config.to_yaml)
  end
end
