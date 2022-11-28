class MergePackageJson
  def self.merge
    binding.pry
    if File.exists? 'custom-dependencies.json'
      custom_dependencies = JSON.parse(File.read('custom-dependencies.json'))
      package = JSON.parse(File.read('../../../../../spec/dummy/package.json'))

      dependencies = package['dependencies']
      dependencies = dependencies.merge(custom_dependencies)
      package['dependencies'] = dependencies
      binding.pry
      File.write('package.json', JSON.pretty_generate(package))
    else
      binding.pry
      copy_file '../../../../../spec/dummy/package.json', 'package.json'
      binding.pry
    end
  end
end
