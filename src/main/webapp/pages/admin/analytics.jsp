<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>

<html lang="${language}">
<head>
    <meta charset="UTF-8"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>Library Main</title>
    <%--    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/analytics.css"/>--%>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">
    <%--    <script type="text/javascript" src="${pageContext.request.contextPath}/pages/admin/js/pieChart.js"></script>--%>
</head>
<body>
<security:csrfMetaTags/>
<jsp:include page="../common/header.jsp"/>

<div class="container">

    <div class="main-content">
        <div class="top-row">
        </div>
        <canvas id="genresDistributionPieChart" width="400px" height="400px"></canvas>
        <canvas id="genresDistributionBarChart" width="800px" height="400px"></canvas>

    </div>


</div>
<jsp:include page="../common/footer.jsp"/>

</body>
<script>
    class ChartGenerator {
        constructor(data, options, chartName, chartType, title, dataLabel) {
            this.data = data;
            this.options = options;
            this.chartName = chartName;
            this.chartType = chartType;
            this.title = title;
            this.dataLabel = dataLabel;
            this.initializeChart();
        }

        initializeChart() {
            const ctx = document.getElementById(this.chartName).getContext('2d');
            this.chart = new Chart(ctx, {
                type: this.chartType,
                data: {
                    labels: this.data.map(item => item.genre),
                    datasets: [{
                        label: this.dataLabel,
                        data: this.data.map(item => item.amount),
                    }]
                },
                options: {
                    responsive: false, // Disable responsiveness
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: this.title,
                                fontColor: 'black', // Set title font color
                                fontSize: 16, // Set title font size to 16
                            },
                        },
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: this.title,
                            fontSize: 16, // Set title font size to 16
                            fontColor: 'black', // Set title font color
                        },
                    },
                    ...this.options, // Allow additional options to be passed
                }
            });
        }

        updateChartData(newData) {
            // Update the chart with new data
            this.chart.data.labels = newData.map(item => item.genre);
            this.chart.data.datasets[0].data = newData.map(item => item.amount);
            this.chart.update(); // Update the chart
        }
    }

    // Your data about genres and book amounts
    let genresData = fetchGenresDistributionData(); // Set genresData initially

    const commonOptions = {
        legend: {
            display: false, // Disable default legend
        },
        tooltips: {
            callbacks: {
                label: (tooltipItem, data) => {
                    const label = data.labels[tooltipItem.index];
                    const value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                    return label + ": " + value;
                }
            }
        },
    };

    // Determine the language
    const language = $("html").attr("lang");

    // Create pie chart with title based on language
    const genreDataLabel = language === 'ua' ? 'Кількість книжок' : 'Amount of Books';
    const pieChartTitle = language === 'ua' ? 'Розподіл книжок за жанрами' : 'Distribution of books by Genre';
    const genresDistributionPieChart = new ChartGenerator(genresData, commonOptions, 'genresDistributionPieChart', 'pie', pieChartTitle, genreDataLabel);

    // Create bar chart with title and y-axis legend based on language
    const barChartTitle = language === 'ua' ? 'Розподіл книжок за жанрами' : 'Distribution of books by Genre';
    const genresDistributionBarChart = new ChartGenerator(genresData, commonOptions, 'genresDistributionBarChart', 'bar', barChartTitle, genreDataLabel);

    function fetchGenresDistributionData() {
        let csrfToken = $("meta[name='_csrf']").attr("content");
        let csrfHeader = $("meta[name='_csrf_header']").attr("content");

        let result;

        $.ajax({
            type: "GET",
            url: '/admin/analytics/books-distribution',
            async: false, // Make the request synchronous
            success: function (response) {
                // Transform the JSON response into an array of objects
                result = Object.keys(response).map(key => ({
                    genre: key.replace(/Genre\(id=\d+, title=/, '').replace(')', ''),
                    amount: response[key]
                }));
            },
            error: function (error) {
                console.log("Operation failed!", error);
                window.location.href = "/error/400";
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        });

        return result;
    }
</script>

</html>
