require "#{Gem::Specification.find_by_name('rad_common').gem_dir}/lib/core_extensions/active_record/base/schema_validations"
ActiveRecord::Base.prepend CoreExtenions::ActiveRecord::Base::SchemaValidations
