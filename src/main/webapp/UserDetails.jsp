<%@page import="com.quizpro.dto.Performance"%>
<%@page import="com.quizpro.dto.UserTestHis"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.quizpro.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Detail Report | QuizPro Admin</title>
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
	--card-bg: #FFFFFF;
	--text-main: #212529;
	--subtle-gray: #6C757D;
	--border: #DEE2E6;
	--success: #2D6A4F;
	--danger: #A4161A;
}

body {
	font-family: 'Inter', sans-serif;
	background-color: var(--dark-bg);
	margin: 0;
	color: var(--text-main);
	display: flex;
	flex-direction: row;
}

.container {
	width: 1000px;
	margin: 20px auto;
}

/* Top Navigation/Back link */
.back-nav {
	margin-bottom: 25px;
}

.back-nav a {
	text-decoration: none;
	color: var(--primary-color);
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: opacity 0.2s;
}

.back-nav a:hover {
	opacity: 0.7;
}

/* User Header Card */
.profile-card {
	background: var(--card-bg);
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	border-left: 6px solid var(--primary-color);
}

.profile-info {
	display: flex;
	align-items: center;
	gap: 20px;
}

.profile-avatar {
	width: 70px;
	height: 70px;
	background-color: var(--primary-color);
	color: white;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.8em;
	font-weight: 800;
}

.details h2 {
	margin: 0;
	font-size: 1.6em;
}

.details p {
	margin: 4px 0;
	color: var(--subtle-gray);
	font-size: 0.95em;
}

.user-stats {
	display: flex;
	gap: 30px;
	text-align: right;
}

.stat-box h4 {
	margin: 0;
	color: var(--primary-color);
	font-size: 1.4em;
}

.stat-box span {
	font-size: 0.8em;
	color: var(--subtle-gray);
	text-transform: uppercase;
	font-weight: 700;
}

/* Results Table Section */
.results-container {
	background: var(--card-bg);
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	overflow: hidden;
}

