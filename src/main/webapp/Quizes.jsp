<%-- <%@page import="com.quizpro.dto.Quizzes"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ArrayList<Quizzes> quizes = (ArrayList<Quizzes>) request.getAttribute("quizes");
String title=(String)request.getAttribute("title");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - Software Engineering Quizzes</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
:root {
	--primary-color: #0077B6;
	--accent-color: #FFB700;
	--dark-bg: #F0F2F5;
	--light-text: #212529;
	--card-bg: #FFFFFF;
	--subtle-gray: #6C757D;
	--shadow-light: rgba(0, 0, 0, 0.08);
	--success-color: #28a745;
	--warning-color: #ffc107;
}

/* Basic Setup (Unchanged) */
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
	background-color: var(--dark-bg);
	color: var(--light-text);
	line-height: 1.6;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 15px;
}

h1 {
	font-size: 2.5em;
	font-weight: 800;
	margin-bottom: 5px;
	color: var(--light-text);
}

/* --- Navigation Bar (Reused) --- */
.navbar {
	background: var(--card-bg);
	border-bottom: 1px solid #dee2e6;
	padding: 10px 0;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.navbar .container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo {
	font-size: 1.8em;
	font-weight: 800;
	color: var(--primary-color);
	text-decoration: none;
}

.logo span {
	color: var(--accent-color);
}

.nav-links {
	display: flex;
	align-items: center;
}

.nav-links a {
	color: var(--subtle-gray);
	text-decoration: none;
	margin: 0 15px;
	padding: 5px 0;
	font-weight: 600;
	transition: color 0.3s;
	border-bottom: 3px solid transparent;
}

.nav-links a:hover, .nav-links .active {
	color: var(--primary-color);
	border-bottom: 3px solid var(--primary-color);
}

.profile-menu {
	position: relative;
	margin-left: 20px;
}

.profile-icon {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	border: 2px solid var(--primary-color);
	cursor: pointer;
	object-fit: cover;
}

.dropdown-content {
	display: none;
	position: absolute;
	top: 50px;
	right: 0;
	background-color: var(--card-bg);
	box-shadow: 0 8px 16px var(--shadow-light);
	z-index: 10;
	min-width: 150px;
	border-radius: 8px;
	overflow: hidden;
	border: 1px solid #eee;
}

.dropdown-content.show {
	display: block;
}

.dropdown-content a {
	color: var(--light-text) !important;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	border-bottom: none !important;
	text-align: left;
	margin: 0;
}

.dropdown-content a:hover {
	background-color: #f1f1f1;
	color: var(--primary-color) !important;
}

/* --- Quiz List Page Specific Styling --- */
.page-header {
	padding: 40px 0 30px;
}

.page-header p {
	font-size: 1.1em;
	color: var(--subtle-gray);
	margin-bottom: 0;
}

.breadcrumbs {
	margin-bottom: 10px;
	font-size: 0.9em;
}

.breadcrumbs a {
	color: var(--primary-color);
	text-decoration: none;
	font-weight: 600;
}

.breadcrumbs span {
	color: var(--subtle-gray);
}

/* Filter Row */
.filter-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.filter-select {
	padding: 10px 15px;
	border: 1px solid #CED4DA;
	border-radius: 8px;
	background-color: var(--card-bg);
	font-size: 1em;
	cursor: pointer;
}

/* Quiz Item Card */
.quiz-item {
	background-color: var(--card-bg);
	border-radius: 12px;
	box-shadow: 0 4px 10px var(--shadow-light);
	padding: 25px;
	margin-bottom: 20px;
	display: grid;
	grid-template-columns: 2fr 1fr 1fr 100px;
	/* Title/Desc | Stats | Progress | Action */
	align-items: center;
	border-left: 5px solid transparent;
	transition: border-left-color 0.3s;
}

.quiz-item:hover {
	border-left-color: var(--primary-color);
}

.quiz-title {
	font-size: 1.3em;
	font-weight: 700;
	color: var(--light-text);
	margin: 0 0 5px 0;
}

.quiz-description {
	color: var(--subtle-gray);
	font-size: 0.9em;
	margin: 0;
}

.quiz-details, .quiz-progress {
	padding-left: 20px;
	border-left: 1px solid #E9ECEF;
	font-size: 0.95em;
}

.details-row {
	margin-bottom: 5px;
	display: flex;
	align-items: center;
}

.details-row i {
	margin-right: 8px;
	color: var(--primary-color);
}

/* Specific Progress Styling */
.progress-label {
	font-weight: 600;
	color: var(--light-text);
	margin-bottom: 5px;
	display: block;
}

.accuracy-score {
	font-size: 1.5em;
	font-weight: 800;
	color: var(--success-color);
}

.accuracy-score.low {
	color: var(--warning-color);
}

/* Action Button */
.action-button {
	display: inline-block;
	background-color: var(--primary-color);
	color: var(--card-bg);
	padding: 12px 15px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: 700;
	font-size: 0.95em;
	text-align: center;
	transition: background-color 0.2s;
}

.action-button:hover {
	background-color: #005691;
}

.action-button.resume {
	background-color: var(--accent-color);
	color: var(--light-text);
}

.action-button.resume:hover {
	opacity: 0.9;
}

/* Responsive adjustments */
@media ( max-width : 992px) {
	.quiz-item {
		grid-template-columns: 1fr 1fr; /* Title/Desc | Action on top rows */
		gap: 20px;
		padding-bottom: 20px;
	}
	.quiz-details, .quiz-progress {
		padding-left: 0;
		border-left: none;
		grid-column: span 1;
	}
	.quiz-action {
		grid-column: span 2;
		text-align: center;
	}
}

@media ( max-width : 768px) {
	.navbar .nav-links {
		display: none;
	}
	.filter-row {
		flex-direction: column;
		align-items: flex-start;
		gap: 10px;
	}
	.quiz-item {
		grid-template-columns: 1fr;
	}
	.quiz-action {
		grid-column: span 1;
	}
}
.empty {
	width: 100%;
	display:flex;
	flex-direction: column;
	align-items: center;
}
</style>
</head>
<body>

	<%@ include file="navbar.jsp" %>
	<div class="container">
		<div class="page-header">
			<p class="breadcrumbs">
				<a href="categories.html">Categories</a> / <span>Software
					Engineering</span>
			</p>
			<h1><%=title %></h1>
			<p>Description</p>
		</div>

		<div class="filter-row">
			<div class="filter-group">
				<select class="filter-select">
					<option>Sort by Date Added</option>
					<option>Sort by Difficulty (Low to High)</option>
					<option>Sort by Your Performance</option>
				</select> <select class="filter-select">
					<option>Filter by Status</option>
					<option>Not Started</option>
					<option>In Progress</option>
					<option>Completed</option>
				</select>
			</div>
		</div>

		<div class="quiz-list">
			<%
			if(quizes.isEmpty()){%>
				<div class="empty">
					<img alt="Empty"
					src="https://cdn-icons-png.flaticon.com/128/13543/13543236.png">
					<h3>Currently, No Quizes Available under this catergory</h3>
				</div>
			<%}
			for (Quizzes q : quizes) {
			%>
			<div class="quiz-item">
				<div class="quiz-info">
					<h3 class="quiz-title"><%=q.getTitle() %></h3>
					<p class="quiz-description">Complex topics including dynamic
						programming and graph algorithms.</p>
				</div>

				<div class="quiz-details">
					<div class="details-row">
						<i class="fas fa-signal"></i> Difficulty: <span
							style="color: var(--warning-color);">Expert</span>
					</div>
					<div class="details-row">
						<i class="fas fa-question-circle"></i> Total Questions: <%=q.getQuestions() %>
					</div>
				</div>

				<div class="quiz-progress">
					<span class="progress-label">Last Score:</span><%
							if(q.getMarks()!=0){%>
								<span class="accuracy-score"> <%=q.getMarks() %>%</span> <span
						style="font-size: 0.9em; color: var(--success-color);">Completed</span>
						</div>

				<div class="quiz-action">
					<a href="TestPreview.jsp" class="action-button"> <i
						class="fas fa-redo"></i> Retake
					</a>
				</div>
							<%} else {%>
								<span class="accuracy-score low"> N/A</span> <span
						style="font-size: 0.9em; color: var(--assent-color);">Completed</span>
						</div>
                
                <div class="quiz-action">
                    <a href="TestPreview.jsp" class="action-button">
                        <i class="fas fa-play"></i> Start Quiz
                    </a>
                </div>
							<%}
						%>
				
			</div>
			<%
			}
			%>

		</div>
	</div>

	<script>
		function toggleDropdown() {
			document.getElementById("profileDropdown").classList.toggle("show");
		}

		// Close the dropdown if the user clicks outside of it
		window.onclick = function(event) {
			if (!event.target.matches('.profile-icon')) {
				var dropdowns = document
						.getElementsByClassName("dropdown-content");
				for (var i = 0; i < dropdowns.length; i++) {
					var openDropdown = dropdowns[i];
					if (openDropdown.classList.contains('show')) {
						openDropdown.classList.remove('show');
					}
				}
			}
		}
	</script>

</body>
</html> --%>


<%@page import="com.quizpro.dto.Quizzes"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ArrayList<Quizzes> quizes = (ArrayList<Quizzes>) request.getAttribute("quizes");
String title=(String)request.getAttribute("title");
String desc=(String)request.getAttribute("desc");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - Software Engineering Quizzes</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
:root {
	--primary-color: #0077B6;
	--accent-color: #FFB700;
	--dark-bg: #F0F2F5;
	--light-text: #212529;
	--card-bg: #FFFFFF;
	--subtle-gray: #6C757D;
	--shadow-light: rgba(0, 0, 0, 0.08);
	--success-color: #28a745;
	--warning-color: #ffc107;
}

/* Basic Setup (Unchanged) */
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
	background-color: var(--dark-bg);
	color: var(--light-text);
	line-height: 1.6;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 15px;
}

