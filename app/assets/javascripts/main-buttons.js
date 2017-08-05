

var MainButtons = {

    // setup sets a callback for #breeder_find keyup   
    setup: function() {

        $('.button-b').click( function() {
            $('.box-b').toggleClass("hidden");
        });
        
        $('#cancel-b').click( function() {
            $('.box-b').toggleClass("hidden");
        });

        $('.button-c').click( function() {
            $('.box-c').toggleClass("hidden");
        });

        $('#cancel-c').click( function() {
            $('.box-c').toggleClass("hidden");
        });
        
        function pageSlide(event, dest) {
            event.preventDefault();
            $('html,body').animate({
              scrollTop: dest},'slow');
        }

        $('#to_goal_button').click( function(e) {
            // e.preventDefault();
            // $('html,body').animate({
            //   scrollTop: $(".page_divider1").offset().top-50},
            // 'slow');
            pageSlide(e, $(".page_divider1").offset().top-50);
        });
        
        $('#to_inline_button_button').click( function(e) {
            // e.preventDefault();
            // $('html,body').animate({
            //   scrollTop: $(".page_divider2").offset().top-100},
            // 'slow');
            pageSlide(e, $(".page_divider2").offset().top-100);
        });
    },
    slider: function() {
        var slideIndex = 1;
        showSlides(slideIndex);
        
        function plusSlides(n) {
            $.ajax({
                type: 'GET',
                url: '/pups/random_comment',
                data: {},
                contentType: 'application/json',
                dataType: 'json',
                timeout: 5000,
                success: function(data) {
                    console.log(data["content"])
                    console.log($("#tagline-text").text())
                    $("#tagline-text_comment").text('"' + data["content"] + '"')
                    $("#tagline-text_breed").text('---- '+data["breed"])
                },
                error: function() {
                    console.log("fail");
                }
            })
          slideIndex += n;
          showSlides(slideIndex);
        }
        
        function currentSlide(n) {
          showSlides(slideIndex = n);
        }
        
        $('#arrow_left').click(function(){
            plusSlides(-1);
        });
        
        $('#arrow_right').click(function(){
            plusSlides(-1);
        });        
        
        function showSlides(n) {
          var i;
          var slides = document.getElementsByClassName("slider");
          if (n > slides.length) {slideIndex = 1} 
          if (n < 1) {slideIndex = 2}
          for (i = 0; i < slides.length; i++) {
              slides[i].style.display = "none"; 
          }
          slides[slideIndex-1].style.display = "block"; 
        }
    }
};


$(document).ready(function () {
    $(MainButtons.setup);
    if(window.location.pathname === '/') {
        MainButtons.slider();
    }
});