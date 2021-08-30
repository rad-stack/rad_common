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
end