h1 {
	font-size: 2.5em;
	font-weight: 800;
	margin-bottom: 5px;
	color: var(--light-text);
}

/* --- Navigation Bar (Reused) --- */
.navbar {
	background: var(--card-bg);
	border-bottom: 1px solid #dee2e6;
	padding: 10px 0;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.navbar .container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo {
	font-size: 1.8em;
	font-weight: 800;
	color: var(--primary-color);
	text-decoration: none;
}

.logo span {
	color: var(--accent-color);
}

.nav-links {
	display: flex;
	align-items: center;
}

.nav-links a {
	color: var(--subtle-gray);
	text-decoration: none;
	margin: 0 15px;
	padding: 5px 0;
	font-weight: 600;
	transition: color 0.3s;
	border-bottom: 3px solid transparent;
}

.nav-links a:hover, .nav-links .active {
	color: var(--primary-color);
	border-bottom: 3px solid var(--primary-color);
}

.profile-menu {
	position: relative;
	margin-left: 20px;
}

.profile-icon {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	border: 2px solid var(--primary-color);
	cursor: pointer;
	object-fit: cover;
}

.dropdown-content {
	display: none;
	position: absolute;
	top: 50px;
	right: 0;
	background-color: var(--card-bg);
	box-shadow: 0 8px 16px var(--shadow-light);
	z-index: 10;
	min-width: 150px;
	border-radius: 8px;
	overflow: hidden;
	border: 1px solid #eee;
}

.dropdown-content.show {
	display: block;
}

.dropdown-content a {
	color: var(--light-text) !important;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	border-bottom: none !important;
	text-align: left;
	margin: 0;
}

.dropdown-content a:hover {
	background-color: #f1f1f1;
	color: var(--primary-color) !important;
}

/* --- Quiz List Page Specific Styling --- */
.page-header {
	padding: 40px 0 30px;
}

.page-header p {
	font-size: 1.1em;
	color: var(--subtle-gray);
	margin-bottom: 0;
}

.breadcrumbs {
	margin-bottom: 10px;
	font-size: 0.9em;
}

.breadcrumbs a {
	color: var(--primary-color);
	text-decoration: none;
	font-weight: 600;
}

.breadcrumbs span {
	color: var(--subtle-gray);
}

/* Filter Row */
.filter-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.filter-select {
	padding: 10px 15px;
	border: 1px solid #CED4DA;
	border-radius: 8px;
	background-color: var(--card-bg);
	font-size: 1em;
	cursor: pointer;
}

/* Quiz Item Card */
.quiz-item {
	background-color: var(--card-bg);
	border-radius: 12px;
	box-shadow: 0 4px 10px var(--shadow-light);
	padding: 25px;
	margin-bottom: 20px;
	display: grid;
	grid-template-columns: 2fr 1fr 1fr 100px;
	/* Title/Desc | Stats | Progress | Action */
	align-items: center;
	border-left: 5px solid transparent;
	transition: border-left-color 0.3s;
}

.quiz-item:hover {
	border-left-color: var(--primary-color);
}

.quiz-title {
	font-size: 1.3em;
	font-weight: 700;
	color: var(--light-text);
	margin: 0 0 5px 0;
}

.quiz-description {
	color: var(--subtle-gray);
	font-size: 0.9em;
	margin: 0;
}

.quiz-details, .quiz-progress {
	padding-left: 20px;
	border-left: 1px solid #E9ECEF;
	font-size: 0.95em;
}

.details-row {
	margin-bottom: 5px;
	display: flex;
	align-items: center;
}

.details-row i {
	margin-right: 8px;
	color: var(--primary-color);
}

/* Specific Progress Styling */
.progress-label {
	font-weight: 600;
	color: var(--light-text);
	margin-bottom: 5px;
	display: block;
}

.accuracy-score {
	font-size: 1.5em;
	font-weight: 800;
	color: var(--success-color);
}

.accuracy-score.low {
	color: var(--warning-color);
}

/* Action Button */
.action-button {
	display: inline-block;
	background-color: var(--primary-color);
	color: var(--card-bg);
	padding: 12px 15px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: 700;
	font-size: 0.95em;
	text-align: center;
	transition: background-color 0.2s;
}

.action-button:hover {
	background-color: #005691;
}

.action-button.resume {
	background-color: var(--accent-color);
	color: var(--light-text);
}

.action-button.resume:hover {
	opacity: 0.9;
}

/* Responsive adjustments */
@media ( max-width : 992px) {
	.quiz-item {
		grid-template-columns: 1fr 1fr; /* Title/Desc | Action on top rows */
		gap: 20px;
		padding-bottom: 20px;
	}
	.quiz-details, .quiz-progress {
		padding-left: 0;
		border-left: none;
		grid-column: span 1;
	}
	.quiz-action {
		grid-column: span 2;
		text-align: center;
	}
}

@media ( max-width : 768px) {
	.navbar .nav-links {
		display: none;
	}
	.filter-row {
		flex-direction: column;
		align-items: flex-start;
		gap: 10px;
	}
	.quiz-item {
		grid-template-columns: 1fr;
	}
	.quiz-action {
		grid-column: span 1;
	}
}
.empty {
	width: 100%;
	display:flex;
	flex-direction: column;
	align-items: center;
}
</style>
</head>
<body>

	<%@ include file="navbar.jsp" %>
	<div class="container">
		<div class="page-header">
			<p class="breadcrumbs">
				<a href="categories">Categories</a> / <span>Software
					Engineering</span>
			</p>
			<h1><%=title %></h1>
			<p><%=desc %></p>
		</div>

		<!-- <div class="filter-row">
			<div class="filter-group">
				<select class="filter-select" onchange="applyFilters()">
					<option value="ALL">Sort by Date Added</option>
					<option value="EASY">EASY</option>
					<option value="INTERMEDIATE">INTERMEDIATE</option>
					<option value="ADVANCED">ADVANCED</option>
				</select> <select class="status-select" onchange="applyFilters()">
					<option value="ALL">Filter by Status</option>
					<option value="NOT STARTED">Not Started</option>
					<option value="FAIL">FAIL</option>
					<option value="PASS">Completed</option>
				</select>
			</div>
		</div> -->

	<div class="filter-row">
    <div class="filter-group">
        <select id="difficultyFilter" class="filter-select" onchange="applyFilters()">
            <option value="ALL">All Difficulties</option>
            <option value="EASY">EASY</option>
            <option value="INTERMEDIATE">INTERMEDIATE</option>
            <option value="ADVANCED">ADVANCED</option>
        </select>

        <select id="statusFilter" class="filter-select" onchange="applyFilters()">
            <option value="ALL">All Status</option>
            <option value="NOT_STARTED">Not Started</option>
            <option value="PASS">Completed (Pass)</option>
            <option value="FAIL">Completed (Fail)</option>
        </select>
    </div>
</div>
	

		<div class="quiz-list">
			<%
			if(quizes.isEmpty()){%>
				<div class="empty">
					<img alt="Empty"
					src="https://cdn-icons-png.flaticon.com/128/13543/13543236.png">
					<h3>Currently, No Quizes Available under this catergory</h3>
				</div>
			<%}
			for (Quizzes q : quizes) {
			%>
			<div class="quiz-item" data-difficulty="<%=q.getQuizLevel()%>"
     data-marks="<%=q.getMarks()%>">
				<div class="quiz-info">
					<h3 class="quiz-title"><%=q.getTitle() %></h3>
					<p class="quiz-description"><%=q.getDesc() %></p>
				</div>

				<div class="quiz-details">
					<div class="details-row">
						<i class="fas fa-signal"></i> Difficulty: <span
							style="color: var(--warning-color);"><%= q.getQuizLevel() %></span>
					</div>
					<div class="details-row">
						<i class="fas fa-question-circle"></i> Total Questions: <%=q.getQuestions() %>
					</div>
				</div>

				<div class="quiz-progress">
					<span class="progress-label">Last Score:</span><%
							if(q.getMarks()!=0){
								if(q.getMarks()>80) {%>
								<span class="accuracy-score"> <%=q.getMarks() %>%</span> <span
						style="font-size: 0.9em; color: var(--success-color);">Completed</span>
						</div><%}else { %>
							<span class="accuracy-score" style="color:red;"> <%=q.getMarks() %>%</span> <span
						style="font-size: 0.9em; color: var(--success-color);">Completed</span>
						</div>
						<%} %>

				<div class="quiz-action">
					<a href="TestPreview?quizId=<%=q.getQuizId() %>" class="action-button"> <i
						class="fas fa-redo" ></i> Retake
					</a>
				</div>
							<%} else {%>
								<span class="accuracy-score low"> N/A</span> <span
						style="font-size: 0.9em; color: var(--assent-color);">Unattempted</span>
						</div>
                
                <div class="quiz-action">
                    <a href="TestPreview?quizId=<%=q.getQuizId() %>" class="action-button">
                        <i class="fas fa-play"></i> Start Quiz
                    </a>
                </div>
							<%}
						%>
				
			</div>
			<%
			}
			%>

		</div>
	</div>

	<script>
	
/* 	function applyFilters() {
	    const categoryValue = document.getElementById("categoryFilter").value;
	    const statusValue = document.getElementById("statusFilter").value;

	    const rows = document.querySelectorAll(".data-row");

	    rows.forEach(row => {
	        const category = row.querySelector(".category").innerText.trim();
	        const status = row.querySelector(".status").innerText.trim().toUpperCase();

	        let categoryMatch = (categoryValue === "ALL" || category === categoryValue);
	        let statusMatch = (statusValue === "ALL" || status === statusValue);

	        if (categoryMatch && statusMatch) {
	            row.style.display = "";
	        } else {
	            row.style.display = "none";
	        }
	    });
	} */
	
	function applyFilters() {
	    const difficulty = document.getElementById("difficultyFilter").value;
	    const status = document.getElementById("statusFilter").value;

	    const quizzes = document.querySelectorAll(".quiz-item");

	    quizzes.forEach(quiz => {
	        const quizDifficulty = quiz.dataset.difficulty;
	        const marks = parseInt(quiz.dataset.marks);

	        // Determine status
	        let quizStatus = "NOT_STARTED";
	        if (marks > 0 && marks < 80) quizStatus = "FAIL";
	        else if (marks >= 80) quizStatus = "PASS";

	        const difficultyMatch = (difficulty === "ALL" || quizDifficulty === difficulty);
	        const statusMatch = (status === "ALL" || quizStatus === status);

	        if (difficultyMatch && statusMatch) {
	            quiz.style.display = "grid";
	        } else {
	            quiz.style.display = "none";
	        }
	    });
	}
	
	
		function toggleDropdown() {
			document.getElementById("profileDropdown").classList.toggle("show");
		}

		// Close the dropdown if the user clicks outside of it
		window.onclick = function(event) {
			if (!event.target.matches('.profile-icon')) {
				var dropdowns = document
						.getElementsByClassName("dropdown-content");
				for (var i = 0; i < dropdowns.length; i++) {
					var openDropdown = dropdowns[i];
					if (openDropdown.classList.contains('show')) {
						openDropdown.classList.remove('show');
					}
				}
			}
		}
	</script>

</body>
</html>