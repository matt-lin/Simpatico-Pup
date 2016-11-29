/**
 * Created by mcgourtyalex on 4/14/15.
 */

var MainButtons = {

    // setup sets a callback for #breeder_find keyup   
    setup: function() {
        $('.button-a').hover( function() {
            $('#tagline-text').html("Find Dog Breeders Near You");
        });

        $('.button-b').click( function() {
            $('.box-b').toggleClass("hidden");
        }).hover( function() {
            $('#tagline-text').html("Find the <strong>right</strong> breed for you");
        });

        $('#cancel-b').click( function() {
            $('.box-b').toggleClass("hidden");
        });

        $('.button-c').click( function() {
            $('.box-c').toggleClass("hidden");
        }).hover( function() {
            $('#tagline-text').html("Find a dog breeder with <strong>great</strong> reviews");
        });

        $('#cancel-c').click( function() {
            $('.box-c').toggleClass("hidden");
        });
    }
};


$(document).ready(function () {
    $(MainButtons.setup);
});