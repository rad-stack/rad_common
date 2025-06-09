import { Calendar } from 'fullcalendar/dist/fullcalendar.min';

export class CalendarSetup {
  static setup() {
    if ($('#calendar').length) {
      let calendarEl = $('#calendar');
      let calendar = new Calendar(calendarEl, {
        events: '/divisions/calendar.json' + window.location.search,
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
        },
        loading: (isLoading) => CalendarSetup.updateLoadingStatus(isLoading),
        views: {
          month: {
            displayEventEnd: true
          }
        },
        startParam: 'start_time',
        endParam: 'end_time'
      });
      calendar.render();
    } else {
      CalendarSetup.loaded();
    }
  }

  static updateLoadingStatus(isLoading) {
    if (isLoading) {
      return CalendarSetup.loading();
    } else {
      return CalendarSetup.loaded();
    }
  }

  static loaded() {
    $('#calendar-view-tab .loaded').show();
    $('#calendar-view-tab .loading').hide();
  }

  static loading() {
    $('#calendar-view-tab .loaded').hide();
    $('#calendar-view-tab .loading').show();
  }
}