var chart = {
    setup: function () {
        var ctx = $('#myChart');
        var myChart = new Chart(ctx, {
            type: 'radar',
            data: {
                labels: ["Breeder Responsibility", "Health", "Trainability", "Human Social Behavior", "Dog Social Behavior", "Energy", "Simpatico"],
                datasets: [
                    {
                        label: 'Dog ratings',
                        data: [5, 2, 0, 1, 5, 3, 5],
                        backgroundColor: 'rgba(0, 255, 0, 0.1)',
                        borderColor: '#5FBF3F',
                        borderWidth: 2,
                        pointLabelFontSize: 20
                    },
                    {
                        label: 'Breed average ratings',
                        data: [1, 1, 5, 2, 3, 2.4, 5],
                        backgroundColor: 'rgba(255, 15, 15, 0.1)',
                        borderColor: '#FF0F0F',
                        borderWidth: 2,
                        pointLabelFontSize: 20
                    }
                ]
            },
            options: {
                scale: {
                    ticks: {
                        max: 5,
                        stepSize: 1,
                        fontSize: 12
                    }, 
                    pointLabels: { 
                        fontSize: 14,
                    }
                },
                title: {
                    display: true,
                    text: 'Your pup vs. Breed average'
                }
            }
        });
    }
}

$(document).ready(function () {
    $(chart.setup);
});