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
               size: size,
               frame_id: "#{id}_content"
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
               width_class: width_class,
               frame_id: "#{id}_content"
             }
    else
      raise ArgumentError, "Invalid type: #{type}. Must be 'modal' or 'offcanvas'"
    end
  end

  def lazy_container_link(text, url, type:, container_id:, title: nil, subtitle: nil, **options)
    options[:data] ||= {}
    options[:data][:bs_toggle] = type.to_s
    options[:data][:bs_target] = "##{container_id}"
    options[:data][:lazy_url] = url
    options[:data][:lazy_title] = title if title.present?
    options[:data][:lazy_subtitle] = subtitle if subtitle.present?

    link_to text, '#', **options
  end
end
