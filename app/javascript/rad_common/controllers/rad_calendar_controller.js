import { Controller } from '@hotwired/stimulus';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import bootstrap5Plugin from '@fullcalendar/bootstrap5';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
import interactionPlugin from '@fullcalendar/interaction';

export default class extends Controller {
  static targets = ['calendar', 'loaded', 'loading', 'datepicker'];
  static values = { 
    eventUrl: String,
    initialView: { type: String, default: 'dayGridMonth' }
  };

  connect() {
    this.debounceTimer = null;
    this.userSelectedDate = null;
    this.setupCalendar();
    this.setupDatepicker();
  }

  setupDatepicker() {
    if (this.hasDatepickerTarget) {
      const { date } = this.getUrlParams();
      this.updateDatepicker(date);
    }
  }

  datepickerChanged(event) {
    const selectedDate = event.target.value;
    this.userSelectedDate = selectedDate;
    
    if (this.debounceTimer) {
      clearTimeout(this.debounceTimer);
    }
    
    this.debounceTimer = setTimeout(() => {
      if (selectedDate && this.calendar) {
        this.calendar.gotoDate(selectedDate);
        this.updateUrl(this.calendar.view.type, selectedDate);
      }
    }, 300);
  }

  updateDatepicker(date) {
    if (this.hasDatepickerTarget) {
      this.datepickerTarget.value = date;
    }
  }

  getUrlParams() {
    const urlParams = new URLSearchParams(window.location.search);
    return {
      view: urlParams.get('view') || this.initialViewValue,
      date: urlParams.get('date') || new Date().toISOString().split('T')[0]
    };
  }

  updateUrl(view, date) {
    const url = new URL(window.location);
    url.searchParams.set('view', view);
    url.searchParams.set('date', date);
    window.history.replaceState({}, '', url);
  }

  setupCalendar() {
    if (this.hasCalendarTarget) {
      this.calendar = new Calendar(this.calendarTarget, this.config());
      this.calendar.render();
    } else {
      this.showLoaded();
    }
  }

  config() {
    const { view, date } = this.getUrlParams();

    return {
      timeZone: 'none',
      initialView: view,
      initialDate: date,
      events: (fetchInfo, successCallback, failureCallback) => {
        let url = `${this.eventUrlValue}.json?${window.location.search.replace('?', '')}`;
        url += `&start_time=${fetchInfo.startStr}&end_time=${fetchInfo.endStr}`;
        fetch(url).then(response => response.json())
          .then(events => successCallback(events))
          .catch(error => failureCallback(error));
      },
      plugins: [dayGridPlugin, bootstrap5Plugin, timeGridPlugin, listPlugin, interactionPlugin],
      themeSystem: 'bootstrap5',
      buttonIcons: {
        prev: ' fa fa-chevron-left',
        next: ' fa fa-chevron-right'
      },
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      eventDidMount: function(info) {
        if(info.event.textColor) {
          info.el.style.color = info.event.textColor;
        }
        if(info.event.backgroundColor) {
          info.el.style.backgroundColor = info.event.backgroundColor;
        }
        if(info.event.extendedProps.icon){
          $(info.el).find('.fc-event-title').prepend(`<i class='${info.event.extendedProps.icon} mr-2 ml-2'></i>`);
        }
        if (info.event.extendedProps.description) {
          $(info.el).tooltip({ title: info.event.extendedProps.description, container: 'body' });
        }
      },
      loading: (isLoading) => this.updateLoadingStatus(isLoading),
      datesSet: (dateInfo) => {
        const dateToUse = this.userSelectedDate || dateInfo.view.currentStart.toISOString().split('T')[0];
        this.updateUrl(dateInfo.view.type, dateToUse);
        this.updateDatepicker(dateToUse);
        this.userSelectedDate = null;
      },
      views: {
        dayGridMonth: {
          displayEventEnd: true
        }
      },
      height: '80vh',
      startParam: 'start_time',
      endParam: 'end_time'
    };
  }

  updateLoadingStatus(isLoading) {
    if (isLoading) {
      this.showLoading();
    } else {
      this.showLoaded();
    }
  }

  showLoaded() {
    if (this.hasLoadedTarget) this.loadedTarget.style.display = 'block';
    if (this.hasLoadingTarget) this.loadingTarget.style.display = 'none';
  }

  showLoading() {
    if (this.hasLoadedTarget) this.loadedTarget.style.display = 'none';
    if (this.hasLoadingTarget) this.loadingTarget.style.display = 'block';
  }
}
