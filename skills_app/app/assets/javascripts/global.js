(function(global){
    global.App = global.App || {};
    global.App.autocomplete = function(){
        $(".autocomplete").each(function(){
            var field = $(this);
            field.autocomplete({
                source: field.data("autocomplete-data")
            });
        });
    };
}(this));


$(document).ready(App.autocomplete);
$(document).on('page:load', App.autocomplete);
