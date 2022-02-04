/*
* Unobtrusive autocomplete
*
* To use it, you just have to include the HTML attribute autocomplete
* with the autocomplete URL as the value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete">
*
* Optionally, you can use a jQuery selector to specify a field that can
* be updated with the element id whenever you find a matching value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete" data-id-element="#id_field">
*/

(function(jQuery)
{
  var self = null;
  jQuery.fn.railsAutocomplete = function() {
    var handler = function() {
      if (!this.railsAutoCompleter) {
        this.railsAutoCompleter = new jQuery.railsAutocomplete(this);
      }
    };
    if (jQuery.fn.on !== undefined) {
      return jQuery(document).on('focus',this.selector,handler);
    }
    else {
      return this.live('focus',handler);
    }
  };

  jQuery.railsAutocomplete = function (e) {
    _e = e;
    this.init(_e);
  };

  jQuery(document).ready( function()
                          {
                            display_autocomplete_errors();
                          } );

  function display_autocomplete_errors()
  {
      jQuery(".ui-autocomplete-input").each( function()
                                             {
                                              display_autocomplete_error(this, "id-element");
                                              display_autocomplete_error(this, "association-element");
                                             });
  }

  function display_autocomplete_error(e, data_attribute)
  {
      formGroup = jQuery(e).parent(".form-group");

      if( jQuery(e).data(data_attribute) )
      {
        idElement = jQuery( jQuery(e).data(data_attribute) );
        idFormGroup = idElement.parent(".form-group");

        idFormGroup.find("div.invalid-feedback").each( function()
                                                {
                                                  formGroup.addClass("form-group-invalid");
                                                  formGroup.append( $(this).clone() );
                                                  jQuery(e).addClass("is-invalid");
                                                } );
      }
  }

  jQuery.railsAutocomplete.fn = jQuery.railsAutocomplete.prototype = {
    railsAutocomplete: '0.0.1'
  };

  jQuery.railsAutocomplete.fn.extend = jQuery.railsAutocomplete.extend = jQuery.extend;
  jQuery.railsAutocomplete.fn.extend({
    init: function(e) {
      e.delimiter = jQuery(e).attr('data-delimiter') || null;
      e.min_length = jQuery(e).attr('min-length') || 2;
      e.append_to = jQuery(e).attr('data-append-to') || null;
      e.autoFocus = jQuery(e).attr('data-auto-focus') || false;

      function split( val ) {
        return val.split( e.delimiter );
      }
      function extractLast( term ) {
        return split( term ).pop().replace(/^\s+/,"");
      }

      jQuery(e).autocomplete({
        appendTo: e.append_to,
        autoFocus: e.autoFocus,
        create: function() {
          $(this).data('ui-autocomplete')._resizeMenu = function(){
            var ul = this.menu.element;
            ul.width(Math.max( this.element.outerWidth(), getMaxAutoCompleteTableWidth(ul) + 50 ) );
          };
          $(this).data('ui-autocomplete')._renderItem = function( ul, item )
          {
            var table = $("<table>");
            var tr = $( "<tr>" );

            var td = $( "<td class='search-label'>" + item.label + "</td>" );
            tr.append( td );
            if( item.hasOwnProperty("columns") && item.columns.length > 0 )
            {
              var columns = item.columns;
              for( var i = 0; i < columns.length; i++)
              {
                var column = columns[i];
                tr.append("<td class='search-column-value'>" + column + "</td>"  );
              }
            }
            tr.appendTo(table);
            table.appendTo(ul);
            return table;
          };
        },
        source: function( request, response ) {
          params = {term: extractLast( request.term )}
          if (jQuery(e).attr('data-autocomplete-fields')) {
              jQuery.each(jQuery.parseJSON(jQuery(e).attr('data-autocomplete-fields')), function(field, selector) {
              params[field] = jQuery(selector).val();
            });
          }
          if(jQuery(e).data('excluded-ids')) {
              params['excluded_ids'] = jQuery(e).data('excluded-ids');
          }
          const allowNewModel = jQuery(e).data('allow-new-model');
          jQuery.getJSON( jQuery(e).attr('data-autocomplete'), params, function() {
            if (allowNewModel) {
              arguments[0].unshift({ id: '', label: `Create "${request.term}" ${allowNewModel}` });
            }
            if(arguments[0].length == 0) {
              arguments[0] = []
              if (!allowNewModel) {
                arguments[0][0] = { id: '', label: 'no existing match' };
              }
            }
            let newOptionExists = false;
            jQuery(arguments[0]).each(function(i, el) {
              var obj = {};
              obj[el.id] = el;
              // Check if record already exists in suggestions
              if (el.label === request.term) {
                newOptionExists = true;
              }
              jQuery(e).data(obj);
            });
            if (allowNewModel && newOptionExists) {
              arguments[0].shift(); // Remove create option if record exists in suggestions
            }
            response.apply(null, arguments);
          });
        },
        change: function( event, ui ) {
            if(!jQuery(this).is('[data-id-element]') ||
                    jQuery(jQuery(this).attr('data-id-element')).val() == "") {
              return;
            }

            jQuery(jQuery(this).attr('data-id-element')).val(ui.item ? ui.item.id : "").trigger('change');

            if (jQuery(this).attr('data-update-elements')) {
                var update_elements = jQuery.parseJSON(jQuery(this).attr("data-update-elements"));
                var data = ui.item ? jQuery(this).data(ui.item.id.toString()) : {};
                if(update_elements && jQuery(update_elements['id']).val() == "") {
                  return;
                }
                for (var key in update_elements) {
                    element = jQuery(update_elements[key]);
                    if (element.is(':checkbox')) {
                        if (data[key] != null) {
                            element.prop('checked', data[key]);
                        }
                    } else {
                        element.val(ui.item ? data[key] : "");
                    }
                }
            }
        },
        search: function() {
          // custom minLength
          var term = extractLast( this.value );
          if ( term.length < e.min_length ) {
            return false;
          }
        },
        focus: function() {
          // prevent value inserted on focus
          return false;
        },
        select: function( event, ui ) {
          var terms = split( this.value );
          // remove the current input
          terms.pop();
          // add the selected item
          terms.push( ui.item.value );
          // add placeholder to get the comma-and-space at the end
          if (e.delimiter != null) {
            terms.push( "" );
            this.value = terms.join( e.delimiter );
          } else {
            // If allowing new model and the selected item has no id, we do not want to maniupulate
            // the text as the entered term will be used as the value and supplied to a find_or_create
            if (ui.item.id !== '' || !this.dataset.allowNewModel) {
              this.value = terms.join("").replace(/<(?:.|\n)*?>/gm, '');
            }
            if (jQuery(this).attr('data-id-element')) {
              jQuery(jQuery(this).attr('data-id-element')).val(ui.item.id);
              idElement = $(this).attr('data-id-element')
              $(idElement).trigger('change')
            }
            if (jQuery(this).attr('data-update-elements')) {
              var data = jQuery(this).data(ui.item.id.toString());
              var update_elements = jQuery.parseJSON(jQuery(this).attr("data-update-elements"));
              for (var key in update_elements) {
                  element = jQuery(update_elements[key]);
                  if (element.is(':checkbox')) {
                      if (data[key] != null) {
                          element.prop('checked', data[key]);
                      }
                  } else {
                      element.val(data[key]);
                  }
              }
            }
          }
          var remember_string = this.value;
          jQuery(this).bind('keyup.clearId', function(){
            if(jQuery.trim(jQuery(this).val()) != jQuery.trim(remember_string)){
              jQuery(jQuery(this).attr('data-id-element')).val("");
              jQuery(this).unbind('keyup.clearId');
            }
          });
          jQuery(e).trigger('railsAutocomplete.select', ui);
          return false;
        }
      });
    }
  });

  function getMaxAutoCompleteTableWidth(ul)
  {
    var maxWidth = 0;
    var maxWidths = null;
    ul.show();
    ul.css({width: "100%"});
    $(ul).children("table").each( function()
                                  {
                                    $(this).css({width: "auto"});
                                    var currentWidth = $(this).width();
                                    if( currentWidth > maxWidth )
                                    {
                                      maxWidth = currentWidth;
                                    }
                                    maxWidths = getMaxDataWidths( $(this), maxWidths );
                                    $(this).css({width: "100%"});
                                  });
    $(ul).children("table").each( function()
                                  {
                                    updateMaxWidths( $(this), maxWidths );
                                  });
    ul.css({width: "auto"});

    return maxWidth;
  }

  function updateMaxWidths( table, maxWidths )
  {
    var i = 0;
    $(table).find("tr td").each( function()
                                 {
                                  $(this).width( maxWidths[i] );
                                  i++;
                                 });
  }

  function getMaxDataWidths( table, maxWidths )
  {
    var currentWidths = [];
    $(table).find("tr td").each( function()
                                 {
                                  currentWidths.push( $(this).width());
                                 });

    if( maxWidths )
    {
      for( var i = 0; i < maxWidths.length; i++ )
      {
        if( currentWidths[i] > maxWidths[i] )
        {
          maxWidths[i] = currentWidths[i];
        }
      }
    }
    else
    {
      maxWidths = currentWidths;
    }

    return maxWidths;
  }

  jQuery(document).ready(function(){
    jQuery('input[data-autocomplete]').railsAutocomplete();
  });
})(jQuery);
