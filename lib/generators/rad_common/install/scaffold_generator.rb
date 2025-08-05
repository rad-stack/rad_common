require 'generators/rspec'

module Rspec
  module Generators
    class ScaffoldGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

      def create_request_spec
        template Rails.root.join('lib/templates/rspec/scaffold/request_spec.rb.tt'),
                 File.join('spec/requests', class_path, "#{file_name.pluralize}_spec.rb")
      end

      def create_system_spec
        template Rails.root.join('lib/templates/rspec/system/system_spec.rb.tt'),
                 File.join('spec/system', class_path, "#{file_name.pluralize}_spec.rb")
      end

      def create_factory
        template Rails.root.join('lib/templates/factory_bot/factory.rb.tt'),
                 File.join('spec/factories', class_path, "#{file_name.pluralize}.rb")
      end

      def create_policy
        template Rails.root.join('lib/templates/pundit/policy.rb.tt'),
                 File.join('app/policies', class_path, "#{file_name}.rb")
      end

      def create_policy_spec
        template Rails.root.join('lib/templates/pundit/policy_spec.rb.tt'),
                 File.join('spec/policies', class_path, "#{file_name}_policy_spec.rb")
      end

      private

        def attributes_names
          @attributes_names ||= attributes.reject(&:reference?).map(&:name)
        end
      
        def policy_methods
          %w[index? show? create? new? update? edit? destroy?]
        end
    end
  end
end
