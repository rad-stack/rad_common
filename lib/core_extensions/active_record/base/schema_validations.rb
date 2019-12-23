module CoreExtensions
  module ActiveRecord
    module Base
      module SchemaValidations
        def self.prepended(base)
          base.singleton_class.send(:prepend, ClassMethods)
        end

        module ClassMethods
          def validators
            new.load_schema_validations if database_exists? && table_exists? && !schema_validations_loaded
            super
          end

          def validators_on(*args)
            new.load_schema_validations unless schema_validations_loaded
            super
          end

          def database_exists?
            connection
          rescue ::ActiveRecord::NoDatabaseError
            false
          else
            true
          end
        end
      end
    end
  end
end
