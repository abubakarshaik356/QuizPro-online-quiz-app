<%@page import="com.quizpro.dto.Quizzes"%>
<%@page import="com.quizpro.dto.Subject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - Content Management</title>
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
	--danger-color: #dc3545;
	--warning-color: #ffc107;
}

/* Basic Setup & Admin Layout (Reused) */
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
	background-color: var(--dark-bg);
	color: var(--light-text);
	line-height: 1.6;
}

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

/* --- Page Header --- */
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

/* --- Tabs --- */
.tabs {
	display: flex;
	border-bottom: 2px solid #CED4DA;
	margin-bottom: 25px;
}

.tab-button {
	background: none;
	border: none;
	padding: 15px 25px;
	cursor: pointer;
	font-size: 1.1em;
	font-weight: 600;
	color: var(--subtle-gray);
	transition: color 0.3s, border-bottom 0.3s;
	border-bottom: 3px solid transparent;
	margin-bottom: -2px;
	/* Pulls button slightly down to align with bottom border */
}

.tab-button.active {
	color: var(--primary-color);
	border-bottom: 3px solid var(--primary-color);
}

/* --- Content Area --- */
.tab-content {
	background-color: var(--card-bg);
	padding: 25px;
	border-radius: 0 0 10px 10px;
	box-shadow: 0 4px 10px var(--shadow-light);
}

.content-section {
	display: none;
}

.content-section.active {
	display: block;
}

