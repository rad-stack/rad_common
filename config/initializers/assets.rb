return if RadConfig.react_app?

Rails.application.config.assets.paths << Rails.root.join('app/assets/builds')
Rails.application.config.assets.excluded_paths << Rails.root.join('app/assets/scss')
Rails.application.config.assets.paths << Rails.root.join('node_modules/@fortawesome/fontawesome-free/webfonts')

if Rake::Task.task_defined?('assets:precompile')
  Rake::Task['assets:precompile'].enhance do
    assembly = Rails.application.assets
    output_path = assembly.config.output_path

    assembly.load_path.assets.each do |asset|
      next unless asset.logical_path.to_s.end_with?('.css', '.js')

      asset_path = output_path.join(asset.digested_path)
      compressed_path = output_path.join("#{asset.digested_path}.gz")

      next if compressed_path.exist?

      Rails.logger.info "Compressing #{asset.digested_path}"

      Zlib::GzipWriter.open(compressed_path, Zlib::BEST_COMPRESSION) do |gz|
        gz.mtime = File.mtime(asset_path)
        gz.orig_name = asset_path.basename.to_s
        gz.write File.binread(asset_path)
      end
    end
  end
end
