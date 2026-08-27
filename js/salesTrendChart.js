(async function () {
  (async function () {
    new Chart(document.getElementById("salesTrendChartContainer"), {
      type: "line",
      data: {
        labels: ["January", "February", "March", "April"],
        datasets: [
          {
            type: "line",
            label: "Total Spent",
            data: [10000, 20000, 39123, 4092, 0],
            fill: true,
            borderColor: "#3e5c76",
            backgroundColor: "#a0b9cfe0",
            tension: 0.2,
          },
          {
            type: "line",
            label: "Total Profit",
            data: [10120, 123992, 19238, 59934, 23, 99, 100, 0],
            fill: true,
            borderColor: "#58a73a",
            backgroundColor: "#a5ce95ea",
            tension: 0.2,
          },
        ],
      },
    });
  })();
})();
