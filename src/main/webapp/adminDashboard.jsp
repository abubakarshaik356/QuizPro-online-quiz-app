<%@ page import="java.util.*"%>
<%
// Getting values from servlet
Integer totalUsers = (Integer) request.getAttribute("userCount");
Integer totalQuizzes = (Integer) request.getAttribute("quizCount");
Integer avgScore = (Integer) request.getAttribute("attemptCount");
Integer totalSubjects = (Integer) request.getAttribute("subjectCount");

// Fallback if null
if (totalUsers == null)
	totalUsers = 0;
if (totalQuizzes == null)
	totalQuizzes = 0;
if (avgScore == null)
	avgScore = 0;
if (totalSubjects == null)
	totalSubjects = 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - Admin Dashboard</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
:root {
	--primary-color: #0077B6; /* Blue */
	--accent-color: #FFB700; /* Yellow/Orange */
	--dark-bg: #F0F2F5;
	--light-text: #212529;
	--card-bg: #FFFFFF;
	--subtle-gray: #6C757D;
	--shadow-light: rgba(0, 0, 0, 0.08);
	--success-color: #28a745;
	--danger-color: #dc3545;
	--info-color: #17a2b8;
	--warning-color: #ffc107;
}

/* Basic Setup */
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
	background-color: var(--dark-bg);
	color: var(--light-text);
	line-height: 1.6;
}

.container {
	max-width: 1400px;
	margin: 0 auto;
	padding: 0 15px;
}

/* --- Sidebar Navigation --- */
.admin-layout {
	display: flex;
	min-height: 100vh;
}

.sidebar {
	width: 250px;
	background-color: var(--primary-color);
	color: white;
	padding: 20px;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
	position: sticky;
	top: 0;
	height: 100vh;
	overflow-y: auto;
}

.sidebar .logo {
	font-size: 2em;
	font-weight: 800;
	display: block;
	text-align: center;
	margin-bottom: 30px;
	color: white;
	text-decoration: none;
}

.sidebar .logo span {
	color: var(--accent-color);
}

.sidebar nav a {
	display: block;
	color: rgba(255, 255, 255, 0.85);
	text-decoration: none;
	padding: 15px 10px;
	margin-bottom: 5px;
	border-radius: 8px;
	transition: background-color 0.2s;
	font-weight: 600;
}

.sidebar nav a:hover, .sidebar nav a.active {
	background-color: rgba(255, 255, 255, 0.15);
	color: white;
}

.sidebar nav a i {
	margin-right: 10px;
	font-size: 1.1em;
}

.main-content {
	flex-grow: 1;
	padding: 30px;
	background-color: var(--dark-bg);
}

/* --- Header & Summary --- */
.page-header {
	margin-bottom: 30px;
	border-bottom: 1px solid #dee2e6;
	padding-bottom: 20px;
}

.page-header h1 {
	font-size: 2.2em;
	margin: 0;
	font-weight: 800;
}

.page-header p {
	color: var(--subtle-gray);
}

/* --- Stats Grid --- */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 20px;
	margin-bottom: 40px;
}

.stat-card {
	background-color: var(--card-bg);
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px var(--shadow-light);
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-left: 5px solid var(--primary-color);
}

.stat-icon {
	font-size: 2.5em;
	color: var(--primary-color);
	background-color: rgba(0, 119, 182, 0.1);
	padding: 15px;
	border-radius: 50%;
}

.stat-content {
	text-align: right;
}

.stat-value {
	font-size: 2.5em;
	font-weight: 800;
	margin: 0;
}

.stat-label {
	font-size: 1em;
	color: var(--subtle-gray);
	margin: 0;
	font-weight: 600;
}

.stat-card.users {
	border-left-color: var(--success-color);
}

.stat-card.users .stat-icon {
	color: var(--success-color);
	background-color: rgba(40, 167, 69, 0.1);
}

.stat-card.quizzes {
	border-left-color: var(--info-color);
}

.stat-card.quizzes .stat-icon {
	color: var(--info-color);
	background-color: rgba(23, 162, 184, 0.1);
}

.stat-card.performance {
	border-left-color: var(--accent-color);
}

