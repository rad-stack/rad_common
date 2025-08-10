module TestHelpers
  def test_photo
    Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_photo.png'), 'image/png')
  end

  def tom_select(value, attrs)
    tom_search(value, attrs)
    find('.ts-dropdown .option', text: value).click
  end

  def tom_search(value, attrs)
    click_tom_select(attrs)
    return if attrs[:search].blank?

    find('.ts-dropdown input').fill_in(with: attrs[:search])
    wait_for_ajax
  end

  def click_tom_select(attrs)
    find_by_id("#{attrs[:from]}-ts-control").click
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
