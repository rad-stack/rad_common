class DateTimePicker
  formattingDefaults :
    dateFormat :
      format : 'YYYY-MM-DD'
      view : 'M/D/YYYY'

  set_date : (sel, date) ->
    thisObj = this

    if sel.hasClass("date")
      format = 'M/D/YYYY'
    else if sel.hasClass("time")
      format = 'h:mm A'
    else if sel.hasClass("datetime_local")
      format = 'M/D/YYYY h:mm A'

    sel.val( moment(date).format( format ) )

  time_convert : (time, from, to) ->
    if time
      if !moment(time, to, true).isValid()
        moment(time, from).format(to)
      else
        time
    else
      ''

  view_formatter : ($obj, format, view) ->
    thisObj = this
    $obj.each(->
      field = $(this)

      # Fix times for usage by user
      field.val(thisObj.time_convert(field.val(), format, view))

      $(this).closest('form').on('submit', ->
        # When we submit, switch back
        field.val(thisObj.time_convert(field.val(), view, format))
      )
    )

  formatDateType : (value, viewFormat) ->
    format = @formattingDefaults.dateFormat.format
    view = @formattingDefaults.dateFormat.view

    if viewFormat
      @time_convert(value, format, view)
    else
      @time_convert(value, view, format)

  do_default_input_changes : (sel, format, view) ->
    @view_formatter(sel, format, view)
    sel.attr( "autocomplete", "off")
    sel.each ->

      default_current_date = $(this).data("default-current-date")
      default_date_or_time = $(this).data("default")
      keepOpen = if $(this).data("keep-open")? then $(this).data("keep-open") else true

      # Init Picker
      $(this).datetimepicker({
        format: view,
        keepOpen: keepOpen,
        useCurrent: default_current_date,
        defaultDate: default_date_or_time,
        buttons:
          showToday: true,
          showClear: true,

        icons :
          time: 'fa fa-clock-o'
          date: 'fa fa-calendar'
          up: 'fa fa-arrow-up'
          down: 'fa fa-arrow-down'
          previous: 'fa fa-arrow-left'
          next: 'fa fa-arrow-right'
          today: 'fa fa-calendar-o'
          clear: 'fa fa-times-circle'
      })

      $(this).click ->
        $(this).datetimepicker('show');
        return

      $(this).blur ->
        $(this).datetimepicker('hide');
        return

  addDateEvents : ->

    #Date
    format = 'YYYY-MM-DD'
    view = 'M/D/YYYY'
    # Update Values
    sel = $("input.date")
    this.do_default_input_changes( sel, format, view)

    # Time
    format = 'HH:mm:ss.SSS'
    view = 'h:mm A'
    # Update Values
    sel = $("input.time")
    this.do_default_input_changes( sel, format, view)

    # DateTime local
    format = 'YYYY-MM-DDTHH:mm'
    view = 'M/D/YYYY h:mm A'
    # Update Values
    sel = $("input.datetime_local")
    this.do_default_input_changes( sel, format, view)

  disableHtml5 : ->
    $('input[type="date"]').attr('type','text')
    $('input[type="time"]').attr('type','text')
    $('input[type="datetime-local"]').attr('type','text')


$ ->
  window.dateTimePicker = new DateTimePicker()
  dateTimePicker.disableHtml5()
  dateTimePicker.addDateEvents()
