require('chosen-js/chosen.jquery.min');
import 'chosen-js/chosen.min.css';

export class RadChosen {
    static setup() {
        $('.rad-chosen').chosen({
            allow_single_deselect: true,
            no_results_text: 'No matching records found',
            width: '100%'
        });
    }
}
