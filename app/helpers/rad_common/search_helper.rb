module RadCommon
  module SearchHelper
    def page_size_options
      %w[10 25 50 100].map do |page_size|
        ["#{page_size} per page", page_size]
      end
    end

    def date_filter_dropdown_label(filter)
      icon_attrs = { class: 'fa fa-calendar-day mr-1 text-muted', id: 'date-range-dropdown', 'data-toggle' => 'dropdown',
                     'aria-haspopup' => 'true', 'aria-expanded' => 'false' }
      dropdown_menu_attrs = { class: 'dropdown-menu search-date-filter',
                              'aria-labelledby' => 'date-range-dropdown',
                              'data-filter-target' => filter.column.to_s.underscore }
      tag.label(class: 'mb-0') do
        tag.a(**icon_attrs) + tag.div(**dropdown_menu_attrs) do
          tag.div(class: 'dropdown-header font-weight-bold') { 'Current' } +
            range_tag('today') + range_tag('this_week') + range_tag('this_month') + range_tag('this_year') +
            tag.div(class: 'dropdown-divider') +
            tag.div(class: 'dropdown-header font-weight-bold') { 'Previous' } +
            range_tag('yesterday') + range_tag('last_week') + range_tag('last_month') + range_tag('last_year')
        end + filter.start_input_label
      end
    end

    def range_tag(range)
      tag.a(range.titleize, href: '#', 'data-range' => range, class: 'dropdown-item')
    end
  end
end
