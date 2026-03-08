<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String activePage = (String) request.getAttribute("activePage");
if(activePage == null) activePage="";
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style>

/* NAVBAR */

.navbar{
background:var(--card-bg);
border-bottom:1px solid #dee2e6;
padding:10px 0;
box-shadow:0 2px 4px rgba(0,0,0,0.05);
}

.navbar .container{
display:flex;
justify-content:space-between;
align-items:center;
}

/* LOGO */

.logo{
font-size:1.8em;
font-weight:800;
color:var(--primary-color);
text-decoration:none;
}

.logo span{
color:var(--accent-color);
}

/* NAV LINKS */

.nav-links{
display:flex;
align-items:center;
gap:20px;
}

.nav-links a{
color:var(--subtle-gray);
text-decoration:none;
font-weight:600;
padding:5px 0;
border-bottom:3px solid transparent;
}

.nav-links a:hover,
.nav-links a.active{
color:var(--primary-color);
border-bottom:3px solid var(--primary-color);
}

/* PROFILE */

.profile-menu{
position:relative;
margin-left:10px;
}

.profile-icon{
width:40px;
height:40px;
border-radius:50%;
cursor:pointer;
object-fit:cover;
}

/* DROPDOWN */

.dropdown-content{
display:none;
position:absolute;
right:0;
top:50px;
background:white;
min-width:160px;
box-shadow:0 4px 8px rgba(0,0,0,0.1);
border-radius:8px;
overflow:hidden;
z-index:1000;
}

.dropdown-content a{
display:block;
padding:12px 15px;
color:#333;
text-decoration:none;
}

.dropdown-content a:hover{
background:#f1f1f1;
}

.dropdown-content.show{
display:block;
}

/* MOBILE MENU BUTTON */

.menu-toggle{
display:none;
font-size:16px;
font-weight:600;
cursor:pointer;
color:var(--primary-color);
user-select:none;
}

/* TABLET + MOBILE */

@media(max-width:900px){

.menu-toggle{
display:block;
}

.nav-links{
position:absolute;
top:60px;
left:0;
width:100%;
background:var(--card-bg);
flex-direction:column;
align-items:flex-start;
padding:15px;
display:none;
border-top:1px solid #eee;
}

.nav-links a{
width:100%;
padding:10px 0;
}

.nav-links.show{
display:flex;
}

}

</style>

<script>

function toggleMenu(){

	let nav=document.getElementById("navLinks");
	let arrow=document.getElementById("menuArrow");

	nav.classList.toggle("show");

	if(nav.classList.contains("show")){
	arrow.innerHTML="▲";
	}else{
	arrow.innerHTML="▼";
	}

	}

function toggleDropdown(){
document.getElementById("profileDropdown").classList.toggle("show");
}

window.onclick=function(event){

if(!event.target.matches('.profile-icon')){
let dropdown=document.getElementById("profileDropdown");
if(dropdown && dropdown.classList.contains("show")){
dropdown.classList.remove("show");
}
}

}

</script>

</head>

<body>

<header class="navbar">

<div class="container">

<a href="dashboard.jsp" class="logo">Quiz<span>Pro</span></a>

<!-- MOBILE MENU ICON -->
<div class="menu-toggle" onclick="toggleMenu()">
Menu <span id="menuArrow">▼</span>
</div>

<div class="nav-links" id="navLinks">

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

<!-- PROFILE MENU -->

<div class="profile-menu">

<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwJgi2tfPov2vnIRkuxgRw_gHSqt_uRGbrdA&s"
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