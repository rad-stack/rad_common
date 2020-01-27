module BootstrapSelectHelper
  def bootstrap_select(value, attrs)
    find(".bootstrap-select .dropdown-toggle[data-id='#{attrs[:from]}']").click
    find('ul.inner li a span', text: value).click
  end
end
