module Pace
  class Base
    delegate :create_object, :find_object, :find_objects, to: :pace_client
    attr_reader :object_data

    def initialize(object_data)
      @object_data = object_data
      @original_object_data = object_data.dup
      load_object
    end

    def self.initialize_from_id(id)
      new(fetch_object_data(id))
    end

    def self.create(attributes)
      pace_client ||= PaceApi::Client.new
      object_data = pace_client.create_object(pace_object_name, attributes)
      new(object_data)
    end

    def self.pace_object_name
      name.demodulize
    end

    def self.pace_object_class
      name.demodulize
    end

    def self.fetch_object_data(id, cached: false)
      pace_client ||= PaceApi::Client.new
      return pace_client.read_object(pace_object_name, id) unless cached

      Rails.cache.fetch(cache_key(id), expires_in: 10.minutes) do
        pace_client.read_object(pace_object_name, id)
      end
    end

    def self.find(id, cached: false)
      new(fetch_object_data(id, cached: cached))
    end

    def self.find_by(attributes = {})
      all.find_by(attributes)
    end

    def self.where(xpath)
      ApiCollection.new(self, xpath, {})
    end

    def self.all
      ApiCollection.new(self, '', {})
    end

    def self.cache_key(id)
      "#{pace_object_name}#{id}"
    end

    def save!
      pace_client.update_object(pace_object_name, updated_object_data)
    end

    private

      def pace_client
        @pace_client ||= PaceApi::Client.new
      end

      def pace_object_name
        self.class.name.demodulize
      end

      def updated_object_data
        data = { id: @original_object_data['id'] }
        @original_object_data.each_key do |key|
          current_value = send(key)
          data[key.to_sym] = current_value if current_value != @original_object_data[key]
        end
        data
      end

      def load_object
        object_data.each do |key, value|
          class_eval "attr_accessor :#{key}", __FILE__, __LINE__ # attr_accessor :pace_field
          send("#{key}=", value)
        end
      end
  end
end
