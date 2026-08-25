(async function () {
  new Chart(document.getElementById("salesPerCustomerTypeContainer"), {
    type: "bar",
    data: {
      labels: ["Type 1", "Type 2", "Type 3", "Type 4", "Type 5"],
      datasets: [
        {
          label: "Sales Revenue",
          data: [10000, 29139, 1999, 9123, 100],
          backgroundColor: ["#3e5c76"],
          hoverOffset: 4,
        },
      ],
    },
    options: {
      indexAxis: "y",
    },
  });
})();
