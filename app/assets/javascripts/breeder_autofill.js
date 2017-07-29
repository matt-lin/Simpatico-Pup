/**
 * Created by mcgourtyalex on 3/29/15.
 */


var BreederAutofill = {

    // setup sets a callback for #breeder_find keyup
    setup: function() {
        $('#breeder_find').keyup( function() {
            BreederAutofill.breeder_ajax('find')
        });
        $('#breeder_form').keyup(function() {
            BreederAutofill.breeder_ajax('form')
        });
        // $('#breeder_city').keyup(function() {
        //     BreederAutofill.breeder_ajax_address()
        // });
        // $('#breeder_state').keyup(function() {
        //     BreederAutofill.breeder_ajax_address()
        // });
        // $('#cancel_form').click(function () {
        //     $('#breeder_form_collapse').collapse('show');
        //     $('#breeder_well').collapse('hide');
        //     $('#invisible_field').val('');
        // });
    }

    // ajax call to breeder/match/
    // GET call with params name and limit
    ,breeder_ajax: function (success_type) {

        // grab prefix from either find or form text
        var prefix = success_type == 'find' ? $("#breeder_find").val() : $('#breeder_form').val();
        $.ajax({
            type: 'GET',
            url: '/breeder/match',
            data: {
                "name": prefix,
                "limit": 10
            },
            timeout: 5000,
            // callback designated by selection of find or form
            success: success_type == 'find' ? BreederAutofill.breeders_add_find : BreederAutofill.breeders_add_form
        })
    }

    // callback for breeder_ajax creates links for max 5 relevant breeders
    // class .autofills wraps each autofill
    // id #breeder_find contains .autofills
    // class .autofill_link links to each breeder's average ratings page
    ,breeders_add_find: function (data, requestStatus, xhrObject) {

        $('#breeder_find_autofills').empty();
        var datasize = (data.length > 5)? 5: data.length;
        for (var i = 0; i < datasize; i++) {
            var name = data[i].name;
            var city = data[i].city;
            var state = data[i].state;
            var html = '<div class="autofills"><a class="autofill_link">' + name + ' - ' + city + ", " + state + '</a></div>';
            var autofill = $(html);
            $('#breeder_find_autofills').append(autofill);

            // bind autofill on scroll over option
            autofill.click(function() {
                var text = $(this).text();
                $('#breeder_find').val(text);
                $('#breeder_find_autofills').empty();
            });
        }
    }

    ,breeders_add_form: function (data, requestStatus, xhrObject) {
        $('#autofills').empty();
        for (num in data) {
            var id = data[num].id;
            var name = data[num].name;
            var city = data[num].city;
            var state = data[num].state;
            var html = '<div class="autofills"><a class="autofill_link">' + name + ' - ' + city + ", " + state + '</a></div>';
            var autofill = $(html);
            $('#autofills').append(autofill);

            // on click, fill form name value and form id value
            function autofill_return(id) {
                return function () {
                    var text = $(this).text();
                    $('#autofills').empty();
                    $('#breeder_form').val(text);
                    $('#invisible_id').val(id);
                }
            }

            autofill.click(autofill_return(id));
        }

        // if a new breeder is selected, let id be -1
        // var html = '<div class="autofills"><a class="autofill_link">' + "Don't see the breeder that you're looking for? Add a new breeder to our database" + '</a></div>';
        // var new_breeder = $(html);
        // $('#autofills').append(new_breeder);
        //
        // new_breeder.click(function () {
        //     var text = $(this).text();
        //     $('#autofills').empty();
        //     $('#invisible_field').val('new');
        //     $('#breeder_form_collapse').collapse('hide');
        //     $('#breeder_well').collapse('show');
        // });
    }
};



$(document).ready(function () {
    $(BreederAutofill.setup);
});