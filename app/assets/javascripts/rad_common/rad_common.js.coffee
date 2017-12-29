$ ->
  $(".global-search-autocomplete").bind "autocompleteselect", (event, ui) ->
    select_global_search_item($(this), event, ui)

  $(".content .global-search-autocomplete").bind "autocompletefocus", (event, ui) ->
    select_global_search_item($(this), event, ui)

  $("#global_search_name").on "keyup keypress", (e) ->
    code = e.keyCode or e.which
    if code is 13
      e.preventDefault()
      false

  defaultGlobalSearchPlaceholder = $('.global-search-autocomplete').attr('placeholder')
  $('.super_search').change ->
    if $('.super_search').is(':checked')
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
    $("[id=global_search_scope]").val( $(this).data("search-scope"))
    $("[id=global_search_name]:visible").focus()
    $("[id=global_search_name]:visible").attr("placeholder", $(this).html())
    $("[id=global_search_name]:visible").val("")

  if $('.read-more').length
    $('.read-more').readmore( { speed: 75, moreLink: "<a class='btn btn-primary btn-xs read-more-btn more-btn' href='#'><div>Read more</div></a>", lessLink: "<a class='btn btn-primary btn-xs read-more-btn close-btn' href='#'><div>Close</div></a>" } )
