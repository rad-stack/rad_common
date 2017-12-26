module RadCommon
  module InputGroupHelper
    def addon(title, html_tag = 'span')
      return if title.blank?
      content_tag("#{html_tag}", class: 'input-group-addon') do
        title
      end
    end
  end
end
