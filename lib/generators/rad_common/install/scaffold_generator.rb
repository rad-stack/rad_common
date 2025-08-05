require 'generators/rspec'

module Rspec
  module Generators
    class ScaffoldGenerator < Base
      def create_request_spec
        template Rails.root.join('lib/templates/rspec/scaffold/request_spec.rb.tt'),
                 File.join('spec/requests', class_path, "#{file_name.pluralize}_spec.rb")
      end

      def create_system_spec
        template Rails.root.join('lib/templates/rspec/system/system_spec.rb.tt'),
                 File.join('spec/system', class_path, "#{file_name.pluralize}_spec.rb")
      end

      def create_factory
        if defined?(FactoryBot)
          template Rails.root.join('lib/templates/factory_bot/factory.rb.tt'),
                   File.join('spec/factories', class_path, "#{file_name.pluralize}.rb")
        end
      end

      def create_policy
        if defined?(Pundit)
          template Rails.root.join('lib/templates/pundit/policy.rb.tt'),
                   File.join('app/policies', class_path, "#{file_name}.rb")
        end
      end
    
      def create_policy_spec
        if defined?(Pundit)
          template Rails.root.join('lib/templates/pundit/policy_spec.rb.tt'),
                   File.join('spec/policies', class_path, "#{file_name}.rb")
        end
      end
    end
  end
end
