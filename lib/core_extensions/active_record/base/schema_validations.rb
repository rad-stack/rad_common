module CoreExtensions
  module ActiveRecord
    module Base
      module SchemaValidations
        def self.prepended(base)
          base.singleton_class.send(:prepend, ClassMethods)
        end

        module ClassMethods
          def validators
            if name != 'ActiveRecord::Base' && database_exists? && table_exists? && requires_schema_validation_load?
              new.load_schema_validations
            end
            super
          end

          def validators_on(*args)
            new.load_schema_validations if requires_schema_validation_load?
            super
          end

          def database_exists?
            connection
          rescue ::ActiveRecord::NoDatabaseError
            false
          else
            true
          end

          def requires_schema_validation_load?
            defined?(schema_validations_loaded) && !schema_validations_loaded
          end
        end
      end
    end
  end
end
