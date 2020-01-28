module BootstrapSelectHelper
  def bootstrap_select(value, attrs)
    click_bootstrap_select(attrs)
    find('ul.inner li a span', text: value).click
  end

  def click_bootstrap_select(attrs)
    find(".bootstrap-select .dropdown-toggle[data-id='#{attrs[:from]}']").click
    find('ul.inner li a span', text: value).click
  end
end
