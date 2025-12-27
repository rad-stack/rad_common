module TestHelpers
  def test_photo
    Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_photo.png'), 'image/png')
  end

  def tom_select(value, attrs)
    retries ||= 0
    tom_search(value, attrs)
    find('.ts-dropdown .option', text: value).click
  rescue Capybara::ElementNotFound, Selenium::WebDriver::Error::ElementNotInteractableError
    retries += 1
    raise if retries > 2

    retry
  end

  def tom_search(value, attrs)
    click_tom_select(attrs.merge(skip_dropdown_check: true))
    return if attrs[:search].blank?

    input = find('.ts-dropdown input')
    input.send_keys(:backspace) until input.value.empty?
    input.send_keys(attrs[:search])
    wait_for_ajax
  end

  def click_tom_select(attrs)
    find_by_id("#{attrs[:from]}-ts-control").click
    return if attrs[:skip_dropdown_check]

    within ".#{attrs[:from]}" do
      find('.dropdown-active', wait: 1)
    end
  rescue Capybara::ElementNotFound
    # If dropdown content is not found, try clicking again
    find_by_id("#{attrs[:from]}-ts-control").click
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
