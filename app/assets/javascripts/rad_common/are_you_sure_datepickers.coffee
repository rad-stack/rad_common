$ ->
  $('.simple_form').areYouSure()
  $('.date, .time, .datetime_local').on 'dp.change', (e) ->
    didChange = e.date && e.oldDate && !sameDate(e.date, e.oldDate)
    $(this).trigger('change') if didChange

  datePrecision = (input) ->
    input = $(input)
    return 'day'    if input.hasClass 'date'
    return 'minute' if input.hasClass 'time'
    return 'minute' if input.hasClass 'datetime_local'

  sameDate = (date, oldDate) ->
    date.isSame(oldDate, datePrecision(this))