.table-header {
	padding: 20px 25px;
	background: #F8F9FA;
	border-bottom: 1px solid var(--border);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.table-header h3 {
	margin: 0;
	font-size: 1.2em;
	display: flex;
	align-items: center;
	gap: 10px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th {
	text-align: left;
	padding: 18px 25px;
	font-size: 0.85em;
	text-transform: uppercase;
	color: var(--subtle-gray);
	border-bottom: 1px solid var(--border);
}

td {
	padding: 18px 25px;
	border-bottom: 1px solid #f1f1f1;
	font-size: 0.95em;
}

.subject-name {
	font-weight: 600;
	color: var(--primary-color);
}

/* Status Badges */
.badge {
	padding: 6px 14px;
	border-radius: 20px;
	font-size: 0.8em;
	font-weight: 800;
}

.badge-pass {
	background-color: #D1E7DD;
	color: var(--success);
}

.badge-fail {
	background-color: #F8D7DA;
	color: var(--danger);
}

.accuracy-bar-bg {
	width: 100px;
	height: 8px;
	background: #eee;
	border-radius: 4px;
	display: inline-block;
	margin-right: 10px;
}

.accuracy-fill {
	height: 100%;
	border-radius: 4px;
	background: var(--primary-color);
}

@media ( max-width : 768px) {
	.profile-card {
		flex-direction: column;
		text-align: center;
		gap: 20px;
	}
	.profile-info {
		flex-direction: column;
	}
	.user-stats {
		text-align: center;
	}
	th:nth-child(4), td:nth-child(4) {
		display: none;
	} /* Hide Accuracy on mobile */
}

.user-avatar {
	width: 75px;
	height: 75px;
	border-radius: 50%;
	border: 4px solid var(--primary-color);
	object-fit: cover;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<%@ include file="adminSideBar.jsp"%>
	<%
	User users = (User) request.getAttribute("users");
	ArrayList<UserTestHis> history = (ArrayList) request.getAttribute("history");
	Performance perf = (Performance) request.getAttribute("performance");
	%>

	<div class="container">
		<div class="back-nav">
			<a href="UserManagement"><i class="fas fa-chevron-left"></i>
				Return to User List</a>
		</div>

		<div class="profile-card">
			<div class="profile-info">
				<div class="profile-avatar">
					<img
						src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwJgi2tfPov2vnIRkuxgRw_gHSqt_uRGbrdA&s"
						alt="Profile Avatar" class="user-avatar">
				</div>
				<div class="details">
					<h2><%=users.getName()%></h2>
					<p>
						<i class="far fa-id-badge"></i>
						<%=users.getUserid()%></p>
					<p>
						<i class="far fa-envelope"></i>
						<%=users.getEmail()%></p>
					<p>
						<i class="far fa-mobile-alt"></i>
						<%=users.getPhone()%></p>
				</div>
			</div>
			<div class="user-stats">
				<div class="stat-box">
					<h4><%=perf.getQuizesTaken()%></h4>
					<span>Quizzes Taken</span>
				</div>
				<div class="stat-box">
					<h4><%=perf.getAverageScore()%>%
					</h4>
					<span>Avg. Accuracy</span>
				</div>
			</div>
		</div>

		<div class="results-container">
			<div class="table-header">
				<h3>
					<i class="fas fa-chart-line"></i> Quiz Performance History
				</h3>
				<!-- <button style="background: none; border: 1px solid var(--border); padding: 5px 15px; border-radius: 4px; cursor: pointer; font-family: inherit;">
                    <i class="fas fa-download"></i> Export PDF
                </button> -->
			</div>

			<table>
				<thead>
					<tr>
						<th>Subject Name</th>
						<th>Category</th>
						<th>Completion Date</th>
						<th>Accuracy</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (UserTestHis his : history) {
					%>
					<tr>
						<td class="subject-name"><%=his.getQuizName()%></td>
						<td><%=his.getCategory()%></td>
						<td><%=his.getDateTaken()%></td>
						<td>
							<div class="accuracy-bar-bg">
								<div class="accuracy-fill"
									style="width: <%=his.getScorePer()%>%;"></div>
							</div> <%=his.getScorePer()%>%
						</td>
						<td>
							<%
							if (his.getStatus().equalsIgnoreCase("pass")) {
							%>
							<span class="badge badge-pass">PASSED</span> <%
 } else {
 %> <span class="badge badge-fail">FAILED</span>
							<%
							}
							%>
						</td>
					</tr>
					<%
					}
					%>
					<!-- <tr>
                        <td class="subject-name">Java Programming</td>
                        <td>Dec 20, 2025</td>
                        <td>18 / 20</td>
                        <td>
                            <div class="accuracy-bar-bg"><div class="accuracy-fill" style="width: 90%;"></div></div>
                            90%
                        </td>
                        <td><span class="badge badge-pass">PASSED</span></td>
                    </tr>
                    <tr>
                        <td class="subject-name">Web Development</td>
                        <td>Dec 18, 2025</td>
                        <td>15 / 25</td>
                        <td>
                            <div class="accuracy-bar-bg"><div class="accuracy-fill" style="width: 60%;"></div></div>
                            60%
                        </td>
                        <td><span class="badge badge-pass">PASSED</span></td>
                    </tr>
                    <tr>
                        <td class="subject-name">Database Systems</td>
                        <td>Dec 15, 2025</td>
                        <td>8 / 20</td>
                        <td>
                            <div class="accuracy-bar-bg"><div class="accuracy-fill" style="width: 40%; background: #A4161A;"></div></div>
                            40%
                        </td>
                        <td><span class="badge badge-fail">FAILED</span></td>
                    </tr>
                    <tr>
                        <td class="subject-name">Data Structures</td>
                        <td>Dec 10, 2025</td>
                        <td>22 / 25</td>
                        <td>
                            <div class="accuracy-bar-bg"><div class="accuracy-fill" style="width: 88%;"></div></div>
                            88%
                        </td>
                        <td><span class="badge badge-pass">PASSED</span></td>
                    </tr> -->
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>