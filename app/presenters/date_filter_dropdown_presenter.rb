class DateFilterDropdownPresenter
  attr_reader :view, :start_target, :end_target

  def initialize(view_context, start_target, end_target)
    @view = view_context
    @start_target = start_target
    @end_target = end_target
  end

  def render
    view.tag.label(class: 'mb-0') do
      view.tag.a(**icon_attrs) + view.tag.div(**dropdown_menu_attrs) do
        current_ranges + previous_ranges + clear_option
      end
    end
  end

  private

    def icon_attrs
      { class: 'fa fa-arrow-right btn btn-sm btn-secondary',
        id: 'date-range-dropdown', 'data-toggle' => 'dropdown',
        'aria-haspopup' => 'true', 'aria-expanded' => 'false' }
    end

    def dropdown_menu_attrs
      { class: 'dropdown-menu search-date-filter',
        'aria-labelledby' => 'date-range-dropdown',
        'data-filter-target-start' => start_target,
        'data-filter-target-end' => end_target }
    end

    def current_ranges
      view.tag.div(class: 'dropdown-header font-weight-bold') { 'Current' } +
        range_tag('today') + range_tag('this_week') + range_tag('this_month') + range_tag('this_year')
    end

    def previous_ranges
      view.tag.div(class: 'dropdown-divider') +
        view.tag.div(class: 'dropdown-header font-weight-bold') { 'Previous' } +
        range_tag('yesterday') + range_tag('last_week') + range_tag('last_month') + range_tag('last_year')
    end

    def range_tag(range)
      view.tag.a(range.titleize, href: '#', 'data-range' => range, class: 'dropdown-item')
    end

    def clear_option
      view.tag.div(class: 'dropdown-divider') +
        view.tag.a('Clear', href: '#', class: 'dropdown-item text-danger', 'data-range' => 'clear')
    end
end
