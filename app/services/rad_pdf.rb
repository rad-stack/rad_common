class RadPDF < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  HEADER_FONT_SIZES = {
    'h1' => 24,
    'h2' => 20,
    'h3' => 18,
    'h4' => 16,
    'h5' => 14,
    'h6' => 12
  }.freeze

  def rich_text(text_field, size: nil)
    return if text_field.blank? || text_field.body.blank?

    html = text_field.body.to_html
    return if html.blank?

    html.gsub!(%r{<(/?)(s|del)>}, '<\1strikethrough>')
    html.gsub!(/<link\s*([^>]*?)href=/, '<a \1href=')
    html.gsub!(%r{</link>}, '</a>')

    safe_html = ActionController::Base.helpers.sanitize(
      html,
      tags: %w[p b i u br strong em ul ol li strikethrough a h1 h2 h3 h4 h5 h6 div],
      attributes: %w[href]
    )

    doc = Nokogiri::HTML.fragment(safe_html)

    handle_children doc, size: size
  end

  def encode_text(text)
    return if text.blank?

    text.encode('windows-1252', undef: :replace, replace: '').encode('UTF-8', undef: :replace, replace: '')
  end

  private

    def handle_children(doc, size: nil)
      doc.children.each do |node|
        handle_child node, size: size
      end
    end

    def handle_child(node, size: nil)
      case node.name
      when 'ul', 'ol'
        handle_list node, size: size
      when 'h1', 'h2', 'h3', 'h4', 'h5', 'h6'
        text node.inner_html, inline_format: true, size: HEADER_FONT_SIZES[node.name], style: :bold
      when 'text'
        text node.text, inline_format: true, size: size unless node.text.strip.empty?
      when 'div'
        text node.inner_html, inline_format: true, size: size unless node.inner_html.strip.empty?
      when 'br'
        move_down 5
      else
        text node.to_html, inline_format: true, size: size
      end
    end

    def handle_list(node, size: nil)
      indent(20) do
        node.css('li').each_with_index do |li, index|
          prefix = node.name == 'ul' ? '• ' : "#{index + 1}. "
          text "#{prefix}#{li.inner_html}", inline_format: true, size: size
        end
      end
    end
end
