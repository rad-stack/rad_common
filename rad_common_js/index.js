import {RadCommonGlobalSearch} from "./src/radCommonGlobalSearch";
import {RadCommonAutoComplete} from "./src/radCommonAutoComplete";

import $ from 'jquery'

$(document).ready( function() {
    RadCommonAutoComplete.setup();
    RadCommonGlobalSearch.setup();
})
