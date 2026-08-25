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
            data: [10000, 20000, 39123, 4092],
            fill: true,
            borderColor: "#3e5c76",
            backgroundColor: "#a0b9cfe0",
          },
          {
            type: "line",
            label: "Total Income",
            data: [10120, 123992, 19238, 59934],
            fill: true,
            borderColor: "#58a73a",
            backgroundColor: "#a5ce95ea",
          },
        ],
      },
    });
  })();
})();
