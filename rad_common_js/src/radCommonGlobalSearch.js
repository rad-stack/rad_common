import $ from 'jquery';
require('jquery-ui');
require('jquery-ui/ui/widgets/autocomplete');

export class RadCommonGlobalSearch {
    static setup() {
        $(".search-option").click(function() {
            $('.global_search_scope').val($(this).data("search-scope"));
            $(".global_search_name").focus();
            $(".global_search_name").attr("placeholder", $(this).html());
            return $(".global_search_name").val("");
        });

        $(".global-search-autocomplete").bind("autocompleteselect", function(event, ui) {
            return RadCommonGlobalSearch.select_global_search_item($(this), event, ui);
        });
        $(".content .global-search-autocomplete").bind("autocompletefocus", function(event, ui) {
            return RadCommonGlobalSearch.select_global_search_item($(this), event, ui);
        });

        $('.global-search-autocomplete').each(function(index, object) {
            var instance;
            instance = $(object).autocomplete().autocomplete("instance");
            return instance._renderItem = function(ul, item) {
                var column, columns, i, j, ref, table, td, tr;
                table = $("<table>");
                tr = $("<tr>");
                td = $("<td class='search-label'>" + item.label + "</td>");
                tr.append(td);
                if (item.hasOwnProperty("columns") && item.columns.length > 0) {
                    columns = item.columns;
                    for (i = j = 0, ref = columns.length; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
                        column = columns[i];
                        if (column !== void 0) {
                            tr.append("<td class='search-column-value'>" + column + "</td>");
                        }
                    }
                }
                tr.appendTo(table);
                if (item.scope_description !== void 0 && $('.super_search').val() === '1') {
                    tr = $("<tr>");
                    tr.append("<td class='search-scope-model-name'>" + item.human_name + "</td>");
                }
                tr.appendTo(table);
                table.appendTo(ul);
                return table;
            };
        });

        $(".global_search_name").on("keyup keypress", function(e) {
            let code;
            code = e.keyCode || e.which;
            if (code === 13) {
                e.preventDefault();
                return false;
            }
        });

        this.superSearchEvents();
    }

    static select_global_search_item(item, event, ui) {
        let form;
        $("input[name=global_search_id]").val(ui.item.id);
        $("input[name=global_search_model_name]").val(ui.item.model_name);
        form = item.closest("form");
        return setTimeout((function() {
            form.submit();
        }), 300);
    }

    static superSearchEvents() {
        let defaultGlobalSearchPlaceholder = $('.global-search-autocomplete').attr('placeholder');

        $(".super_search").change(function() {
            if ($(this).prop('checked')) {
                return $(this).prop('checked', confirm('Are you sure you want to do a super (combined) search? This query may take a long time, selecting a normal query is preferred to get your results quickly and not bog down the system.'));
            }
        });

        if ($('.super_search').val() === '1') {
            $('.super_search').prop('checked', true);
            $('.global-search-autocomplete').attr('placeholder', 'Super Search');
            $('.global-search-dropdown').toggle();
        }
        $('.super_search').change(function(event) {
            if ($(this).is(':checked')) {
                $('.super_search').val('1');
                $('.global-search-autocomplete').attr('placeholder', 'Super Search');
            } else {
                $('.super_search').val('0');
                $('.global-search-autocomplete').attr('placeholder', defaultGlobalSearchPlaceholder);
            }
            return $('.global-search-dropdown').toggle();
        });
    }
}
