import jQuery from 'jquery'

require('jquery-ui');
require('jquery-ui/ui/widgets/autocomplete');
require('jquery-ui/ui/widgets/dialog');

export class RadCommonAutoComplete {
    constructor( e ) {
        this.e = e;
        this.e.delimiter = jQuery(e).attr('data-delimiter') || null;
        this.e.min_length = jQuery(e).attr('min-length') || 2;
        this.e.append_to = jQuery(e).attr('data-append-to') || null;
        this.e.autoFocus = jQuery(e).attr('data-auto-focus') || false;

        this.autoCompleteSetup();
    }

    autoCompleteSetup() {
        let autoCompleteEvent = this.e;
        let that = this;

        jQuery(autoCompleteEvent).autocomplete({
            appendTo: autoCompleteEvent.append_to,
            autoFocus: autoCompleteEvent.autoFocus,
            create: function() {
                $(this).data('ui-autocomplete')._resizeMenu = function(){
                    let ul = this.menu.element;
                    ul.width(Math.max( this.element.outerWidth(), RadCommonAutoComplete.getMaxAutoCompleteTableWidth(ul) + 50 ) );
                };
                $(this).data('ui-autocomplete')._renderItem = function( ul, item )
                {
                    let table = $("<table>");
                    let tr = $( "<tr>" );

                    let td = $( "<td class='search-label'>" + item.label + "</td>" );
                    tr.append( td );
                    if( item.hasOwnProperty("columns") && item.columns.length > 0 )
                    {
                        let columns = item.columns;
                        for( let i = 0; i < columns.length; i++)
                        {
                            let column = columns[i];
                            tr.append("<td class='search-column-value'>" + column + "</td>"  );
                        }
                    }
                    tr.appendTo(table);
                    table.appendTo(ul);
                    return table;
                };
            },
            source: function( request, response ) {
                let params = {term: that.extractLast( request.term )}
                if (jQuery(autoCompleteEvent).attr('data-autocomplete-fields')) {
                    jQuery.each(jQuery.parseJSON(jQuery(autoCompleteEvent).attr('data-autocomplete-fields')), function(field, selector) {
                        params[field] = jQuery(selector).val();
                    });
                }
                if(jQuery(autoCompleteEvent).data('excluded-ids')) {
                    params['excluded_ids'] = jQuery(autoCompleteEvent).data('excluded-ids');
                }
                const allowNewModel = jQuery(autoCompleteEvent).data('allow-new-model');
                jQuery.getJSON( jQuery(autoCompleteEvent).attr('data-autocomplete'), params, function() {
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
                        let obj = {};
                        obj[el.id] = el;
                        // Check if record already exists in suggestions
                        if (el.label === request.term) {
                            newOptionExists = true;
                        }
                        jQuery(autoCompleteEvent).data(obj);
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
                    let update_elements = jQuery.parseJSON(jQuery(this).attr("data-update-elements"));
                    let data = ui.item ? jQuery(this).data(ui.item.id.toString()) : {};
                    if(update_elements && jQuery(update_elements['id']).val() == "") {
                        return;
                    }
                    for (let key in update_elements) {
                        let element = jQuery(update_elements[key]);
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
                let term = that.extractLast( this.value );
                if ( term.length < this.min_length ) {
                    return false;
                }
            },
            focus: function() {
                // prevent value inserted on focus
                return false;
            },
            select: function( event, ui ) {
                let terms = that.split( this.value );
                // remove the current input
                terms.pop();
                // add the selected item
                terms.push( ui.item.value );
                // add placeholder to get the comma-and-space at the end
                if (that.delimiter != null) {
                    terms.push( "" );
                    this.value = terms.join( that.delimiter );
                } else {
                    // If allowing new model and the selected item has no id, we do not want to maniupulate
                    // the text as the entered term will be used as the value and supplied to a find_or_create
                    if (ui.item.id !== '' || !this.dataset.allowNewModel) {
                        this.value = terms.join("").replace(/<(?:.|\n)*?>/gm, '');
                    }
                    if (jQuery(this).attr('data-id-element')) {
                        jQuery(jQuery(this).attr('data-id-element')).val(ui.item.id);
                        let idElement = $(this).attr('data-id-element')
                        $(idElement).trigger('change')
                    }
                    if (jQuery(this).attr('data-update-elements')) {
                        let data = jQuery(this).data(ui.item.id.toString());
                        let update_elements = jQuery.parseJSON(jQuery(this).attr("data-update-elements"));
                        for (let key in update_elements) {
                            let element = jQuery(update_elements[key]);
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
                let remember_string = this.value;
                jQuery(this).bind('keyup.clearId', function(){
                    if(jQuery.trim(jQuery(this).val()) != jQuery.trim(remember_string)){
                        jQuery(jQuery(this).attr('data-id-element')).val("");
                        jQuery(this).unbind('keyup.clearId');
                    }
                });
                jQuery(autoCompleteEvent).trigger('railsAutocomplete.select', ui);
                return false;
            }
        });
    }

    split( val ) {
        return val.split( this.delimiter );
    }

    extractLast( term ) {
        return this.split( term ).pop().replace(/^\s+/,"");
    }

    static setup() {
        RadCommonAutoComplete.display_autocomplete_errors();
        jQuery('input[data-autocomplete]').focus( function() {
            new RadCommonAutoComplete(this);
        });
    }

    static display_autocomplete_errors()
    {
        jQuery(".ui-autocomplete-input").each( function()
        {
            RadCommonAutoComplete.display_autocomplete_error(this, "id-element");
            RadCommonAutoComplete.display_autocomplete_error(this, "association-element");
        });
    }

    static display_autocomplete_error(e, data_attribute)
    {
        let formGroup = jQuery(e).parent(".form-group");

        if( jQuery(e).data(data_attribute) )
        {
            let idElement = jQuery( jQuery(e).data(data_attribute) );
            let idFormGroup = idElement.parent(".form-group");

            idFormGroup.find("div.invalid-feedback").each( function()
            {
                formGroup.addClass("form-group-invalid");
                formGroup.append( $(this).clone() );
                jQuery(e).addClass("is-invalid");
            } );
        }
    }

    static getMaxAutoCompleteTableWidth(ul)
    {
        let maxWidth = 0;
        let maxWidths = null;
        ul.show();
        ul.css({width: "100%"});
        $(ul).children("table").each( function()
        {
            $(this).css({width: "auto"});
            let currentWidth = $(this).width();
            if( currentWidth > maxWidth )
            {
                maxWidth = currentWidth;
            }
            maxWidths = RadCommonAutoComplete.getMaxDataWidths( $(this), maxWidths );
            $(this).css({width: "100%"});
        });
        $(ul).children("table").each( function()
        {
            RadCommonAutoComplete.updateMaxWidths( $(this), maxWidths );
        });
        ul.css({width: "auto"});

        return maxWidth;
    }

    static updateMaxWidths( table, maxWidths )
    {
        let i = 0;
        $(table).find("tr td").each( function()
        {
            $(this).width( maxWidths[i] );
            i++;
        });
    }

    static getMaxDataWidths( table, maxWidths )
    {
        let currentWidths = [];
        $(table).find("tr td").each( function()
        {
            currentWidths.push( $(this).width());
        });

        if( maxWidths )
        {
            for( let i = 0; i < maxWidths.length; i++ )
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
}
