module WaitForAjax
  def wait_for_ajax(timeout = Capybara.default_max_wait_time)
    sleep 0.5 # adding default sleep here ¯\_(ツ)_/¯
    Timeout.timeout(timeout) do
      loop until finished_all_ajax_requests?
    end
    sleep 1
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

include WaitForAjax
