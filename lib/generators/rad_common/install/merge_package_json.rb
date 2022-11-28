class MergePackageJson
  def self.merge
    binding.pry
    if File.exists? 'custom-dependencies.json'
      custom_dependencies = JSON.parse(File.read('custom-dependencies.json'))
      package_file = File.expand_path(find_in_source_paths('../../../../../spec/dummy/package.json'))
      package = JSON.parse(File.read(package_file))

      dependencies = package['dependencies']
      dependencies = dependencies.merge(custom_dependencies)
      package['dependencies'] = dependencies
      File.write('package.json', JSON.pretty_generate(package))
    else
      copy_file '../../../../../spec/dummy/package.json', 'package.json'
    end
  end
end
