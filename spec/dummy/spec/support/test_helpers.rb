module TestHelpers
  def bootstrap_select(value, attrs)
    click_bootstrap_select(attrs)
    find('ul.inner li a span', text: value).click
  end

  def click_bootstrap_select(attrs)
    find(".bootstrap-select .dropdown-toggle[data-id='#{attrs[:from]}']").click
  end

  def confirm_present?
    confirm_accepted = false

    begin
      page.accept_confirm { confirm_accepted = true }
      confirm_accepted
    rescue
      false
    end
  end
end

include TestHelpers