.stat-card.performance .stat-icon {
	color: var(--accent-color);
	background-color: rgba(255, 183, 0, 0.1);
}

/* --- Main Management Grid --- */
.management-grid {
	display:grid;
	width: 100%;
	gap: 25px;
}

.card {
	background-color: var(--card-bg);
	padding: 25px;
	border-radius: 10px;
	box-shadow: 0 4px 10px var(--shadow-light);
	margin-bottom: 25px;
}

.card h3 {
	font-size: 1.5em;
	border-bottom: 1px solid #E9ECEF;
	padding-bottom: 10px;
	margin-top: 0;
	margin-bottom: 20px;
}



/* Quick Actions */
.action-button-grid {
	display: flex;
	width:100%;
	grid-template-columns: repeat(2, 1fr); /* ⬅️ 2 per row */
	gap: 30px;
	justify-items: center; /* horizontally centered */
}

.action-button {
	display: block;
	width: 100%; /* each action occupies full width of its grid column */
	text-align: center;
	padding: 20px;
	background-color: var(--dark-bg);
	border-radius: 8px;
	text-decoration: none;
	font-weight: 700;
	color: var(--light-text);
	transition: background-color 0.2s, color 0.2s;
}

.action-button:hover {
	background-color: var(--primary-color);
	color: white;
}

.action-button i {
	font-size: 2em;
	display: block;
	margin-bottom: 5px;
}

/* Responsive adjustments */
@media ( max-width : 992px) {
	.admin-layout {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		height: auto;
		position: static;
		overflow-x: auto;
		display: flex;
		flex-direction: row;
		padding: 15px 0;
	}
	.sidebar .logo {
		display: none;
	}
	.sidebar nav {
		display: flex;
		white-space: nowrap;
		padding: 0 15px;
	}
	.sidebar nav a {
		padding: 10px 15px;
		margin: 0 5px;
	}
	.main-content {
		padding: 20px;
	}
	.stats-grid {
		grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
	}
	.management-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>

	<div class="admin-layout">
	

		<%@ include file="adminSideBar.jsp" %>

		<main class="main-content">
			<div class="page-header">
				<h1>Platform Overview</h1>
				<p>Welcome, Admin. Here is a summary of the platform's current
					status.</p>
			</div>

			<div class="stats-grid">

				<!-- Total Users -->
				<div class="stat-card users">
					<i class="fas fa-user-plus stat-icon"></i>
					<div class="stat-content">
						<p class="stat-value"><%=totalUsers-1%></p>
						<p class="stat-label">Total Users</p>
					</div>
				</div>

				<!-- Total Quizzes -->
				<div class="stat-card quizzes">
					<i class="fas fa-folder-open stat-icon"></i>
					<div class="stat-content">
						<p class="stat-value"><%=totalQuizzes%></p>
						<p class="stat-label">Total Quizzes</p>
					</div>
				</div>

				<!-- Average Score -->
				<div class="stat-card performance">
					<i class="fas fa-chart-bar stat-icon"></i>
					<div class="stat-content">
						<p class="stat-value"><%=avgScore%>%
						</p>
						<p class="stat-label">Avg Quiz Score</p>
					</div>
				</div>

				<!-- Total Subjects -->
				<div class="stat-card">
					<i class="fas fa-book stat-icon"></i>
					<div class="stat-content">
						<p class="stat-value"><%=totalSubjects%></p>
						<p class="stat-label">Total Subjects</p>
					</div>
				</div>

			</div>

			<div class="management-grid">

				<div class="actions-column">
					<div class="card">
						<h3>Quick Actions</h3>
						<div class="action-button-grid">
							<a href="AddNewQuiz" class="action-button"> <i
								class="fas fa-plus-circle"></i> Add New Quiz
							</a> <a href="AddNewUser.jsp" class="action-button"><i class="fa fa-user-circle" aria-hidden="true"></i>Add New User
							</a> <a href="AddCategory.jsp" class="action-button"> <i class="fa fa-folder-open" aria-hidden="true"></i> Add New Category
							</a> <!-- <a href="#" class="action-button"> <i class="fas fa-bell"></i>
								Send System Broadcast
							</a> -->
						</div>
					</div>
				</div>

			</div>
		</main>

	</div>

</body>
</html>