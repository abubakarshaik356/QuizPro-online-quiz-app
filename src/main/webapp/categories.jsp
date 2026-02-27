<%@ page import="java.util.List"%>
<%@ page import="com.quizpro.dto.Subject"%>
<%@ page import="com.quizpro.dao.SubjectDAO"%>
<%@ page import="com.quizpro.dao.SubjectDAOImpl"%>
<%
// Fetch subjects from servlet attribute or DAO as fallback
List<Subject> list = (List<Subject>) request.getAttribute("list");
if (list == null) {
	SubjectDAO dao = new SubjectDAOImpl();
	list = dao.getAllSubjects();
	if (list == null)
		list = new java.util.ArrayList<>();
}
int id=(int)session.getAttribute("id");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - Categories</title>
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
}

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
	margin-bottom: 10px;
	color: var(--light-text);
}

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

.page-header {
	padding: 40px 0 30px;
}

.page-header p {
	font-size: 1.1em;
	color: var(--subtle-gray);
}

.search-bar {
	display: flex;
	gap: 20px;
	margin-top: 20px;
}

.search-bar input {
	flex-grow: 1;
	padding: 15px;
	border: 1px solid #CED4DA;
	border-radius: 8px;
	font-size: 1em;
	transition: border-color 0.3s;
}

.search-bar input:focus {
	border-color: var(--primary-color);
	outline: none;
	box-shadow: 0 0 0 3px rgba(0, 119, 182, 0.1);
}

.filter-select {
	padding: 15px;
	border: 1px solid #CED4DA;
	border-radius: 8px;
	background-color: var(--card-bg);
	font-size: 1em;
	cursor: pointer;
}

.category-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
	gap: 30px;
	padding-bottom: 60px;
}

.category-card {
	background-color: var(--card-bg);
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 15px var(--shadow-light);
	transition: transform 0.3s, box-shadow 0.3s;
	display: flex;
	flex-direction: column;
	border-top: 5px solid var(--primary-color);
}

.category-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.category-header {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
}

.category-icon {
	font-size: 2.5em;
	color: var(--primary-color);
	margin-right: 20px;
	width: 50px;
	text-align: center;
}

.category-header h3 {
	font-size: 1.5em;
	font-weight: 800;
	margin: 0;
	color: var(--light-text);
}

.category-meta {
	margin-top: 15px;
	font-size: 0.9em;
	color: var(--subtle-gray);
	border-top: 1px solid #E9ECEF;
	padding-top: 15px;
}

.meta-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 8px;
}

.action-button {
	display: inline-block;
	background-color: transparent;
	color: var(--primary-color);
	border: 2px solid var(--primary-color);
	padding: 10px 20px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: 700;
	font-size: 1em;
	margin-top: 20px;
	align-self: flex-start;
	transition: all 0.2s;
}

.action-button:hover {
	background-color: var(--primary-color);
	color: var(--card-bg);
}

@media ( max-width : 768px) {
	.navbar .nav-links {
		display: none;
	}
	.search-bar {
		flex-direction: column;
		gap: 10px;
	}
	.category-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>

<%@ include file="navbar.jsp" %>

	<div class="container">
		<div class="page-header">
			<h1>Browse All Categories</h1>

        <div class="search-bar">
        <input type="text" id="searchInput" placeholder="Search for any subject...">
           <!--  <select class="filter-select">
                <option>Filter by Difficulty</option>
            </select>
            <select class="filter-select">
                <option>Filter by Progress</option>
            </select> -->
        </div>
		</div>

		<div class="category-grid">
			<%
			for (Subject s : list) {
			%>
			<div class="category-card">
				<div class="category-header">
					<i class="fas fa-book category-icon"></i>
					<div>
						<h3><%=s.getSubname()%></h3>
						<p><%=s.getSubDesc()%></p>
					</div>
				</div>
				<div class="category-meta">
					<div class="meta-row">
						<span style="font-weight: 600;"><i class="fas fa-cubes"></i>
							Quizzes Available:</span> <span><%=s.getQuizCount()%></span>
					</div>
					<%-- <div class="meta-row">
						<span style="font-weight: 600;"><i
							class="fas fa-chart-line"></i> Your Progress:</span> <span>0 / <%=s.getQuizCount()%>
							Quizzes Completed
						</span>
					</div> --%>
					<div class="meta-row">
						<span style="font-weight: 600;"><i
							class="fas fa-certificate"></i> Certification Path:</span> <span
							style="color: var(--accent-color);">Available</span>
					</div>
				</div>
				<a href="quizes?subId=<%=s.getSubId()%>&userId=<%=id %>&title=<%=s.getSubname() %>&desc=<%=s.getSubDesc() %>"
					class="action-button"> <i class="fas fa-chevron-right"></i>
					Browse All Quizzes
				</a>
			</div>
			<%
			}
			%>
		</div>
	</div>

<script>
    const searchInput = document.getElementById("searchInput");
    const cards = document.querySelectorAll(".category-card");

    searchInput.addEventListener("keyup", function () {
        const searchText = searchInput.value.toLowerCase().trim();

        cards.forEach(card => {
            const cardText = card.innerText.toLowerCase();
            if (cardText.includes(searchText)) {
                card.style.display = "flex";
            } else {
                card.style.display = "none";
            }
        });
    });
</script>


</body>
</html>
