module NotificationsHelper
  def snooze_button(notification)
    content_tag(:div, class: 'dropdown') do
      button_tag(class: 'btn btn-sm btn-success dropdown-toggle btn-block', data: { toggle: 'dropdown' }) {
        icon(:clock, 'Snooze Until')
      } +
        content_tag(:div, class: 'dropdown-menu btn-block') do
          link_to('1 Day',
                  notification_path(notification, notification: { snooze_until: 1.day.from_now }),
                  method: :put,
                  class: 'dropdown-item') +
            link_to('5 Days',
                    notification_path(notification, notification: { snooze_until: 5.days.from_now }),
                    method: :put,
                    class: 'dropdown-item') +
            link_to('Next Monday',
                    notification_path(notification, notification: { snooze_until: DateTime.now.next_week(:monday) }),
                    method: :put,
                    class: 'dropdown-item')
        end
    end
  end
end
