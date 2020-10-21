//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require editable/bootstrap-editable
//= require editable/inputs-ext/wysihtml5
//= require editable/inputs-ext/bootstrap-wysihtml5
//= require editable/inputs-ext/wysihtml5-editable
//= require editable/rails
//= require api
//= require jquery-ui
//= require projects
//= require tasks
//= require_self
//= require i18n
//= require i18n.js
//= require i18n/translations



jQuery.fn.reverse = [].reverse;

$(window).bind('load', function(event) {
    $.api.controller     = document.body.id;
    $.api.action         = document.body.attributes['data-action'].value;
    $.api.body = $(document.body);
    $('div#new-project').hide();

    var controllerPath = $.camelCase($.api.controller);
    var controllerJs   = $.api[ controllerPath ];

    I18n.locale = $('body').data('locale')
    if ( typeof controllerJs === 'object' ) controllerJs.init();

    $.api.loading = false;

    $.api.body.on('click', 'a.disabled', function(event) {
        event.preventDefault();
        event.stopPropagation();
    });
    $.fn.editable.defaults.error =
        function(response, newValue) {
            var field_name = $(this).data('name'),
                error_msgs = response.responseJSON[field_name];
            return error_msgs.join("; ");
        };

});
