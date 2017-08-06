var chart = {
    op: {
            scale: {
                ticks: {
                    max: 5,
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
    setup: function () {
        var ctx = $('#myChart');
        var myChart = new Chart(ctx, {
            type: 'radar',
            data: {
                labels: ["Breeder Responsibility", "Health", "Trainability", "Human Social Behavior", "Dog Social Behavior", "Energy Level", "Simpatico Rating"],
                datasets: [
                    {
                        label: 'Your ratings',
                        data: [5, 2, 0, 1, 5, 3, 5],
                        backgroundColor: 'rgba(0, 255, 0, 0.1)',
                        borderColor: '#5FBF3F',
                        borderWidth: 2,
                    },
                    {
                        label: 'Breed average ratings',
                        data: [1, 1, 5, 2, 3, 2.4, 5],
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