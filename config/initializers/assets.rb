Rails.application.config.assets.paths << Rails.root.join('app/assets/builds')
Rails.application.config.assets.excluded_paths << Rails.root.join('app/assets/scss')
Rails.application.config.assets.paths << Rails.root.join('node_modules/@fortawesome/fontawesome-free/webfonts')
