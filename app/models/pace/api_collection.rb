module Pace
  class ApiCollection
    include Enumerable

    attr_reader :object_class, :xpath, :page_size, :page_number,
                :sort_xpath, :sort_direction, :limit, :selected_attributes

    delegate :count, :first, to: :to_a

    def initialize(object_class, xpath, limit: 1000, page_size: nil, page_number: nil,
                   sort_xpath: nil, sort_direction: 'asc', selected_attributes: [])
      @object_class = object_class
      @xpath = xpath
      @limit = limit
      @page_size = page_size
      @page_number = page_number
      @sort_xpath = sort_xpath
      @sort_direction = sort_direction
      @selected_attributes = selected_attributes
    end

    def each(&)
      to_a.each(&)
    end

    def group_by(&)
      to_a.group_by(&)
    end

    def sum(&)
      to_a.sum(&)
    end

    def find(&)
      to_a.find(&)
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
        opts = to_h.merge(attrs)
        self.class.new(object_class, opts.delete(:xpath), **opts)
      end

      def to_h
        {
          xpath: xpath,
          page_size: page_size,
          page_number: page_number,
          sort_xpath: sort_xpath,
          sort_direction: sort_direction,
          limit: limit,
          selected_attributes: selected_attributes
        }
      end

      def load_objects
        selected_attributes.empty? ? load_objects_from_read : load_objects_from_select
      end

      def load_objects_from_select
        data = pace_client.load_value_objects(
          object_class.pace_object_name,
          xpath: xpath, id: nil, sorts: sort_param, offset: offset,
          fields: field_info_select, limit: page_size
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

        ids.map { |id| object_class.new(pace_client.read_object(object_class.pace_object_name, id)) }
      end

      def field_info_select
        selected_attributes.map { |attr| { xpath: "@#{attr}", name: attr.to_s } }
      end

      def paging_info
        @paging_info ||= pace_client.load_value_objects(
          object_class.pace_object_name,
          xpath: xpath, id: nil, sorts: [], fields: [], limit: limit
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
