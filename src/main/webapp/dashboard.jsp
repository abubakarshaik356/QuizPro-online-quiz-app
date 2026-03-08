<%@page import="com.quizpro.dto.UserTestHis"%>
<%@page import="com.quizpro.dao.UserDAOImpl"%>
<%@page import="com.quizpro.dao.UserDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.quizpro.dao.SubjectDAOImpl"%>
<%@page import="com.quizpro.dao.SubjectDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.quizpro.dto.Subject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String name = (String) session.getAttribute("name");
Integer idObj = (Integer) session.getAttribute("id");

if (name == null || idObj == null) {
	response.sendRedirect("login.jsp");
	return;
}

int id = idObj;

SubjectDAO dao = new SubjectDAOImpl();
List<Subject> list = dao.getAllSubjects();
UserDAO userDAO = new UserDAOImpl();
List<UserTestHis> history = userDAO.userTestHistory(id);
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - Member Home (Dashboard)</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<style>
:root {
	--primary-color: #0077B6;
	--accent-color: #FFB700;
	--dark-bg: #F0F2F5;
	--light-text: #212529;
	--card-bg: #FFFFFF;
	--subtle-gray: #6C757D;
	--shadow-light: rgba(0, 0, 0, 0.08);
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
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 15px;
}

h2 {
	font-size: 1.8em;
	font-weight: 800;
	margin-bottom: 20px;
	color: var(--light-text);
	text-align: left;
}

h3 {
	font-size: 1.2em;
	font-weight: 700;
	margin-top: 0;
}

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

.nav-links a:hover, .nav-links .active {
	color: var(--primary-color);
	border-bottom: 3px solid var(--primary-color);
}

/* --- Profile Dropdown CSS FIX --- */
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
	/* Initially hidden - JS will toggle 'show' class */
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

/* CSS to display the dropdown when JS adds the 'show' class */
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

/* --- END FIX --- */

/* --- Dashboard Layout --- */
.dashboard-grid {
	display: grid;
	grid-template-columns: 1fr;
	gap: 30px;
	padding: 40px 0;
}

.section {
	margin-bottom: 30px;
}

/* --- Banner --- */
.action-banner {
	background: linear-gradient(90deg, var(--primary-color) 0%, #0099D4 100%);
	color: white;
	padding: 35px;
	border-radius: 12px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.action-banner h1 {
	font-size: 2.2em;
	margin: 0;
	font-weight: 800;
}

.action-banner p {
	font-size: 1.1em;
	opacity: 0.9;
	margin: 5px 0 0 0;
}

.cta-button {
	display: inline-block;
	background-color: var(--accent-color);
	color: #1A1A1A;
	padding: 12px 25px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: 700;
	font-size: 1em;
	transition: opacity 0.2s, transform 0.2s;
}

.cta-button:hover {
	opacity: 0.9;
	transform: translateY(-1px);
}

/* --- Categories --- */
.category-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
	gap: 20px;
	margin-top: 20px;
}

.viewall {
	width: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.category-card {
	background-color: var(--card-bg);
	padding: 25px 15px;
	height: 180px;
	border-radius: 8px;
	text-align: center;
	cursor: pointer;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
	transition: background-color 0.3s, transform 0.3s;
	border: 1px solid #E0E0E0;
}

.category-card:hover {
	background-color: var(--primary-color);
	color: var(--card-bg);
	transform: translateY(-5px);
}

.category-card:hover h3 {
	color: var(--card-bg);
}

.category-card:hover p {
	color: var(--card-bg);
}

.category-card:hover .icon {
	color: var(--accent-color);
}

.category-card .icon {
	font-size: 2.5em;
	margin-bottom: 10px;
	color: var(--primary-color);
}

.card-anchor {
	text-decoration: none;
}

.card-anchor h3 {
	color: var(--primary-color);
}

.card-anchor p {
	color: var(--subtle-gray);
}

/* --- My Tests/Recents --- */
.test-list {
	list-style: none;
	padding: 0;
}

.test-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: var(--card-bg);
	padding: 15px 20px;
	margin-bottom: 10px;
	border-radius: 8px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.test-item span {
	font-weight: 600;
	color: var(--primary-color);
}

.test-item small {
	color: var(--subtle-gray);
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.navbar .nav-links {
		display: none;
	}
	.action-banner {
		flex-direction: column;
		align-items: flex-start;
		text-align: left;
	}
	.action-banner .cta-button {
		margin-top: 20px;
		width: 85%;
		text-align: center;
	}
	.category-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media (max-width:600px){

.test-item{
flex-direction:column;
align-items:flex-start;
gap:5px;
}

.test-item span{
font-size:14px;
}

.section{
margin: 10px;
}



}

.path-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
}

.path-card {
	background-color: var(--card-bg);
	padding: 25px;
	border-radius: 12px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
	text-align: left;
	border-top: 5px solid var(--primary-color);
}

.path-card p {
	color: var(--subtle-gray);
	min-height: 40px;
	/* Ensures card height uniformity */
}

.progress-bar-container {
	margin-top: 10px;
	background-color: #e9ecef;
	border-radius: 5px;
	height: 10px;
	overflow: hidden;
}

.progress-bar {
	height: 100%;
	background-color: var(--primary-color);
	border-radius: 5px;
	transition: width 0.5s;
}

/* FAQ Styling */
.faq-list {
	max-width: 900px;
	margin: 0 auto;
	text-align: left;
}

.faq-item {
	background: var(--card-bg);
	margin-bottom: 10px;
	border-radius: 8px;
	box-shadow: 0 1px 5px rgba(0, 0, 0, 0.05);
}

.faq-item summary {
	padding: 18px;
	font-weight: 600;
	color: var(--primary-color);
	cursor: pointer;
	border-bottom: 1px solid #eee;
}

.faq-item p {
	padding: 15px 18px;
	color: var(--subtle-gray);
}

/* Blog Styling */
#blog {
	margin-top: 0;
	padding: 40px 0;
}

.blog-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
	margin-top: 30px;
	padding: auto;
}

