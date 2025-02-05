import moment from 'moment';

export class DateSetup {
  static setup() {
    $('input[type=date]').focus(function(){
      if($(this).val() === '' && !$(this).prop('readonly')) {
        $(this).val(moment().format('YYYY-MM-DD'));
        $(this).trigger('change');
      }
    });

    $('input[type=datetime-local]').focus(function(){
      if($(this).val() === '' && !$(this).prop('readonly')) {
        $(this).val(moment().format('YYYY-MM-DDTHH:mm'));
        $(this).trigger('change');
      }
    });
  }
}
