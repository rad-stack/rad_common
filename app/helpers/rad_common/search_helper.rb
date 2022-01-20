module RadCommon
  module SearchHelper
    def clear_filters_path(path, page_size)
      path += '?clear_filters=true'
      path += "&page_size=#{page_size}" if page_size.present?
      path
    end
  end
end
