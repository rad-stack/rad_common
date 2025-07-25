module Pace
  class ApiCollection
    delegate :count, :first, to: :objects

    def initialize(object_class, xpath)
      @object_class = object_class
      @xpath = xpath
      @page_size = 25
      @page_number = nil
      @sort_xpath = nil
      @sort_direction = 'asc'
    end

    def each(&)
      objects.each(&)
    end

    def where(xpath)
      @xpath = [@xpath, xpath].join(' and ')
      self
    end

    def find(&)
      objects.find(&)
    end

    def order(xpath, direction = 'asc')
      @sort_xpath = xpath
      @sort_direction = direction
      self
    end

    def page_and_sort(page:, sort_xpath: nil, sort_direction: 'asc')
      page(page).order(sort_xpath, sort_direction)
    end

    def page(page_number)
      @page_number = page_number || 1
      self
    end

    def total_pages
      (total_count / @page_size.to_i).to_i
    end

    def total_count
      paging_info['totalRecords']
    end

    def current_page
      @page_number.to_i
    end

    def per(page_size)
      @page_size = page_size
      self
    end

    def objects
      @objects ||= load_objects
    end

    def load_objects
      data = pace_client.load_value_objects(@object_class.pace_object_name,
                                            xpath: @xpath, id: nil, sorts: [],
                                            fields: field_info, limit: 1000)
      object_data_list = data['valueObjects'].map do |object_data|
        hash = {}
        object_data['fields'].each do |field_data|
          hash[field_data['name']] = field_data['value']
        end
        hash
      end
      object_data_list.map { |obj| @object_class.new(obj) }
    end

    def field_info
      @object_class.attribute_map.map do |ruby_attr, pace_attr|
        { xpath: "@#{pace_attr}", name: pace_attr.to_s }
      end
    end

    def paging_info
      @paging_info ||= pace_client.load_value_objects(@object_class.pace_object_name,
                                                      xpath: @xpath, id: nil, sorts: [],
                                                      fields: [], limit: 1000)
    end

    def limit_value
      @page_size
    end

    def sort_param
      return nil unless @sort_xpath

      [{ xpath: @sort_xpath, descending: @sort_direction == 'desc' }]
    end

    def pace_client
      @pace_client ||= PaceApi::Client.new
    end
  end
end
