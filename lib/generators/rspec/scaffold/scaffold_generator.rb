require 'generators/rspec'

module Rspec
  module Generators
    class ScaffoldGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      unless ENV['GITHUB_ACTIONS']
        argument :attributes, type: :array, default: [], banner: 'field[:type][:index] field[:type][:index]'

        def self.source_paths
          super + [
            Rails.root.join('lib/templates/rspec/system').to_s,
            Rails.root.join('lib/templates/factory_bot').to_s,
            Rails.root.join('lib/templates/pundit').to_s
          ]
        end

        def create_request_spec
          template 'request_spec.rb.tt',
                   File.join('spec/requests', class_path, "#{file_name.pluralize}_spec.rb")
        end

        def create_system_spec
          template 'system_spec.rb.tt',
                   File.join('spec/system', class_path, "#{file_name.pluralize}_spec.rb")
        end

        def create_factory
          template 'factory.rb.tt',
                   File.join('spec/factories', class_path, "#{file_name.pluralize}.rb")
        end

        def create_policy
          template 'policy.rb.tt',
                   File.join('app/policies', class_path, "#{file_name}_policy.rb")
        end

        private

          def attributes_names
            @attributes_names ||= attributes.reject(&:reference?).map(&:name)
          end
      end
    end
  end
end
