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
            $('<a number="' + hashtag + '" class="hashtag">' + PupHashTags.hashtags[hashtag] + ' </a>').appendTo('#hashtags').click( function() {

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
    
    ,preTag: function () {
        let pathArray = window.location.pathname.substring(1).split('/');
        console.log(pathArray)
        if (pathArray.length == 3 && pathArray[2] === 'edit') {
            let pupId = parseInt(pathArray[1]);
            console.log(pupId);
            
            $.ajax({
                type: 'GET',
                url: '/pups/hashtags',
                data: {
                    "pup_id": pupId
                },
                contentType: 'application/json',
                dataType: 'json',
                timeout: 5000,
                // callback designated by selection of find or form
                success: function(data) {
                    console.log(data);
                },
                error: function() {
                    console.log("fail to get hashtag");
                }
            })
            
            // $.ajax({
            //     type: 'GET',
            //     url: '/pup/hashtags',
            //     data: {
            //         'pup_id': pupId
            //     },
            //     contentType: 'application/json',
            //     dataType: 'json',
            //     timeout: 50000,
            //     success: function(data) {
            //         console.log("asd");
            //         console.log(data);
            //     },
            //     error: function() { 
            //         console.log("fail"); 
            //     } 
            // });
        }
    }
};


$(document).ready(function () {
    $(PupHashTags.setup);
    PupHashTags.preTag();
});
