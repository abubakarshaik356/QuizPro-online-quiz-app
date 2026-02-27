<%@page import="java.util.ArrayList"%>
<%@page import="com.quizpro.dto.UserManage"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	List<UserManage> users = (List<UserManage>) request.getAttribute("Users");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - User Management</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* ===== YOUR ORIGINAL CSS (UNCHANGED) ===== */
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

body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	background-color: var(--dark-bg);
	color: var(--light-text);
	line-height: 1.6;
}

.admin-layout {
	display: flex;
	min-height: 100vh;
}

.main-content {
	flex-grow: 1;
	padding: 30px;
}

.page-header h1 {
	font-size: 2.2em;
	font-weight: 800;
}

.control-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: #fff;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0 2px 5px var(--shadow-light);
	margin-bottom: 25px;
}

.search-input,
.filter-select {
	padding: 10px 15px;
	border: 1px solid #CED4DA;
	border-radius: 6px;
	font-size: 1em;
}

.add-user-btn {
	background: var(--success-color);
	color: #fff;
	padding: 10px 15px;
	border-radius: 6px;
	text-decoration: none;
	font-weight: 700;
}

.user-table {
	width: 100%;
	border-collapse: collapse;
	background: #fff;
	border-radius: 10px;
	overflow: hidden;
}

.user-table th,
.user-table td {
	padding: 12px;
	border-bottom: 1px solid #e9ecef;
	text-align: left;
}
.user-table th
{
	margin-left: 0px;
}

.user-table th {
	background: #f8f9fa;
}

.action-button {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 1em;
	color: var(--primary-color);
	text-decoration: none;
	padding:5px; 
}

.action-button.delete {
	color: var(--danger-color);
}

.pagination {
	margin-top: 25px;
	text-align: center;
}

.page-btn {
	padding: 8px 14px;
	margin: 0 4px;
	background: var(--primary-color);
	color: white;
	border-radius: 6px;
	cursor: pointer;
}

.active-page {
	background: var(--accent-color);
	color: black;
}

/* User ID Link Styling */
.user-id-link {
    display: inline-block;
    background-color: #E1F5FE; /* Very light blue */
    color: var(--primary-color);
    padding: 4px 10px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: 700;
    font-size: 0.9em;
    transition: all 0.2s ease;
    border: 1px solid transparent;
}

.user-id-link:hover {
    background-color: var(--primary-color);
    color: white;
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0, 119, 182, 0.2);
    border-color: var(--secondary-blue);
}

/* Optional: style the parent cell to center it */
td:has(.user-id-link) {
    vertical-align: middle;
}
</style>
</head>

<body>

<div class="admin-layout">

	<%@ include file="adminSideBar.jsp" %>

	<main class="main-content">

		<div class="page-header">
			<h1>User Management</h1>
			<p>View, search, and manage registered users</p>
		</div>

		<!-- ===== CONTROL BAR ===== -->
		<div class="control-bar">
			<input type="text" id="searchInput" class="search-input"
				placeholder="Search by Name, Email, or ID...">

			 <!-- <div>
				<select id="roleFilter" class="filter-select">
					<option value="">Filter by Role (All)</option>
					<option value="admin">Admin</option>
					<option value="user">Standard User</option>
					<option value="editor">Editor</option>
				</select>

				<select id="statusFilter" class="filter-select">
					<option value="">Filter by Status (All)</option>
					<option value="active">Active</option>
					<option value="inactive">Inactive/Banned</option>
				</select>
			</div> -->
			
			<a href="AddNewUser.jsp" class="add-user-btn">
				<i class="fas fa-plus"></i> Add New User
			</a>
		</div>

		<!-- ===== USER TABLE ===== -->
		<table class="user-table">
			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>Total Quiz</th>
					<th>Certificate</th>
					<th>Actions</th>
				</tr>
			</thead>

			<tbody id="userTableBody">
				<% for (UserManage u : users) { %>
				<tr data-role="user" data-status="active">
					<td><a href="UserDetails?userId=<%=u.getId()%>" class="user-id-link"><%= u.getId() %></a></td>
					<td><%= u.getName() %></td>
					<td><%= u.getEmail() %></td>
					<td><%= u.getTotalQuizAttend() %></td>
					<td><%= u.getCertificateAchieve() %></td>
					<td>
						<a href="EditUser.jsp?id=<%=u.getId()%>" class="action-button">
							<i class="fas fa-edit"></i> Edit
						</a>
						<a href="DeleteUser?UserId=<%=u.getId()%>" class="action-button delete">
							<i class="fas fa-trash"></i> Delete
						</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>

		<div class="pagination" id="pagination"></div>

	</main>
</div>

<script>
const searchInput = document.getElementById("searchInput");

const rows = Array.from(document.querySelectorAll("#userTableBody tr"));
const pagination = document.getElementById("pagination");

let currentPage = 1;
const rowsPerPage = 8;
let filteredRows = rows;

function applyFilters() {
	const search = searchInput.value.toLowerCase().trim();

	filteredRows = rows.filter(row => {
		return row.innerText.toLowerCase().includes(search);
	});

	currentPage = 1;
	render();
}

function render() {
	rows.forEach(r => r.style.display = "none");

	const start = (currentPage - 1) * rowsPerPage;
	const end = start + rowsPerPage;

	filteredRows.slice(start, end).forEach(r => r.style.display = "");
	renderPagination();
}

function renderPagination() {
	pagination.innerHTML = "";
	const totalPages = Math.ceil(filteredRows.length / rowsPerPage);

	for (let i = 1; i <= totalPages; i++) {
		const btn = document.createElement("a");
		btn.className = "page-btn" + (i === currentPage ? " active-page" : "");
		btn.textContent = i;
		btn.onclick = () => {
			currentPage = i;
			render();
		};
		pagination.appendChild(btn);
	}
}

searchInput.addEventListener("keyup", applyFilters);

render();
</script>


</body>
</html>
