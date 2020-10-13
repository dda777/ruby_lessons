//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require editable/bootstrap-editable
//= require api
//= require jquery-ui
//= require projects
//= require tasks
//= require_self



//

jQuery.fn.reverse = [].reverse;

$(window).bind('load', function(event) {
    $.api.controller     = document.body.id;
    $.api.action         = document.body.attributes['data-action'].value;
    $.api.body = $(document.body);
    $('div#new-project').hide();

    var controllerPath = $.camelCase($.api.controller);
    var controllerJs   = $.api[ controllerPath ];


    if ( typeof controllerJs === 'object' ) controllerJs.init();

    $.api.loading = false;

    $.api.body.on('click', 'a.disabled', function(event) {
        event.preventDefault();
        event.stopPropagation();
    });

});
