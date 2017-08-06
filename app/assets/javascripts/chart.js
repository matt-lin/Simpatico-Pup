var chart = {
    op: {
            scale: {
                ticks: {
                    max: 5,
                    min: 0,
                    stepSize: 1,
                    fontSize: 14
                }, 
                pointLabels: { 
                    fontSize: 14
                }
            },
            title: {
                fontSize: 16,
                display: true,
                text: 'Your pup vs. Breed average'
            }
    },
    
    ratings: ["Breeder Responsibility", "Health", "Trainability", "Human Social Behavior", 
                "Dog Social Behavior", "Energy Level", "Simpatico Rating"],
                
    setup: function () {
        var ctx = $('#radar_chart');
        if (ctx.length == 1) {
            var pupArray = chart.getPupRating('/pups/ratings');
            var avgArray = chart.getPupRating('/pups/breed_avg_ratings');
            chart.setupChart(ctx, pupArray, avgArray);
        }
    },
    
    getPupRating: function(path) {
        var pathArray = window.location.pathname.substring(1).split('/');
        var pupId = pathArray[1];
        var dataArray = [];
        $.ajax({
            type: 'GET',
            url: path,
            data: {
                "pup_id": pupId
            },
            contentType: 'application/json',
            dataType: 'json',
            timeout: 5000,
            async: false,
            success: function(data) {
                for (var key in data) {
                    dataArray.push(data[key]);
                }
            }
        });
        return dataArray;
    },
    
    setupChart: function(ctx, pupArray, avgArray) {
        var myChart = new Chart(ctx, {
            type: 'radar',
            data: {
                labels: chart.ratings,
                datasets: [
                    {
                        label: 'Your ratings',
                        data: pupArray,
                        backgroundColor: 'rgba(0, 255, 0, 0.1)',
                        borderColor: '#5FBF3F',
                        borderWidth: 2,
                    },
                    {
                        label: 'Breed average ratings',
                        data: avgArray,
                        backgroundColor: 'rgba(255, 15, 15, 0.1)',
                        borderColor: '#FF0F0F',
                        borderWidth: 2,
                    }
                ]
            },
            options: chart.op
        });
    }
}

$(document).ready(function () {
    $(chart.setup);
});
