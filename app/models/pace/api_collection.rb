module Pace
  class ApiCollection
    delegate :count, :first, to: :objects

    def initialize(object_class, xpath, limit: 1000)
      @object_class = object_class
      @xpath = xpath
      @page_size = 25
      @page_number = nil
      @sort_xpath = nil
      @sort_direction = 'asc'
      @limit = limit
      @selected_attributes = []
    end

    def each(&)
      objects.each(&)
    end

    def select(attributes)
      @selected_attributes += attributes
      self
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

    def offset
      return 0 if current_page == 1

      (current_page * @page_size) - 1
    end

    def objects
      @objects ||= load_objects
    end

    def load_objects
      return load_objects_from_select if @selected_attributes.present?

      load_objects_from_read
    end

    def load_objects_from_select
      data = pace_client.load_value_objects(@object_class.pace_object_name,
                                            xpath: @xpath, id: nil, sorts: [], offset: offset,
                                            fields: field_info_select, limit: @page_size)
      object_data_list = data['valueObjects'].map do |object_data|
        hash = {}
        object_data['fields'].each do |field_data|
          hash[field_data['name']] = field_data['value']
        end
        hash
      end
      object_data_list.map { |obj| @object_class.new(obj) }
    end

    def load_objects_from_read
      ids = pace_client.find_objects(@object_class.pace_object_name, @xpath,
                                     page_size: @page_size, page_number: @page_number, sort: sort_param)

      ids.map { |id| @object_class.new(pace_client.read_object(@object_class.pace_object_name, id)) }
    end

    def field_info
      @object_class.attribute_map.map do |ruby_attr, pace_attr|
        { xpath: "@#{pace_attr}", name: pace_attr.to_s }
      end
    end

    def field_info_select
      @selected_attributes.map { |attr| { xpath: "@#{attr}", name: attr.to_s } }
    end

    def paging_info
      @paging_info ||= pace_client.load_value_objects(@object_class.pace_object_name,
                                                      xpath: @xpath, id: nil, sorts: [],
                                                      fields: [], limit: @limit)
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
