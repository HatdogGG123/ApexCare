(async function () {
  new Chart(document.getElementById("dashboardPaymentMethodPieChart"), {
    type: "doughnut",
    data: {
      labels: ["Regular", "Senior Citizen", "PWD", "Student", "Employee"],
      datasets: [
        {
          label: "Sales Revenue",
          data: [485000.0, 320000.0, 210000.0, 28000.0, 42000.0],
          backgroundColor: [
            "#3e5c76", // Darkest (Primary)
            "#607d9c",
            "#819ebd",
            "#a2b8d1",
            "#c3d3e6", // Lightest
          ],
          hoverOffset: 4,
        },
      ],
    },
    options: {
      indexAxis: "y",
    },
  });
})();
