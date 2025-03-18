class RadFactories
  def self.load!
    rad_factories = "#{Gem.loaded_specs['rad_common'].full_gem_path}/spec/factories/rad_common"
    Dir["#{rad_factories}/*.rb"].each do |factory_file|
      factory_name = File.basename(factory_file, '.rb')
      next if FactoryBot.factories.registered?(factory_name.singularize.to_sym)

      require factory_file
    end
  end
end
