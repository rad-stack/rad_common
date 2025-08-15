require 'generators/rspec'

module Rspec
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase
      def create_model_spec
        # skip model spec creation
      end
    end
  end
end
