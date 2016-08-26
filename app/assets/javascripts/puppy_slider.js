/**
 * Created by mcgourtyalex on 4/20/15.
 */



var myIndex = 0;
var PupSlider = {
    carousel: function() {
        var i;
        var x = document.getElementsByClassName("mySlides");
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        myIndex++;
        if (myIndex > x.length) {myIndex = 1}
        x[myIndex-1].style.display = "block";
        setTimeout(PupSlider.carousel, 3000); // Change image every 3 seconds
    },
    // setup sets a callback for #breeder_find keyup
    setup: function() {
        //PupSlider.carousel(myIndex);
        //PupSlider.puppy_change(7);
        /*var pup_num = 2;
        var interval = setInterval(function() {
            PupSlider.puppy_change((pup_num++ + 1) % 7 + 1);
        }, 5000);
        */
    },
    puppy_change: function(pup_num) {
        if (window.location.pathname == "/") {
            $('body').css("background-image", "url('/assets/pup" + pup_num + ".jpg')");
        }
    }
};


$(document).ready(function () {
    $(PupSlider.setup);
    $(PupSlider.carousel);
});
