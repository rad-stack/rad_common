class TabPresenter
  Tab = Struct.new(:id, :title, :active, keyword_init: true) do
    def dom_id
      "tab-#{id}"
    end

    def tab_id
      "#{dom_id}-tab"
    end
  end

  attr_reader :tabs, :view_context

  def initialize(view_context:, tabs: [])
    @view_context = view_context
    has_explicit_active = tabs.any? { |tab| tab[:active] == true }

    @tabs = tabs.map.with_index do |tab_config, index|
      Tab.new(
        id: tab_config[:id],
        title: tab_config[:title],
        active: tab_config.key?(:active) ? tab_config[:active] : (!has_explicit_active && index.zero?)
      )
    end
  end

  def render_tabs
    view_context.content_tag(:div, class: 'nav nav-pills bg-light shadow-sm mb-5', role: 'tablist') do
      tabs.map { |tab| render_tab_link(tab) }.join.html_safe
    end
  end

  def render_tab_content(tab_id, &block)
    tab = tabs.find { |t| t.id == tab_id }
    return '' unless tab

    css_classes = %w[tab-pane fade]
    css_classes += %w[show active] if tab.active

    view_context.content_tag(:div,
                             class: css_classes,
                             id: tab.dom_id,
                             role: 'tabpanel',
                             'aria-labelledby': tab.tab_id) do
      block.call if block_given?
    end
  end

  def render_all_tab_content(&block)
    view_context.content_tag(:div, class: 'tab-content') do
      tabs.map { |tab| render_tab_pane(tab, &block) }.join.html_safe
    end
  end

  def render_all(&block)
    view_context.capture do
      view_context.concat(
        view_context.content_tag(:div, class: 'row') do
          view_context.content_tag(:div, class: 'col-lg-12') do
            render_tabs
          end
        end
      )

      view_context.concat(
        view_context.content_tag(:div, class: 'row') do
          view_context.content_tag(:div, class: 'col-lg-12') do
            render_all_tab_content(&block)
          end
        end
      )
    end
  end

  private

  def render_tab_link(tab)
    css_classes = %w[nav-item nav-link]
    css_classes << 'active' if tab.active

    view_context.content_tag(:a, tab.title,
                             id: tab.tab_id,
                             class: css_classes,
                             'data-bs-toggle': 'tab',
                             href: "##{tab.dom_id}",
                             role: 'tab',
                             'aria-controls': tab.dom_id,
                             'aria-selected': tab.active.to_s)
  end

  def render_tab_pane(tab, &block)
    css_classes = %w[tab-pane fade]
    css_classes += %w[show active] if tab.active

    view_context.content_tag(:div,
                             class: css_classes,
                             id: tab.dom_id,
                             role: 'tabpanel',
                             'aria-labelledby': tab.tab_id) do
      block.call(tab) if block_given?
    end
  end
end
