/**
 * Created by mcgourtyalex on 4/29/15.
 */

var PupHashTags = {

    hashtags: [
        "#EasyToObedienceTrain",
        "#HardToObedienceTrain",
        "#EasyToHouseTrain",
        "#HardToHouseTrain",
        '##ReallySmartDog',
        "#CalmPersonality",
        "#BarksALot",
        "#VeryQuiet",
        "#OnePersonDog",
        "#FriendlyTowardEveryone",
        "#UnpredictableWithStrangers",
        "#UnpredictableWithChildren",
        "#Independent",
        "#ConstantCompanionAroundHome",
        "#GreatWithCats&OtherSmallAnimals",
        "#UnpredictableWithCats&OtherSmallAnimals",
        "#LovesToPlayBall&Fetch",
        "#WellMannered&CanGoAnywhereWithMe",
        "#ShedsALot",
        "#CoatNeedsFrequentGrooming",
        "#EatsPoopOrOtherDisgustingThings"
    ]

    ,num: 0

    ,setup: function() {
        for (hashtag in PupHashTags.hashtags) {
            $('<a number="' + hashtag + '" class="hashtag" id=hashtag'+hashtag+'>' + PupHashTags.hashtags[hashtag] + ' </a>').appendTo('#hashtags').click( function() {

                if ($(this).attr('class').indexOf("hashtag_selected") > -1) {
                    $(this).removeClass('hashtag_selected');
                    PupHashTags.num--;
                    this_id = parseInt($(this).attr('number'));

                    if ($('#invisible_hashtag_1').val() == PupHashTags.hashtags[this_id]) {
                        $('#invisible_hashtag_1').val("")
                    } else if ($('#invisible_hashtag_2').val() == PupHashTags.hashtags[this_id]) {
                        $('#invisible_hashtag_2').val("")
                    } else {
                        $('#invisible_hashtag_3').val("")
                    }
                } else {
                    if (PupHashTags.num < 3) {
                        this_id = parseInt($(this).attr('number'))
                        if ($('#invisible_hashtag_1').val() == "") {
                            $('#invisible_hashtag_1').val(PupHashTags.hashtags[this_id])
                        } else if ($('#invisible_hashtag_2').val() == "") {
                            $('#invisible_hashtag_2').val(PupHashTags.hashtags[this_id])
                        } else {
                            $('#invisible_hashtag_3').val(PupHashTags.hashtags[this_id])
                        }


                        $(this).addClass('hashtag_selected');
                        PupHashTags.num++;
                    }
                }
            });
        }
    }
    // Iter 3-2 (Gilbert Lo, Jeff Yu)
    ,preTag: function () {
        var pathArray = window.location.pathname.substring(1).split('/');
        if (pathArray.length == 3 && pathArray[2] === 'edit') {
            var pupId = parseInt(pathArray[1]);
            
            $.ajax({
                type: 'GET',
                url: '/pups/hashtags',
                data: {
                    "pup_id": pupId
                },
                contentType: 'application/json',
                dataType: 'json',
                timeout: 5000,
                success: function(data) {
                    for (var i = 0; i < data.length; i += 1) {
                        if (data[i]) {
                            var index = PupHashTags.hashtags.indexOf(data[i]);
                            $(".hashtag[number=" + index + "]").click()
                        }
                    }
                },
                error: function() {
                    console.log("fail to get hashtag");
                }
            })
        }
    }
    //End Iter 3-2
};


$(document).ready(function () {
    $(PupHashTags.setup);
    PupHashTags.preTag();
});
