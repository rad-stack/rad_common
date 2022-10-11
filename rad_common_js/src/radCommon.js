import $ from 'jquery';

require('jquery');
require("@rails/ujs").start();
require('popper.js')
require('bootstrap');
require('bootstrap-select');
require('readmore-js');
require('jquery.are-you-sure');
require('bootstrap-select');
import {RadCommonGlobalSearch} from "./radCommonGlobalSearch";
import {RadCommonAutoComplete} from "./radCommonAutoComplete";
import {RadCommonDynamicUpdater} from "./radCommonDynamicUpdater";
import {RadCommonGeneral} from "./radCommonGeneral";
import {AreYouSure} from "./areYouSure";
import {DeviseAuthy} from "./deviseAuthy";
import {RadChosen} from "./radChosen";
import {DateSetup} from "./dateSetup";

export class RadCommon {
    static setup(options) {
        $(document).ready( function() {
            RadCommonAutoComplete.setup();
            RadCommonGlobalSearch.setup();
            RadCommonGeneral.setup();
            RadCommonDynamicUpdater.setup();
            AreYouSure.setup();
            DeviseAuthy.setup();
            RadCommon.bootstrapSetup();
            RadChosen.setup();
            DateSetup.setup();
        })
    }

    static bootstrapSetup() {
        $('[data-toggle="tooltip"]').tooltip();
        $('[data-toggle="popover"]').popover();
    }
}
