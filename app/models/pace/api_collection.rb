module Pace
  class ApiCollection
    attr_reader :object_class, :xpath, :page_size, :page_number,
                :sort_xpath, :sort_direction, :limit, :selected_attributes

    delegate :count, :first, :each, :group_by, :sum,  to: :to_a

    def initialize(object_class, xpath, options)
      default_options = {  limit: 1000, page_size: nil, page_number: nil,
                           sort_xpath: nil, sort_direction: 'asc', selected_attributes: [] }
      @options = default_options.merge(options)
      @object_class = object_class
      @xpath = xpath
      @limit = @options[:limit]
      @page_size = @options[:page_size]
      @page_number = @options[:page_number]
      @sort_xpath = @options[:sort_xpath]
      @sort_direction = @options[:sort_direction]
      @selected_attributes = @options[:selected_attributes]
    end

    def find(id)
      raise ArgumentError, 'ID must be provided' if id.blank?

      if xpath.present?
        id_xpath = "@id = #{id}"
        full_xpath = [xpath, id_xpath].compact.join(' and ')

        ids = pace_client.find_objects(
          object_class.pace_object_name,
          full_xpath,
          page_size: 1,
          page_number: 1,
          sort: [{ xpath: '@id', descending: false }]
        )

        raise ActiveRecord::RecordNotFound, "Record not found with id: #{id}" if ids.blank?

        id = ids.first
      end

      object_class.new(pace_client.read_object(object_class.pace_object_name, id))
    end

    def find_by(attributes = {})
      return nil if attributes.blank?

      xpath_conditions = attributes.map { |key, value|
        value = "'#{value}'" if value.is_a?(String)
        "@#{key} = #{value}"
      }.join(' and ')
      full_xpath = [xpath, xpath_conditions].compact_blank.join(' and ')
      id = pace_client.find_object(object_class.pace_object_name, full_xpath)

      return nil if id.blank?

      object_class.new(pace_client.read_object(object_class.pace_object_name, id))
    end

    def where(extra_xpath)
      build(xpath: [xpath, extra_xpath].compact.join(' and '))
    end

    def select(attrs)
      build(selected_attributes: selected_attributes + attrs)
    end

    def order(xpath, direction = 'asc')
      build(sort_xpath: xpath, sort_direction: direction)
    end

    def page_and_sort(page:, sort_xpath: nil, sort_direction: 'asc')
      page(page).order(sort_xpath, sort_direction)
    end

    def page(num)
      build(page_number: num || 1, page_size: page_size || 25)
    end

    def per(size)
      build(page_size: size)
    end

    def total_pages
      return 1 unless page_size

      (total_count.to_f / page_size).ceil
    end

    def total_count
      paging_info['totalRecords']
    end

    def current_page
      page_number.to_i
    end

    def offset
      return 0 if current_page <= 1

      (current_page * page_size) - 1
    end

    def limit_value
      page_size
    end

    def to_a
      @to_a ||= load_objects
    end

    private

      def build(attrs = {})
        opts = @options.merge(attrs)
        self.class.new(object_class, @xpath, opts)
      end

      def load_objects
        selected_attributes.empty? ? load_objects_from_read : load_objects_from_select
      end

      def load_objects_from_select
        binding.pry
        # TODO: need to figure out how to handle limit
        data = pace_client.load_value_objects(
          object_class.pace_object_name,
          xpath: xpath, id: nil, sorts: sort_param, offset: offset,
          fields: field_info_select, limit: 1000
        )
        data['valueObjects']
          .map { |obj| obj['fields'].each_with_object({}) { |f, h| h[f['name']] = f['value'] } }
          .map { |attrs| object_class.new(attrs) }
      end

      def load_objects_from_read
        ids = pace_client.find_objects(
          object_class.pace_object_name, xpath,
          page_size: page_size, page_number: page_number, sort: sort_param
        )
        return [] if ids.blank?

        data_map = ids.map do |id|
          puts "Reading object with id: #{id}"
          pace_client.read_object(object_class.pace_object_name, id)
        end
        binding.pry
        data_map.map { |data| object_class.new(data) }
      end

      def field_info_select
        selected_attributes.map do |attr|
          if attr.is_a?(Hash)
            attr
          else
            { xpath: "@#{attr}", name: attr.to_s }
          end
        end
      end

      def paging_info
        # TODO: need to figure how to handle limit
        @paging_info ||= pace_client.load_value_objects(
          object_class.pace_object_name,
          xpath: xpath, id: nil, sorts: [], fields: [], limit: 1000
        )
      end

      def sort_param
        return nil unless sort_xpath

        [{ xpath: sort_xpath, descending: sort_direction == 'desc' }]
      end

      def pace_client
        @pace_client ||= PaceApi::Client.new
      end
  end
end
