module RadCommon
  module SearchHelper
    def page_size_options
      %w[10 25 50 100].map do |page_size|
        ["#{page_size} per page", page_size]
      end
    end

    def date_filter_dropdown_label(filter)
      DateFilterDropdownPresenter.new(self, filter).render
    end
  end
end
