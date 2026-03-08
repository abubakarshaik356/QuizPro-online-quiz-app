	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-pO1fL7+N3rRzv0NpZk5vYQxKJXY4rVxg4J7iA3QJuq2R8V7u7O4g2S1XZcGYNJmX6bR4Z1x+q45sB1uJ5WQ0Ug==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	
	<title>Insert title here</title>
	
	<style>
	#mobileBlock {
    display:none;
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:#111;
    color:white;
    text-align:center;
    padding-top:150px;
    font-family:Arial;
    z-index:9999;
}

#mobileBlock button{
    padding:10px 20px;
    font-size:16px;
    margin-top:20px;
    cursor:pointer;
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
		margin-bottom: 30px;a
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
	.sidebar .logo,
.sidebar .logo:visited,
.sidebar .logo:hover,
.sidebar .logo:active,
.sidebar .logo:focus {
    color: white;
    text-decoration: none;
}
	</style>
	</head>
	<body onload="checkDevice()">
	<div id="mobileBlock">

<h2>⚠ Admin Panel Restricted</h2>

<p>This admin page cannot be opened on Mobile or Tablet.</p>

<p>Please use a Desktop or Laptop.</p>

<p>Redirecting to login in <span id="timer">10</span> seconds...</p>

<button onclick="window.location.href='LogoutServlet'">
Logout Now
</button>

</div>
		<%
	    String activePage = (String) request.getAttribute("activePage");
	    if(activePage == null) activePage = "";
	%>
	
	<aside class="sidebar">
	    <a href="adminDashboard" class="logo">Admin<span>Pro</span></a>
	    <nav>
	
	        <a href="adminDashboard"
	           class="<%= activePage.equals("dashboard") ? "active" : "" %>">
	            <i class="fas fa-tachometer-alt"></i>Dashboard
	        </a>
	
	        <a href="UserManagement"
	           class="<%= activePage.equals("user") ? "active" : "" %>">
	            <i class="fas fa-users"></i>User Management
	        </a>
	
	        <a href="ContentManagement"
	           class="<%= activePage.equals("content") ? "active" : "" %>">
	            <i class="fas fa-puzzle-piece"></i>Content Management
	        </a>
	
	        <a href="AnalyticsReports"
	           class="<%= activePage.equals("analytics") ? "active" : "" %>">
	            <i class="fas fa-chart-line"></i>Analytics & Reports
	        </a>
	
	        <a href="Logout">
	            <i class="fas fa-sign-out-alt"></i>Logout
	        </a>
	
	    </nav>
	</aside>
	<script type="text/javascript">
	function checkDevice(){

	    var width = window.innerWidth;

	    // If mobile or tablet (less than 1024px)
	    if(width <= 1024){

	        document.getElementById("mobileBlock").style.display="block";

	        startTimer();
	    }
	}

	var timeLeft = 10;

	function startTimer(){

	    var timer = setInterval(function(){

	        document.getElementById("timer").innerHTML = timeLeft;

	        timeLeft--;

	        if(timeLeft < 0){
	            clearInterval(timer);

	            // redirect automatically
	            window.location.href="Logout";
	        }

	    },1000);
	}

	</script>
	</body>
	</html>