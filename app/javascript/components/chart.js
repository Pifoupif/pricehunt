import Chart from 'chart.js';

const initChart = () => {
  const alertCharts = document.querySelectorAll(".alert-chart");
  alertCharts.forEach((alertChart) => {

    const lowestPrices = JSON.parse(alertChart.dataset.lowestPrices);
    const targetPrice = alertChart.dataset.targetPrice;
    let targetPrices = [];
    lowestPrices.forEach((_price) =>{
      targetPrices.push(targetPrice);
    });

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
                backgroundColor: '#F2C94B',
                borderColor: '#F2C94B',
                fill: false,
                borderWidth: 2,
                data: lowestPrices,
            }, {
              data: targetPrices,
              label: "Target price",
              borderColor: "#4FB6FF",
              borderWidth: 2,
            }]
        },

        // Configuration options go here
         options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    },
                gridLines: {
                display:false
                }
              }],
                yAxes: [{
                    gridLines: {
                      display:false
                    }
                  }]

                }


        }
    });
  });



};

export { initChart };
