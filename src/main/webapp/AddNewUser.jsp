<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - Add New User</title>
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
}

/* Basic Setup & Admin Layout */
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

/* --- Sidebar Navigation --- */
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

.sidebar nav a:hover {
	background-color: rgba(255, 255, 255, 0.15);
	color: white;
}

.sidebar nav a.active {
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

/* --- Form Card --- */
.form-card {
	background-color: var(--card-bg);
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 4px 10px var(--shadow-light);
	max-width: 800px;
	margin: 0 auto;
}

.form-card h2 {
	font-size: 1.8em;
	color: var(--primary-color);
	margin-top: 0;
	margin-bottom: 25px;
	border-bottom: 1px solid #E9ECEF;
	padding-bottom: 10px;
}

/* Form Inputs */
.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	font-weight: 600;
	margin-bottom: 8px;
	font-size: 1.1em;
}

.form-group input[type="text"], .form-group input[type="email"],
	.form-group input[type="password"], .form-group select {
	width: 100%;
	padding: 12px;
	border: 1px solid #CED4DA;
	border-radius: 6px;
	box-sizing: border-box;
	font-size: 1em;
}

.form-group small {
	color: var(--subtle-gray);
	display: block;
	margin-top: 5px;
}

/* Submission Button */
.cta-button {
	background-color: var(--success-color);
	color: white;
	padding: 15px 30px;
	border: none;
	border-radius: 8px;
	font-weight: 700;
	font-size: 1.1em;
	cursor: pointer;
	transition: background-color 0.2s;
	width: 100%;
	margin-top: 20px;
}

.cta-button:hover {
	background-color: #1e7e34;
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
	.form-card {
		padding: 20px;
	}
}
</style>
</head>
<body>

	<div class="admin-layout">

		<%@ include file="adminSideBar.jsp" %>

		<main class="main-content">
			<div class="page-header">
				<a href="UserManagement"
					style="color: var(--primary-color); text-decoration: none; font-weight: 600;"><i
					class="fas fa-arrow-left"></i> Back to User List</a>
				<h1>Create New User Account</h1>
				<p>Register a new user with their required login credentials and
					role permissions.</p>
			</div>

			<div class="form-card">
				<h2>User Account Details</h2>

				<form action="CreateUser" method="POST">

					<div class="form-group">
						<label for="fullName"><i class="fas fa-user"></i> Full
							Name</label> <input type="text" id="fullName" name="name"
							placeholder="John Doe" required>
					</div>

					<div class="form-group">
						<label for="email"><i class="fas fa-at"></i> Email Address</label>
						<input type="email" id="email" name="email"
							placeholder="user@quizpro.com" required> <small>This
							will be used for login and password resets.</small>
					</div>

					<div class="form-group">
						<label for="role"><i class="fas fa-shield-alt"></i> User
							Role</label> <select id="role" name="role" required>
							<option value="user" selected>Standard User</option>
							<option value="admin">Administrator (Full Access)</option>
						</select> <small>Assign appropriate permission level.</small>
					</div>

					<div class="form-group">
						<label for="mobileNumber"><i class="fas fa-phone"></i>
							Mobile Number</label> <input type="text" id="mobileNumber"
							name="phone" placeholder="+91 98765 43210" required> 
					</div>

					<div class="form-group">
						<label for="password"><i class="fas fa-lock"></i> Password</label>
						<input type="password" id="password" name="password" required>
						<small>The user can change this after their first login.</small>
					</div>



					<button type="submit" class="cta-button">
						<i class="fas fa-user-plus"></i> Create Account
					</button>
				</form>
			</div>

		</main>

	</div>

</body>
</html>