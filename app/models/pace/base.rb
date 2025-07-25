module Pace
  class Base
    delegate :create_object, :find_object, :find_objects, to: :pace_client
    attr_reader :object_data

    def initialize(object_data)
      @object_data = object_data
      load_object
      puts 'done'
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

    def self.fetch_object_data(id)
      pace_client ||= PaceApi::Client.new
      Rails.cache.fetch(cache_key(id), expires_in: 10.minutes) do
        pace_client.read_object(pace_object_name, id)
      end
    end

    def self.find(id)
      new(fetch_object_data(id))
    end

    def self.where(xpath)
      ApiCollection.new(self, xpath)
    end

    def self.all
      ApiCollection.new(self, '')
    end

    def self.cache_key(id)
      "#{pace_object_name}#{id}"
    end

    def save!
      update_object_data
      pace_client.update_object(pace_object_name, object_data)
    end

    private

      def pace_client
        @pace_client ||= PaceApi::Client.new
      end

      def pace_object_name
        self.class.name.demodulize
      end

      def update_object_data
        object_data.each do |key, _value|
          object_data[key] = send(key)
        end
      end

      def load_object
        object_data.each do |key, value|
          class_eval "attr_accessor :#{key}", __FILE__, __LINE__ # attr_accessor :pace_field
          send("#{key}=", value)
        end
      end
  end
end
