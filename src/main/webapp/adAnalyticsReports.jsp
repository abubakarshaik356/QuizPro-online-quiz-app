<%@ page import="java.util.*"%>
<%@ page import="com.quizpro.dto.Subject"%>
<%@ page import="com.quizpro.dto.UserManage"%>

<%
Integer totalUsers = (Integer) request.getAttribute("totalUsers");
Integer totalQuizzes = (Integer) request.getAttribute("totalQuizzes");
Integer totalSubjects = (Integer) request.getAttribute("totalSubjects");
ArrayList<Subject> subjects = (ArrayList<Subject>) request.getAttribute("subjects");
ArrayList<UserManage> users = (ArrayList<UserManage>) request.getAttribute("users");

if (totalUsers == null) totalUsers = 0;
if (totalQuizzes == null) totalQuizzes = 0;
if (totalSubjects == null) totalSubjects = 0;
if (subjects == null) subjects = new ArrayList<>(); 
if (users == null) users = new ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - Analytics Reports</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
:root {
    --primary-color: #0077B6;
    --accent-color: #FFB700;
    --dark-bg: #F0F2F5;
    --card-bg: #FFFFFF;
    --shadow-light: rgba(0,0,0,0.08);
}

html, body {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
    overflow-x: hidden;  
    overflow-y: auto;   
    font-family: 'Inter', sans-serif;
    background: var(--dark-bg);
    line-height:1.6;
}

.admin-layout {
    display: flex;
    width: 100%;
    min-height: 100vh;
    overflow-x: hidden;
}

.main-content {
    flex: 1;
    padding: 20px;
    max-width: 100%;
    overflow-x: hidden;
}

.card {
    background: var(--card-bg);
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 4px 10px var(--shadow-light);
    overflow: hidden;  /* ✅ critical */
}

.card h3 {
    margin: 0 0 10px 0;
}

/* ===== CHART FIX ===== */
.chart-container {
    position: relative;
    height: 300px;
    width: 100%;
    max-width: 100%;
}

canvas {
    max-width: 100% !important;
    height: auto !important;
    display: block;
}
.charts-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 20px;
}

.full-width {
    width: 97.3%;
}

@media (max-width: 992px) {
    .charts-row {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<div class="admin-layout">

    <%@ include file="adminSideBar.jsp"%>

    <main class="main-content">

        <!-- BAR + PIE -->
        <div class="charts-row">

            <div class="card">
                <h3>Platform Overview</h3>
                <div class="chart-container">
                    <canvas id="barChart"></canvas>
                </div>
            </div>

            <div class="card">
                <h3>Quizzes per Subject</h3>
                <div class="chart-container">
                    <canvas id="pieChart"></canvas>
                </div>
            </div>

        </div>

        <!-- LINE CHART -->
        <div class="card full-width">
            <h3>Users' Quiz Participation</h3>
            <div class="chart-container">
                <canvas id="lineChart"></canvas>
            </div>
        </div>

    </main>
</div>

<script>
/* ===== BAR CHART ===== */
new Chart(document.getElementById('barChart'), {
    type: 'bar',
    data: {
        labels: ['Users', 'Subjects', 'Quizzes'],
        datasets: [{
            label: 'Total Count',
            data: [<%=totalUsers%>, <%=totalSubjects%>, <%=totalQuizzes%>],
            backgroundColor: [
                'rgba(40,167,69,0.6)',
                'rgba(23,162,184,0.6)',
                'rgba(255,183,0,0.6)'
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
            y: { beginAtZero: true }
        }
    }
});

/* ===== PIE CHART ===== */
new Chart(document.getElementById('pieChart'), {
    type: 'pie',
    data: {
        labels: [
            <% for(int i=0;i<subjects.size();i++){
                out.print("'" + subjects.get(i).getSubname() + "'");
                if(i < subjects.size()-1) out.print(",");
            } %>
        ],
        datasets: [{
            data: [
                <% for(int i=0;i<subjects.size();i++){
                    out.print(subjects.get(i).getQuizCount());
                    if(i < subjects.size()-1) out.print(",");
                } %>
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});

/* ===== LINE CHART ===== */
new Chart(document.getElementById('lineChart'), {
    type: 'line',
    data: {
        labels: [
            <% for(int i=0;i<users.size();i++){
                out.print("'" + users.get(i).getName() + "'");
                if(i < users.size()-1) out.print(",");
            } %>
        ],
        datasets: [{
            label: 'Quizzes Attended',
            data: [
                <% for(int i=0;i<users.size();i++){
                    out.print(users.get(i).getTotalQuizAttend());
                    if(i < users.size()-1) out.print(",");
                } %>
            ],
            borderColor: 'rgba(23,162,184,1)',
            tension: 0.3,
            fill: false
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
            y: { beginAtZero: true }
        }
    }
});
</script>

</body>
</html>
