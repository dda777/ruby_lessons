//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require editable/bootstrap-editable
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

$(window).bind('load', function (event) {
    $.api.controller = document.body.id;
    $.api.action = document.body.attributes['data-action'].value;
    $.api.body = $(document.body);
    $('div#new-project').hide();
    $('div.deadline-display').hide();
    var controllerPath = $.camelCase($.api.controller);
    var controllerJs = $.api[controllerPath];

    I18n.locale = $('body').data('locale')
    if (typeof controllerJs === 'object') controllerJs.init();

    $.api.loading = false;

    $.api.body.on('click', 'a.disabled', function (event) {
        event.preventDefault();
        event.stopPropagation();
    });
    $.fn.editable.defaults.error =
        function (response, newValue) {
            var field_name = $(this).data('name'),
                error_msgs = response.responseJSON[field_name];
            return error_msgs.join("; ");
        };

    function deadline_error(timeNow, timeEnd) {
        for (i = 0; i < timeEnd.length; ++i) {
            if (Date.parse(timeEnd[i].dataset.date) + 86400000 < timeNow && timeEnd[i].dataset.completed === 'false') {
                $('li#task-item-' + timeEnd[i].dataset.id).css('backgroundColor', "#ff78788c");
            }
        }
    }
    // $('span.edit-end-time').on('save', function(e, params) {
    //     var timeNow = Date.now();
    //     console.log(params)
    //     if (Date.parse(params.response.end_time) + 86400000 < timeNow && params.response.completed === false) {
    //         $('li#task-item-' + params.response.id).css('backgroundColor', "#ff78788c");
    //     }else{
    //         $('li#task-item-' + params.response.id).css('backgroundColor', "#fff");
    //     }
    // });

    var timeNow = Date.now();
    var timeEnd = document.querySelectorAll('span.edit-end-time')
    deadline_error(timeNow, timeEnd)
});
