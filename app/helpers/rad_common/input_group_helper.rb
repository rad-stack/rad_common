module RadCommon
  module InputGroupHelper
    def addon(title, html_tag = 'span')
      return if title.blank?

      content_tag(html_tag.to_s, class: 'input-group-text') do
        title
      end
    end
  end
end
