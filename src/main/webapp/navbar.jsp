<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String activePage = (String) request.getAttribute("activePage");
    if (activePage == null) activePage = "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Navbar</title>

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
      integrity="sha512-pO1fL7+N3rRzv0NpZk5vYQxKJXY4rVxg4J7iA3QJuq2R8V7u7O4g2S1XZcGYNJmX6bR4Z1x+q45sB1uJ5WQ0Ug=="
      crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
/* --- Navigation Bar --- */
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

.nav-links a:hover,
.nav-links a.active {
    color: var(--primary-color);
    border-bottom: 3px solid var(--primary-color);
}

/* --- Profile Menu --- */
.profile-menu {
    position: relative;
}

.profile-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    cursor: pointer;
}

.dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    background: white;
    min-width: 160px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    border-radius: 8px;
    overflow: hidden;
    z-index: 1000;
}

.dropdown-content a {
    display: block;
    padding: 12px 15px;
    color: #333;
    text-decoration: none;
    font-weight: 500;
}

.dropdown-content a:hover {
    background: #f1f1f1;
}
</style>

<script>
function toggleDropdown() {
    document.getElementById("profileDropdown").classList.toggle("show");
}

window.onclick = function(event) {
    if (!event.target.matches('.profile-icon')) {
        let dropdown = document.getElementById("profileDropdown");
        if (dropdown && dropdown.classList.contains('show')) {
            dropdown.classList.remove('show');
        }
    }
}
</script>

<style>
.dropdown-content.show {
    display: block;
}
</style>

</head>

<body>

<header class="navbar">
    <div class="container">

        <a href="dashboard.jsp" class="logo">Quiz<span>Pro</span></a>

        <div class="nav-links">

            <a href="dashboard.jsp"
               class="<%= activePage.equals("home") ? "active" : "" %>">
                <i class="fas fa-home"></i> Home
            </a>

            <a href="categories"
               class="<%= activePage.equals("categories") ? "active" : "" %>">
                <i class="fas fa-list-ul"></i> Categories
            </a>

            <a href="ViewTestHis"
               class="<%= activePage.equals("tests") ? "active" : "" %>">
                <i class="fas fa-history"></i> My Tests
            </a>

        </div>

        <!-- Profile Menu -->
        <div class="profile-menu">
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwJgi2tfPov2vnIRkuxgRw_gHSqt_uRGbrdA&s"
                 alt="User Avatar"
                 class="profile-icon"
                 onclick="toggleDropdown()">

            <div class="dropdown-content" id="profileDropdown">
                <a href="ViewProfile">
                    <i class="fas fa-user-circle"></i> Profile
                </a>
                <a href="Logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

    </div>
</header>
</body>
</html>
