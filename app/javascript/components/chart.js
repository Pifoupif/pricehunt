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

    const labels = ["d-6", "d-5", "d-4", "d-3", "d-2", "d-1", "Today"];
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
    pointRadius: 0,
    fill: false,
    borderWidth: 2,
    data: lowestPrices,
  }, {
    data: targetPrices,
    label: "Target price",
    borderColor: "#4FB6FF",
    pointRadius: 0,
    borderWidth: 2,
  }]
},

// Configuration options go here
options: {
  responsive: true,
    maintainAspectRatio: false,
    legend: {
      display: false
    },
    tooltips: {
      bodySpacing: 4,
      mode:"nearest",
      intersect: 0,
      position:"nearest",
      xPadding:1,
      yPadding:1,
      caretPadding:1
    },
    layout:{
      padding:{left:15,right:15,top:5,bottom:5}
    },
  scales: {
    yAxes: [{
      ticks: {
        beginAtZero:false
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