.blog-post-card {
	background-color: var(--dark-bg);
	border-radius: 10px;
	overflow: hidden;
	text-align: left;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
	transition: transform 0.2s;
}

.blog-post-card:hover {
	transform: translateY(-5px);
}

.blog-post-card img {
	width: 100%;
	height: 200px;
	display: block;
}

.blog-post-card h3, .blog-post-card small, .blog-post-card .read-more {
	padding: 0 15px;
	display: block;
}

.blog-post-card h3 {
	margin-top: 15px;
	margin-bottom: 5px;
	font-size: 1.3em;
}

.blog-post-card .read-more {
	padding-bottom: 15px;
	font-weight: 600;
	color: var(--accent-color);
	text-decoration: none;
}

@media (max-width:768px){

.action-banner{
flex-direction:column;
align-items:flex-start;
gap:15px;
padding:25px;
margin:10px;
}

.action-banner h1{
font-size:1.6em;
}

.action-banner a{
margin-right:20px;
}
.view-all .cta-button{
width:800%;
text-align:center;
}

}
/* --- Support Banner Styling (Merged Contact Section) --- */
</style>
</head>

<body>
	<%@ include file="navbar.jsp"%>

	<div class="container dashboard-grid">

		<div class="section">
			<div class="action-banner">
				<div>
					<h1>
						Welcome back,
						<%=name%>! 👋
					</h1>
					<p>Continue your progress and explore new expert challenges
						today.</p>
				</div>
				<a href="ViewProfile" class="cta-button">View My Profile</a>
			</div>
		</div>

		<div class="section" id="my-tests">
			<h2>
				<i class="fas fa-history"></i> My Recent Activity
			</h2>
			<%
			if (history.isEmpty()) {
			%>
			<div class="empty">
				<img alt="Empty"
					src="https://cdn-icons-png.flaticon.com/128/13543/13543236.png">
				<h3>No Recent Activity Available</h3>
			</div>
			<%
			} else {
			%>
			<ul class="test-list">
				<%
				int count = 0;
				for (UserTestHis l : history) {
					count++;
					if (count == 5) {
						break;
					}
				%>
				<li class="test-item">
					<div>
						<p>
							<strong><%=l.getQuizName()%></strong>
						</p>
						<small>Status: Completed</small>
					</div> <span><%=l.getScorePer()%>% Scored</span>
				</li>
				<%
				}
				%>
			</ul>
			<%
			}
			%>
		</div>

		<div class="section" id="categories">
			<h2>
				<i class="fas fa-list-alt"></i> Explore Top Categories
			</h2>
			<div class="category-grid">
				<%
				int count = 0;
				for (Subject s : list) {
				%>
				<a
					href="quizes?subId=<%=s.getSubId()%>&userId=<%=id%>&title=<%=s.getSubname()%> &desc=<%=s.getSubDesc()%>"
					class="card-anchor">
					<div class="category-card">
						<i class="fas fa-book icon"></i>
						<h3><%=s.getSubname()%></h3>
						<p><%=s.getSubDesc()%></p>
					</div>
				</a>
				<%
				count++;
				if (count == 5) {
					break;
				}
				}
				%>
				<!-- 
				<div class="category-card">
					<i class="fas fa-code icon"></i>
					<h3>Software Engineering</h3>
				</div>
				<div class="category-card">
					<i class="fas fa-flask icon"></i>
					<h3>Data Science & AI</h3>
				</div>
				<div class="category-card">
					<i class="fas fa-building icon"></i>
					<h3>Financial Analysis</h3>
				</div>
				<div class="category-card">
					<i class="fas fa-shield-alt icon"></i>
					<h3>Cybersecurity</h3>
				</div>
				<div class="category-card">
					<i class="fas fa-globe icon"></i>
					<h3>Global Economics</h3>
				</div>
				<div class="category-card">
					<i class="fas fa-database icon"></i>
					<h3>Cloud Infrastructure</h3>
				</div>
			 -->
			</div>
			<div class="viewall">
				<a href="categories" class="cta-button" style="margin-top: 40px">View
					All Categories</a>
			</div>
		</div>
		<section class="section" id="faq"
			style="background-color: var(--dark-bg);">
			<div class="container">
				<h2 style="text-align: center;">
					<i class="fas fa-question-circle"></i> Frequently Asked Questions
				</h2>
				<div class="faq-list">
					<details class="faq-item">
						<summary>How often is the quiz content updated?</summary>
						<p>Our quizzes are reviewed and updated weekly by subject
							matter experts to ensure alignment with the latest industry
							standards and certification requirements.</p>
					</details>
					<details class="faq-item">
						<summary>Can I earn verifiable certificates?</summary>
						<p>Yes. Upon achieving a mastery score of 80% or higher in
							certain specialized learning paths, you will receive a digital
							certificate for your professional profile.</p>
					</details>
					<details class="faq-item">
						<summary>Is there a cost to use QuizPro?</summary>
						<p>We offer a generous free trial with access to introductory
							quizzes. Full access to specialized paths and analytics requires
							a paid subscription.</p>
					</details>
				</div>
			</div>
		</section>

		<section class="section" id="blog"
			style="background-color: var(--card-bg);">
			<div class="container">
				<h2 style="text-align: center;">
					<i class="fas fa-lightbulb"></i> Latest Industry Insights
				</h2>
				<div class="blog-grid">
					<div class="blog-post-card">
						<img
							src="https://www.brainvire.com/blog/wp-content/uploads/2024/09/AI-In-Cloud-Computing-Is-Bringing-Efficiency-And-Scalability.webp"
							alt="Article Thumbnail">
						<h3 style="color: var(--primary-color);">The Future of AI in
							Cloud Computing</h3>
						<small style="color: var(--subtle-gray);">May 15, 2025 | 7
							min read</small> <a href="https://www.w3schools.com/ai/ai_whatis.asp"
							class="read-more" target="_blank">Read More →</a>
					</div>
					<div class="blog-post-card">
						<img
							src="https://www.rogersoft.com/storage/attachments/1694676692.jpg"
							alt="Article Thumbnail">
						<h3 style="color: var(--primary-color);">5 Essential SQL
							Tricks for Data Analysts</h3>
						<small style="color: var(--subtle-gray);">May 8, 2025 | 5
							min read</small> <a href="https://www.w3schools.com/sql/"
							class="read-more" target="_blank">Read More →</a>
					</div>
					<div class="blog-post-card">
						<img
							src="https://www.cfoselections.com/hs-fs/hubfs/Images-CFOS/Building-a-3-Year-Financial-Model.jpeg?width=563&height=375&name=Building-a-3-Year-Financial-Model.jpeg"
							alt="Article Thumbnail">
						<h3 style="color: var(--primary-color);">Mastering Financial
							Modeling in Q3 2025</h3>
						<small style="color: var(--subtle-gray);">May 1, 2025 | 10
							min read</small> <a
							href="https://www.ey.com/en_in/services/ey-faas-learning-solutions/e-learning-certification-in-financial-modelling-and-valuation"
							class="read-more" target="_blank">Read More →</a>
					</div>
				</div>
			</div>
		</section>

	</div>
	<%@include file="Footer.jsp"%>

	<script>
		function toggleDropdown() {
			// Toggles the 'show' class on the dropdown content
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