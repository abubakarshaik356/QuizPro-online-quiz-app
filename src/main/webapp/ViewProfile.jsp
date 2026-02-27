<!DOCTYPE html>
<%@page import="com.quizpro.dto.Performance"%>
<%@page import="com.quizpro.dto.User"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - User Profile</title>
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
}

/* Basic Setup (Reused) */
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

.nav-links a:hover {
	color: var(--primary-color);
	border-bottom: 3px solid var(--primary-color);
}

.nav-links .active {
	color: var(--primary-color);
	border-bottom: 3px solid var(--primary-color);
}
/* Profile Menu Styles (Active on dropdown, but profile icon should be visible) */
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

/* --- Profile Page Layout --- */
.page-header {
	padding: 40px 0 30px;
}

.profile-grid {
	display: grid;
	grid-template-columns: 1fr 2fr;
	/* Sidebar for Details, Main for Stats/Settings */
	gap: 30px;
	margin-bottom: 40px;
}

.profile-card {
	background-color: var(--card-bg);
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 10px var(--shadow-light);
	margin-bottom: 30px;
}

.profile-card h3 {
	font-size: 1.4em;
	border-bottom: 2px solid var(--dark-bg);
	padding-bottom: 10px;
	margin-top: 0;
	margin-bottom: 20px;
}

/* User Detail Card */
.user-avatar-area {
	text-align: center;
	margin-bottom: 20px;
}

.user-avatar {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	border: 4px solid var(--primary-color);
	object-fit: cover;
	margin-bottom: 10px;
}

.user-detail-row {
	display: flex;
	justify-content: space-between;
	padding: 10px 0;
	border-bottom: 1px dashed #E9ECEF;
}

.user-detail-row strong {
	font-weight: 600;
}

.user-detail-row span {
	color: var(--subtle-gray);
}

/* Performance Stats Grid */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 20px;
	margin-bottom: 30px;
}

.stat-box {
	background-color: var(--dark-bg);
	padding: 20px;
	border-radius: 8px;
	text-align: center;
}

.stat-value {
	font-size: 2em;
	font-weight: 800;
	color: var(--primary-color);
	margin-bottom: 5px;
}

.stat-label {
	font-size: 0.9em;
	color: var(--subtle-gray);
}

/* Settings Form */
.settings-form input[type="text"], .settings-form input[type="password"]
	{
	width: calc(100% - 30px);
	padding: 15px;
	margin-bottom: 15px;
	border: 1px solid #CED4DA;
	border-radius: 8px;
	font-size: 1em;
}

.settings-form button {
	background-color: var(--accent-color);
	color: var(--light-text);
	padding: 12px 25px;
	border: none;
	border-radius: 8px;
	font-weight: 700;
	cursor: pointer;
	transition: opacity 0.2s;
}

.settings-form button:hover {
	opacity: 0.9;
}

/* Danger Zone */
.danger-zone {
	border: 2px solid var(--danger-color);
	background-color: #fce4e4;
	padding: 20px;
	border-radius: 8px;
	margin-top: 30px;
}

.danger-zone p {
	color: var(--danger-color);
	font-weight: 600;
}

/* Responsive adjustments */
@media ( max-width : 992px) {
	.profile-grid {
		grid-template-columns: 1fr; /* Stack sidebar and main content */
	}
}

@media ( max-width : 768px) {
	.navbar .nav-links {
		display: none;
	}
}
</style>
</head>
<body>

	<%
	User user = (User) session.getAttribute("user");
	Performance perf=(Performance) request.getAttribute("performance");
	%>
	<%@ include file="navbar.jsp" %>

	<div class="container">
		<div class="page-header">
			<h1>User Profile & Settings</h1>
			<p>Manage your account details and track your lifetime
				performance on QuizPro.</p>
		</div>

		<div class="profile-grid">

			<div class="details-column">
				<div class="profile-card">
					<h3>Personal Information</h3>
					<div class="user-avatar-area">
						<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwJgi2tfPov2vnIRkuxgRw_gHSqt_uRGbrdA&s"
							alt="Profile Avatar" class="user-avatar">
						<p style="font-size: 1.2em; font-weight: 700; margin: 5px 0 0 0;"><%=user.getName()%></p>
						<!-- <a href="#" style="font-size: 0.9em; color: var(--primary-color);">Change
							Photo</a> -->
					</div>
					<div class="user-detail-row">
						<strong><i class="fa fa-id-badge"></i> User ID:</strong> <span><%=user.getUserid()%></span>
					</div>
					<div class="user-detail-row">
						<strong><i class="fas fa-envelope"></i> Email:</strong> <span><%=user.getEmail()%></span>
					</div>
					<div class="user-detail-row">
						<strong><i class="fas fa-mobile-alt"></i> Mobile:</strong> <span><%=user.getPhone()%></span>
					</div>
					<div class="user-detail-row" style="border-bottom: none;">
						<strong><i class="fas fa-certificate"></i>
							Certifications:</strong> <span style="color: var(--success-color);"><%=perf.getCertificates() %>
							Achieved</span>
					</div>

				</div>
			</div>

			<div class="stats-settings-column">

				<div class="profile-card">
					<h3>Performance Overview</h3>
					<div class="stats-grid">

						<div class="stat-box">
							<div class="stat-value"><%=perf.getQuizesTaken() %></div>
							<div class="stat-label">Total Quizzes Taken</div>
						</div>

						<div class="stat-box">
							<div class="stat-value" style="color: var(--success-color);"><%=perf.getAverageScore() %>%</div>
							<div class="stat-label">Average Score</div>
						</div>

						<div class="stat-box">
							<div class="stat-value" style="color: var(--accent-color);"><%=perf.getQuesAnswered() %></div>
							<div class="stat-label">Questions Answered</div>
						</div>

					</div>
					<a href="ViewTestHis"
						style="font-weight: 600; color: var(--primary-color);">View
						Detailed Test History <i class="fas fa-arrow-right"></i>
					</a>
				</div>

				<div class="profile-card">
					<h3>Update Password</h3>
					
					<form class="settings-form" id="MyForm"
						action="UpdatePasswordServlet" method="POST">
						<input type="hidden" name="userId" value="<%=user.getUserid()%>">
						<input type="password" placeholder="Current Password" name="currentPass" id="pass" required> 
						<input type="password" placeholder="New Password" name="newPass" id="newpass" required> 
						<input type="password" placeholder="Confirm New Password" name="cfmPass" id="cfmpass" required>
						<button type="submit" id="updateBtn"><i class="fas fa-save"></i> Save Password </button>
					</form>

					<!-- <div class="danger-zone">
						<p>
							<i class="fas fa-exclamation-triangle"></i> Danger Zone
						</p>
						<a href="#" class="action-link"
							style="color: var(--danger-color); font-weight: 700;">Deactivate
							Account</a>
					</div> -->
				</div>

			</div>
		</div>
	</div>

	<script>
		const formdata = document.getElementById("MyForm");

	    formdata.addEventListener('submit', function(event) {
	    	
	        const newpass = document.getElementById("newpass").value;
	        const cfmpass = document.getElementById("cfmpass").value;
			const pass = document.getElementById("pass").value;
			const userpass = "<%=user.getPassword()%>"
			
			if (pass != userpass) {
		        alert("Old passwords do not match. Please re-enter.");
		        event.preventDefault();
		        return; 
		    } 
			else if (newpass !== cfmpass) {
	            alert("New passwords do not match. Please re-enter.");
	            event.preventDefault();
	            return; 
	        } 
	        
	        
	    });
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