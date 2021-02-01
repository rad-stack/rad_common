#= require bootstrap-select
#= require rad_common/dynamic_updater

$ ->
  $(".global-search-autocomplete").bind "autocompleteselect", (event, ui) ->
    select_global_search_item($(this), event, ui)

  $(".content .global-search-autocomplete").bind "autocompletefocus", (event, ui) ->
    select_global_search_item($(this), event, ui)

  $(".global_search_name").on "keyup keypress", (e) ->
    code = e.keyCode or e.which
    if code is 13
      e.preventDefault()
      false

  $('.global-search-autocomplete').each( (index, object) ->
    instance = $(object).autocomplete().autocomplete("instance")
    instance._renderItem = (ul, item) ->
      table = $("<table>")
      tr = $( "<tr>" )
      td = $( "<td class='search-label'>" + item.label + "</td>" )
      tr.append( td )
      if( item.hasOwnProperty("columns") && item.columns.length > 0 )
        columns = item.columns
        for i in [0..columns.length]
          column = columns[i]
          if column != undefined
            tr.append("<td class='search-column-value'>" + column + "</td>"  )
      tr.appendTo(table)

      if item.scope_description != undefined && $('.super_search').val() == '1'
        tr = $("<tr>")
        tr.append("<td class='search-scope-model-name'>" + item.human_name + "</td>")
      tr.appendTo(table)
      table.appendTo(ul)
      table
  )

  $(".super_search").change ->
    if( $(this).prop('checked') )
        $(this).prop( 'checked', confirm('Are you sure you want to do a super (combined) search? This query may take a long time, selecting a normal query is preferred to get your results quickly and not bog down the system.') )


  defaultGlobalSearchPlaceholder = $('.global-search-autocomplete').attr('placeholder')
  if $('.super_search').val() == '1'
    $('.super_search').prop('checked', true)
    $('.global-search-autocomplete').attr('placeholder', 'Super Search')
    $('.global-search-dropdown').toggle()

  $('.super_search').change (event) ->
    if $(this).is(':checked')
      defaultGlobalSearchPlaceholder = $('.global-search-autocomplete').attr('placeholder')
      $('.super_search').val('1')
      $('.global-search-autocomplete').attr('placeholder', 'Super Search')
    else
      $('.super_search').val('0')
      $('.global-search-autocomplete').attr('placeholder', defaultGlobalSearchPlaceholder)
    $('.global-search-dropdown').toggle()

  select_global_search_item = (item, event, ui) ->
    $("input[name=global_search_id]").val(ui.item.id)
    $("input[name=global_search_model_name]").val(ui.item.model_name)
    form = item.closest("form")
    setTimeout (->
      form.submit()
      return
    ), 300

  $(".search-option").click ->
    $('.global_search_scope').val( $(this).data("search-scope"))
    $(".global_search_name").focus()
    $(".global_search_name").attr("placeholder", $(this).html())
    $(".global_search_name").val("")

  if $('.read-more').length
    $('.read-more').readmore( { speed: 75, moreLink: "<a class='btn btn-primary btn-sm read-more-btn more-btn' href='#'><div>Read more</div></a>", lessLink: "<a class='btn btn-primary btn-sm read-more-btn close-btn' href='#'><div>Close</div></a>" } )

  checkClientUser()

  $('#user_external').on 'change', ->
    checkClientUser()

  checkMessageType()

  $('#system_message_message_type').on 'change', ->
    checkMessageType()

  humanize = (string) ->
    string[0].toUpperCase() + string.substring(1).replace(/([a-z])(?=[A-Z])/g, "$1 ")

checkClientUser = ->
  if $('#user_external').is(':checked')
    $('.internal').hide()
    $('.external').show()
  else
    $('.internal').show()
    $('.external').hide()

checkMessageType = ->
  if $('#system_message_message_type').val() == 'email'
    $('.email-message').show()
    $('.sms-message').hide()
  else
    $('.sms-message').show()
    $('.email-message').hide()
