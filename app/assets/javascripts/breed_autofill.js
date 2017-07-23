/**
 * Created by mcgourtyalex on 3/29/15.
 */


var BreedAutofill = {

    // setup sets a callback for #breeder_find keyup
    setup: function() {
        
        $('#breed_find').keyup(function() {
            BreedAutofill.breed_ajax()
        })
    }

    // ajax call to breeder/match/
    // GET call with params name and limit
    ,breed_ajax: function () {

        // grab prefix from either find or form text
        var prefix = $("#breed_find").val();
        console.log(prefix);
        $.ajax({
            type: 'GET',
            url: '/breed/match',
            data: {
                "name": prefix
            },
            timeout: 5000,
            // callback designated by selection of find or form
            success: BreedAutofill.breeds_add_find
        })
    }

    // callback for breeder_ajax creates links for max 10 relevant breeders
    // class .autofills wraps each autofill
    // id #breeder_find contains .autofills
    // class .autofill_link links to each breeder's average ratings page
    ,breeds_add_find: function (data, requestStatus, xhrObject) {
        
        $('#breed_autofills').empty();
        datasize = (data.length > 5)? 5: data.length;
        console.log(datasize)
        for (i = 0; i < datasize; i++) {
            var name = data[i];
            var html = '<div class="autofills"><a class="autofill_link">' + name + '</a></div>';
            var autofill = $(html);
            $('#breed_autofills').append(autofill);

            autofill.click(function() {
                var text = $(this).text();
                $('#breed_find').val(text);
                $('#breed_autofills').empty();
            });
        }
    }
};



$(document).ready(function () {
    $(BreedAutofill.setup);
});