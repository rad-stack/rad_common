module LazyContainerHelper
  def lazy_container(type:, id:, title: 'Details', subtitle: nil, **options)
    case type.to_s
    when 'modal'
      size = options[:size] || 'md'
      render partial: 'shared/lazy_modal',
             locals: {
               id: id,
               title: title,
               subtitle: subtitle,
               size: size
             }
    when 'offcanvas'
      position = options[:position] || 'end'
      width_class = options[:width_class]
      render partial: 'shared/lazy_offcanvas',
             locals: {
               id: id,
               title: title,
               subtitle: subtitle,
               position: position,
               width_class: width_class
             }
    else
      raise ArgumentError, "Invalid type: #{type}. Must be 'modal' or 'offcanvas'"
    end
  end

  def lazy_container_link(text, url, type:, title: nil, subtitle: nil, size: nil, width: nil, **options)
    container_id ||= type.to_s == 'modal' ? 'global-lazy-modal' : 'global-lazy-offcanvas'

    options[:data] ||= {}
    options[:data][:bs_toggle] = type.to_s
    options[:data][:bs_target] = "##{container_id}"
    options[:data][:lazy_url] = url
    options[:data][:lazy_title] = title if title.present?
    options[:data][:lazy_subtitle] = subtitle if subtitle.present?
    options[:data][:lazy_size] = size if size.present?
    options[:data][:lazy_width] = width if width.present?

    link_to text, '#', **options
  end

  def render_global_lazy_containers
    safe_join([lazy_container(type: 'modal', id: 'global-lazy-modal', title: 'Details'),
               lazy_container(type: 'offcanvas', id: 'global-lazy-offcanvas', title: 'Details', position: 'end')])
  end
end
