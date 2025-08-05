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
    end
  end
end
