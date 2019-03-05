import Chart from 'chart.js';

const initChart = () => {
  const alertCharts = document.querySelectorAll(".alert-chart");

  alertCharts.forEach((alertChart) => {
    const lowestPrices = JSON.parse(alertChart.dataset.lowestPrices);

    const labels = ["J-6", "J-5", "J-4", "J-3", "J-2", "J-1", "Today"];

    var ctx = alertChart.getContext('2d');
    var myChart = new Chart(ctx, {
        // The type of chart we want to create
        type: 'line',

        // The data for our dataset
        data: {
            labels: labels.slice(7 - lowestPrices.length),
            datasets: [{
                label: "Price evolution over time",
                backgroundColor: 'rgb(255, 99, 132)',
                borderColor: 'rgb(255, 99, 132)',
                fill: false,
                borderWidth: 2,
                data: lowestPrices,
            }]
        },

        // Configuration options go here
         options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });
  });
};

export { initChart };
