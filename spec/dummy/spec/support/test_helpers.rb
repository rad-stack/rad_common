module TestHelpers
  def test_photo
    Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_photo.png'), 'image/png')
  end

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
    rescue StandardError
      false
    end
  end

  def fill_time(id, time)
    formatted = time.strftime('%m/%e/%Y %I:%M %p')
    fill_in id, with: formatted
  end

  def element_should_not_be_found(selector)
    page.find(selector)
    false
  rescue Capybara::ElementNotFound
    true
  end

  def element_should_be_found(selector)
    page.find(selector)
    true
  rescue Capybara::ElementNotFound
    false
  end

  def wait_for_ajax
    sleep 2
  end
end
