require 'generators/rspec'

module Rspec
  module Generators
    class ScaffoldGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      argument :attributes, type: :array, default: [], banner: 'field[:type][:index] field[:type][:index]'

      source_root File.expand_path('../../../../templates', __dir__)

      def create_request_spec
        template 'rspec/scaffold/request_spec.rb.tt',
                 File.join('spec/requests', class_path, "#{file_name.pluralize}_spec.rb")
      end

      def create_system_spec
        template 'rspec/system/system_spec.rb.tt',
                 File.join('spec/system', class_path, "#{file_name.pluralize}_spec.rb")
      end

      def create_factory
        template 'factory_bot/factory.rb.tt',
                 File.join('spec/factories', class_path, "#{file_name.pluralize}.rb")
      end

      def create_policy
        template 'pundit/policy.rb.tt',
                 File.join('app/policies', class_path, "#{file_name}_policy.rb")
      end

      private

        def attributes_names
          @attributes_names ||= attributes.reject(&:reference?).map(&:name)
        end
    end
  end
end
