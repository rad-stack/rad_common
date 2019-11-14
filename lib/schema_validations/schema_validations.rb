require 'schema_validations/validators/not_nil_validator'
require 'schema_validations/active_record/validations'
require 'schema_validations/active_record/type'

module SchemaValidations

  # The configuation options for SchemaValidations. Set them globally in
  # <tt>config/initializers/schema_validations.rb</tt>, e.g.:
  #
  #    SchemaValidations.setup do |config|
  #       config.auto_create = false
  #    end
  #
  # or override them per-model, e.g.:
  #
  #     class MyModel < ActiveRecord::Base
  #        schema_validations :only => [:name, :active]
  #     end
  #
  class Config

    def dup #:nodoc:
      self.class.new(Hash[attributes.collect{ |key, val| [key, Valuable === val ?  val.class.new(val.attributes) : val] }])
    end

    def update_attributes(opts)#:nodoc:
      opts = opts.dup
      opts.keys.each { |key| self.send(key).update_attributes(opts.delete(key)) if self.class.attributes.include? key and Hash === opts[key] }
      super(opts)
      self
    end

    def merge(opts)#:nodoc:
      dup.update_attributes(opts)
    end

  end

  # Returns the global configuration, i.e., the singleton instance of Config
  def self.config
    @config ||= Config.new
  end

  def self.setup # :yields: config
    yield config
  end

end

SchemaMonkey.register SchemaValidations
