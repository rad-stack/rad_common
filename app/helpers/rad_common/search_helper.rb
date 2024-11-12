module RadCommon
  module SearchHelper
    def page_size_options
      %w[10 25 50 100].map do |page_size|
        ["#{page_size} per page", page_size]
      end
    end

    def date_filter_dropdown_label(start_target, end_target)
      DateFilterDropdownPresenter.new(self, start_target, end_target).render
    end
  end
end
