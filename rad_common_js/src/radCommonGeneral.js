import $ from 'jquery'

export class RadCommonGeneral {
    static setup() {
        $("#merge-all").click(function() {
            return $(".merge_data").prop("checked", true);
        });

        $('#search_page_size').change(function() {
            return $(this).closest('form').submit();
        });

        this.checkExternalUser();
        $('#user_external').on('change', function() {
            return RadCommonGeneral.checkExternalUser();
        });
        this.checkMessageType();
        $('#system_message_message_type').on('change', function() {
            return RadCommonGeneral.checkMessageType();
        });

        this.duplicates();
        this.readmore();
        this.arrayFields();
        this.termsAndConditions();
    }

    static duplicates() {
        let columnWidths;
        if($("#other-duplicates-table").length) {
            columnWidths = [];
            $("#other-duplicates-table th").each(function() {
                return columnWidths.push($(this).width());
            });
            $("#current-duplicate-table th").each(function(index) {
                return $(this).width(columnWidths[index]);
            });
        }
    }

    static arrayFields() {
        $(".array-add-btn").click(function() {
            let clone;
            clone = $(this).closest(".form-group").find("input").last().clone();
            clone.val("");
            $(clone).insertBefore($(this));
        });
    }

    static readmore() {
        if ($('.read-more').length) {
            $('.read-more').readmore({
                speed: 75,
                moreLink: "<a class='btn btn-primary btn-sm read-more-btn more-btn' href='#'><div>Read more</div></a>",
                lessLink: "<a class='btn btn-primary btn-sm read-more-btn close-btn' href='#'><div>Close</div></a>",
                embedCSS: false
            });
        }
    }

    static checkExternalUser() {
        if ($('#user_external').is(':checked')) {
            $('.internal').hide();
            return $('.external').show();
        } else {
            $('.internal').show();
            return $('.external').hide();
        }
    };

    static checkMessageType() {
        if ($('#system_message_message_type').val() === 'email') {
            $('.email-message').show();
            return $('.sms-message').hide();
        } else {
            $('.sms-message').show();
            return $('.email-message').hide();
        }
    };

    static termsAndConditions() {
      if($('#accept_terms').length) {
        $('#accept_terms').on('change', (event) => {
          if($(event.target).is(':checked')) {
            $(':submit').prop('disabled', false)
          } else {
            $(':submit').prop('disabled', true)
          }
        })
      }
    }
}
