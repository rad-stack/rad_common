class DateFilterDropdownPresenter
  attr_reader :view, :active_range

  def initialize(view_context, active_range: nil)
    @view = view_context
    @active_range = active_range
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
        id: 'date-range-dropdown', 'data-bs-toggle' => 'dropdown',
        'aria-haspopup' => 'true', 'aria-expanded' => 'false' }
    end

    def dropdown_menu_attrs
      { class: 'dropdown-menu', 'aria-labelledby' => 'date-range-dropdown' }
    end

    def current_ranges
      view.tag.div(class: 'dropdown-header font-weight-bold') { 'Current' } +
        ranges_for_group(:current)
    end

    def previous_ranges
      view.tag.div(class: 'dropdown-divider') +
        view.tag.div(class: 'dropdown-header font-weight-bold') { 'Previous' } +
        ranges_for_group(:previous)
    end

    def ranges_for_group(group)
      view.safe_join(
        RadSearch::DateRanges.ranges_for_group(group).map do |range_key, config|
          range_tag(range_key, config[:label])
        end
      )
    end

    def range_tag(range_key, label)
      is_active = active_range == range_key

      view.tag.div(class: 'dropdown-item d-flex justify-content-between align-items-center') do
        view.tag.a(label,
                   href: '#',
                   'data-range' => range_key,
                   class: is_active ? 'text-success' : 'text-dark',
                   'data-action' => 'search-date-filter#setRange',
                   'data-turbo' => 'false') +
          (is_active ? view.tag.span(view.icon(:check), class: 'text-success') : ''.html_safe)
      end
    end

    def clear_option
      view.tag.div(class: 'dropdown-divider') +
        view.tag.a('Clear', href: '#', class: 'dropdown-item text-danger',
                            'data-range' => 'clear', 'data-turbo' => 'false',
                            'data-action' => 'search-date-filter#setRange')
    end
end
