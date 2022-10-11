import moment from 'moment';

export class DateSetup {
    static setup() {
        $('input[type=date]').focus(function(){
            if($(this).val() === '') {
                $(this).val(moment().format('YYYY-MM-DD'));
            }
        });

        $('input[type=datetime-local]').focus(function(){
            if($(this).val() === '') {
                $(this).val(moment().format('YYYY-MM-DDTHH:mm'));
            }
        });
    }
}
