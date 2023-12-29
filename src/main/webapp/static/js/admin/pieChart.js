// Your data about genres and book amounts
const genresData = [
    {genre: "Fiction", amount: 30},
    {genre: "Non-fiction", amount: 20},
    {genre: "Mystery", amount: 15},
    // Add more genres and amounts as needed
];

// Extract labels and data for the chart
const labels = genresData.map(item => item.genre);

const data = genresData.map(item => item.amount);

// Set up a blue color palette
const colors = [
    '#3498db',
    '#2ecc71',
    '#9b59b6',
    // Add more colors as needed
];

// Create a pie chart
const ctx = document.getElementById('myPieChart').getContext('2d');
const myPieChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: labels,
        datasets: [{
            data: data,
            backgroundColor: colors,
        }]
    },
    options: {
        responsive: true,
        legend: {
            display: false, // Disable default legend
        },
        tooltips: {
            callbacks: {
                label: (tooltipItem, data) => {
                    const label = data.labels[tooltipItem.index];
                    const value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                    return `${label}: ${value}`;
                }
            }
        }
    }
});