/* Content Controls (Search/Add) */
.content-controls {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.content-controls input {
	padding: 10px 15px;
	border: 1px solid #CED4DA;
	border-radius: 6px;
	width: 300px;
}

.add-btn {
	background-color: var(--success-color);
	color: white;
	padding: 10px 15px;
	border-radius: 6px;
	text-decoration: none;
	font-weight: 700;
}

/* Table Styles (Reused from User Management) */
.data-table {
	width: 100%;
	border-collapse: collapse;
	text-align: left;
}

.data-table th, .data-table td {
	padding: 12px 15px;
	border-bottom: 1px solid #E9ECEF;
}

.data-table th {
	background-color: #F8F9FA;
	font-weight: 700;
}

.data-table tbody tr:hover {
	background-color: #f5f5f5;
}

.action-button {
	background: none;
	border: none;
	color: var(--primary-color);
	cursor: pointer;
	margin-right: 10px;
	font-size: 1em;
	text-decoration: none;
}

.action-button.delete {
	color: var(--danger-color);
}

.action-button.publish {
	color: var(--success-color);
}

/* Status Badges */
.badge {
	display: inline-block;
	padding: 4px 8px;
	border-radius: 4px;
	font-weight: 600;
	font-size: 0.8em;
}

.badge.published {
	background-color: #d4edda;
	color: var(--success-color);
}

.badge.draft {
	background-color: #fff3cd;
	color: var(--warning-color);
}

.badge.review {
	background-color: #cfe2ff;
	color: var(--primary-color);
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
		display: flex;
		flex-direction: row;
		padding: 15px 0;
		overflow-x: auto;
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
	.content-controls {
		flex-direction: column;
		align-items: stretch;
		gap: 15px;
	}
	.content-controls input {
		width: 100%;
	}
}
</style>
</head>
<body>

	<%
	ArrayList<Subject> subjects = (ArrayList<Subject>) request.getAttribute("Subjects");
	ArrayList<Quizzes> quizzes = (ArrayList<Quizzes>) request.getAttribute("Quizzes");
	%>

	<div class="admin-layout">

		<%@ include file="adminSideBar.jsp"%>

		<main class="main-content">
			<div class="page-header">
				<h1>Content Management</h1>
				<p>Manage quizzes, categories, questions, and learning paths
					across the platform.</p>
			</div>

			<div class="tabs">
				<button class="tab-button active"
					onclick="openContent(event, 'Quizzes')">
					<i class="fas fa-clipboard-list"></i> Quizzes
				</button>
				<button class="tab-button"
					onclick="openContent(event, 'Categories')">
					<i class="fas fa-list-alt"></i> Categories
				</button>
			</div>

			<div class="tab-content">

				<div id="Quizzes" class="content-section active">
					<div class="content-controls">
						<input type="text" placeholder="Search Quiz Title or ID..." id="quizSearch">
						<a href="AddNewQuiz" class="add-btn"><i class="fas fa-plus"></i>
							Create New Quiz</a>
					</div>
					<table class="data-table">
						<thead>
							<tr>
								<th>ID</th>
								<th>Title</th>
								<th>Category</th>
								<th>Questions</th>
								<th>Marks</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Quizzes quiz : quizzes) {
							%>
							<tr>
								<td><%=quiz.getUserId()%></td>
								<td name="quizName"><%=quiz.getTitle()%></td>
								<td name="quizCategory"><%=quiz.getCategory()%></td>
								<td><%=quiz.getQuestions()%></td>
								<td><%=quiz.getMarks()%></td>
								<!--  <td>
                                    <button class="action-button"><i class="fas fa-edit"></i> Edit</button>
                                    <button class="action-button" style="color: var(--accent-color)"><i class="fas fa-eye"></i> View Qs</button>
                                </td> -->
								<td><a href="EditQuiz.jsp?id=<%=quiz.getUserId()%>"
									class="action-button"> <i class="fas fa-edit"></i> Edit
								</a> <a
									href="ViewAllQuestions?quizId=<%=quiz.getUserId()%>&quizName=<%=quiz.getTitle()%>&quizCategory=<%=quiz.getCategory()%>"
									class="action-button" style="color: var(--accent-color)"> <i
										class="fas fa-eye"></i> View Qs
								</a></td>

							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>

				<div id="Categories" class="content-section">
					<div class="content-controls">
						<input type="text" placeholder="Search Category Name..." id="categorySearch">
						<a href="AddCategory.jsp" class="add-btn"><i
							class="fas fa-plus"></i> Add New Category</a>
					</div>
					<table class="data-table">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Total Quizzes</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Subject sub : subjects) {
							%>
							<tr>
								<td><%=sub.getSubId()%></td>
								<td><%=sub.getSubname()%></td>
								<td><%=sub.getQuizCount()%></td>
								<td>
									<a href="EditCategory.jsp?id=<%=sub.getSubId()%>	"
									class="action-button"> <i class="fas fa-edit"></i> Edit</a> 
									<a href="ViewAllQuizes?categoryId=<%=sub.getSubId()%>
									&categoryName=<%=sub.getSubname()%>"
									class="action-button publish"> <i class="fas fa-eye"></i>
										Show
								</a>
								


								</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>

			</div>

		</main>

	</div>

	<script>
		// JavaScript for handling the tab switching
		function openContent(evt, contentName) {
			// Declare all variables
			var i, tabcontent, tablinks;

			// Get all elements with class="content-section" and hide them
			tabcontent = document.getElementsByClassName("content-section");
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none";
			}

			// Get all elements with class="tab-button" and remove the class "active"
			tablinks = document.getElementsByClassName("tab-button");
			for (i = 0; i < tablinks.length; i++) {
				tablinks[i].className = tablinks[i].className.replace(
						" active", "");
			}

			// Show the current tab, and add an "active" class to the button that opened the tab
			document.getElementById(contentName).style.display = "block";
			evt.currentTarget.className += " active";
		}

		// Initialize by making the Quizzes tab active on load
		document.addEventListener('DOMContentLoaded', function() {
			document.getElementById('Quizzes').style.display = "block";
		});
	</script>
<script>
    const quizSearch = document.getElementById("quizSearch");
    const categorySearch = document.getElementById("categorySearch");

    quizSearch.addEventListener("keyup", function () {
        const searchText = quizSearch.value.toLowerCase().trim();
        const rows = document.querySelectorAll("#Quizzes tbody tr");

        rows.forEach(row => {
            const rowText = row.innerText.toLowerCase();
            row.style.display = rowText.includes(searchText) ? "" : "none";
        });
    });

    categorySearch.addEventListener("keyup", function () {
        const searchText = categorySearch.value.toLowerCase().trim();
        const rows = document.querySelectorAll("#Categories tbody tr");

        rows.forEach(row => {
            const rowText = row.innerText.toLowerCase();
            row.style.display = rowText.includes(searchText) ? "" : "none";
        });
    });
</script>


	

</body>
</html>