
<%@page import="com.quizpro.dto.Subject"%>
<%@page import="java.util.List"%>
<%@page import="com.quizpro.dao.SubjectDAOImpl"%>
<%@page import="com.quizpro.dao.SubjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
SubjectDAO dao = new SubjectDAOImpl();
List<Subject> list = dao.getAllSubjects();
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>The Ultimate Quiz Hub - Test Your Professional Knowledge</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
:root {
	/* Professional Color Palette (Deep Teal & Subtle Gold) */
	--primary-color: #0077B6;
	/* Deep Blue/Teal for Trust */
	--accent-color: #FFB700;
	/* Refined Gold/Orange for CTA */
	--dark-bg: #F8F9FA;
	/* Light Background for clean look */
	--light-text: #212529;
	/* Dark Text */
	--card-bg: #FFFFFF;
	/* White Cards */
	--subtle-gray: #6C757D;
	/* Subtler text/dividers */
	--shadow-light: rgba(0, 0, 0, 0.08);
	/* Soft Shadow */
}

/* Basic Reset and Typography */
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
	background-color: var(--dark-bg);
	color: var(--light-text);
	line-height: 1.6;
	text-align: center;
}

h1, h2, h3 {
	color: var(--light-text);
	line-height: 1.2;
	margin-bottom: 0.5em;
}

h2 {
	font-size: 2.5em;
	font-weight: 800;
	margin-bottom: 0.7em;
}

/* Utility Class for Layout */
.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 15px;
}

.section {
	padding: 80px 0;
}

/* --- Components --- */

/* Header Navigation */
.header {
	background: var(--card-bg);
	border-bottom: 1px solid #dee2e6;
	padding: 15px 0;
	position: sticky;
	top: 0;
	z-index: 1000;
}

.header .container {
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

.nav a {
	color: var(--light-text);
	text-decoration: none;
	margin-left: 30px;
	font-weight: 600;
	transition: color 0.3s;
}

.nav a:hover {
	color: var(--primary-color);
}

/* CTA Button Styling */
.cta-button {
	display: inline-block;
	background-color: var(--accent-color);
	color: #1A1A1A;
	/* Darker text for contrast on gold */
	padding: 15px 35px;
	border-radius: 8px;
	/* Slightly less rounded */
	text-decoration: none;
	font-weight: 800;
	font-size: 1.1em;
	letter-spacing: 0.5px;
	transition: transform 0.2s, box-shadow 0.2s, opacity 0.2s;
	border: none;
	cursor: pointer;
}

.cta-button:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 12px rgba(255, 183, 0, 0.4);
}

/* --- Hero Section --- */
.hero {
	background-color: var(--card-bg);
	/* Use light background for professionalism */
	padding: 100px 0;
	border-bottom: 4px solid var(--primary-color);
}

.hero h1 {
	font-size: 3.8em;
	font-weight: 800;
	margin-bottom: 15px;
}

.hero h1 span {
	color: var(--primary-color);
}

.hero p {
	font-size: 1.5em;
	color: var(--subtle-gray);
	margin-bottom: 40px;
	max-width: 900px;
	margin-left: auto;
	margin-right: auto;
}

.trust-text {
	display: block;
	margin-top: 20px;
	font-size: 0.9em;
	color: var(--subtle-gray);
}

/* --- Value Props Section (Grid) --- */
.value-props {
	background-color: var(--dark-bg);
}

.props-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
	margin-top: 50px;
}

.prop-item {
	padding: 30px;
	background-color: var(--card-bg);
	border-radius: 10px;
	box-shadow: 0 5px 15px var(--shadow-light);
	text-align: left;
	transition: box-shadow 0.3s;
}

.prop-item:hover {
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.prop-item .icon {
	font-size: 2.5em;
	color: var(--primary-color);
	margin-bottom: 15px;
	display: block;
}

.prop-item h3 {
	margin-top: 0;
	font-weight: 800;
}

.prop-item p {
	color: var(--subtle-gray);
}

/* --- Category Cards Section --- */
.category-cards {
	background-color: var(--card-bg);
	padding: 60px 0;
	border-top: 1px solid #dee2e6;
}

.category-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
	gap: 20px;
	margin-top: 40px;
}

.card {
	background-color: #F0F0F0;
	padding: 25px 15px;
	border-radius: 8px;
	text-align: center;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.3s;
	border: 1px solid #E0E0E0;
}

.card:hover {
	background-color: var(--primary-color);
	color: var(--white);
	transform: translateY(-5px);
}

.card:hover h3 {
	color: var(--white);
}

.card:hover .icon {
	color: var(--accent-color);
}

.card .icon {
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

.card h3 {
	font-size: 1.1em;
	margin: 0;
	color: var(--light-text);
}

/* --- Testimonial & Data Block --- */
.testimonial-block {
	background-color: var(--dark-bg);
	padding: 60px 0;
	border-top: 1px solid #dee2e6;
}

.testimonial-container {
	max-width: 800px;
	margin: 0 auto;
}

.quote {
	background-color: var(--card-bg);
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 5px 15px var(--shadow-light);
	font-size: 1.2em;
	font-style: italic;
	position: relative;
	text-align: left;
	margin-bottom: 20px;
}

.quote::before {
	content: "\f10d";
	/* Font Awesome quote left icon */
	font-family: 'Font Awesome 6 Free';
	font-weight: 900;
	font-size: 3em;
	color: var(--primary-color);
	opacity: 0.1;
	position: absolute;
	top: 15px;
	left: 15px;
}

.author {
	text-align: right;
	font-weight: 600;
	color: var(--primary-color);
}

/* --- Final CTA Banner --- */
.final-cta {
	background-color: var(--primary-color);
	padding: 60px 0;
}

.final-cta h2 {
	color: var(--card-bg);
	margin-bottom: 20px;
	font-size: 2.5em;
}

.final-cta p {
	color: #d1d9e0;
	font-size: 1.2em;
	margin-bottom: 30px;
}

/* --- Footer --- */
.footer {
	background-color: #1A1A1A;
	color: #A9A9A9;
	padding: 30px 0;
	font-size: 0.9em;
}

.footer a {
	color: #A9A9A9;
	margin: 0 10px;
	text-decoration: none;
}

.footer a:hover {
	color: var(--accent-color);
}

/* --- Responsive Adjustments --- */
@media ( max-width : 768px) {
	.hero h1 {
		font-size: 2.5em;
	}
	.hero p {
		font-size: 1.2em;
	}
	.header .nav {
		display: none;
	}
}

/* --- Certificate Section Styling --- */
.certificate-section {
	padding: 80px 0;
}

.certificate-content-grid {
	display: grid;
	grid-template-columns: 1.5fr 2fr;
	/* Info on left, image larger on right */
	gap: 60px;
	align-items: center;
	text-align: left;
}

.certificate-info {
	padding: 20px 0;
}

.certificate-info p {
	font-size: 1.2em;
	color: var(--primary-color);
	margin-bottom: 15px;
	font-weight: 700;
}

.certificate-info ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.certificate-info ul li {
	padding: 10px 0;
	border-bottom: 1px dashed #E0E0E0;
	color: var(--light-text);
	position: relative;
	padding-left: 25px;
}

.certificate-info ul li:before {
	content: "\f058";
	/* Font Awesome checkmark */
	font-family: "Font Awesome 6 Free";
	font-weight: 900;
	color: green;
	position: absolute;
	left: 0;
	top: 10px;
	font-size: 1em;
}

.certificate-mockup {
	/* Styles for the image container */
	padding: 20px;
	background: var(--card-bg);
	border-radius: 12px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
	transform: rotate(-3deg);
	/* Add a slight tilt for visual interest */
	transition: transform 0.3s;
}

.certificate-mockup:hover {
	transform: rotate(0deg);
	/* Straightens on hover */
}

.certificate-mockup img {
	max-width: 100%;
	height: auto;
	display: block;
	border-radius: 8px;
}

/* Responsive adjustment for smaller screens */
@media ( max-width : 768px) {
	.certificate-content-grid {
		grid-template-columns: 1fr;
		/* Stack content vertically */
	}
	.certificate-mockup {
		margin-top: 40px;
	}
}
</style>
</head>

<body>

	<header class="header">
		<div class="container">
			<a href="#" class="logo">Quiz<span
				style="color: var(--accent-color);">Pro</span></a>
			<nav class="nav">
				<a href="#categories">Explore</a> <a href="Aboutus.jsp">About Us</a> <a
					href="login.jsp">Login</a> <a href="signup.jsp" class="cta-button"
					style="padding: 10px 20px; margin-left: 25px; font-size: 1em;">Get
					Started</a>
			</nav>
		</div>
	</header>

	<section class="hero section">
		<div class="container">
			<h1>
				Validate Your <span>Expertise</span>. Advance Your Career.
			</h1>
			<p>Access high-caliber, professionally curated quizzes and
				assessments designed to test deep knowledge in technical and
				specialized fields.</p>
			<a href="login.jsp" class="cta-button">Start Assessment Free
				Trial</a> <span class="trust-text"><i class="fas fa-check-circle"></i>
				Trusted by 10,000+ Industry Professionals</span>
		</div>
	</section>

	<section class="value-props section">
		<div class="container">
			<h2>Why Professionals Choose QuizPro</h2>
			<div class="props-grid">
				<div class="prop-item">
					<i class="fas fa-microchip icon"></i>
					<h3>Advanced Topic Coverage</h3>
					<p>Go beyond trivia. Our quizzes cover complex, niche subjects
						requiring true expertise and critical thinking.</p>
				</div>
				<div class="prop-item">
					<i class="fas fa-chart-line icon"></i>
					<h3>Benchmark Your Skills</h3>
					<p>See where you stand against peers globally with detailed
						performance analytics and skill benchmarking reports.</p>
				</div>
				<div class="prop-item">
					<i class="fas fa-award icon"></i>
					<h3>Certificate of Completion</h3>
					<p>Earn verifiable certificates for mastery in specific domains
						to boost your professional profile and resume.</p>
				</div>
			</div>
		</div>
	</section>

	<section class="category-cards section" id="categories">
		<div class="container">
			<h2>Specialized Assessment Areas</h2>
			<div class="category-grid">
				<%
				int count = 0;
				for (Subject s : list) {
				%>
				<a href="login.jsp" class="card-anchor">
					<div class="card">
						<i class="fas fa-book icon"></i>
						<h3><%=s.getSubname()%></h3>
					</div>
				</a>
				<%
				count++;
				if (count == 5) {
					break;
				}
				}
				%>
			</div>
			<a href="login.jsp" class="cta-button" style="margin-top: 40px;">View
				All Specialized Fields</a>
		</div>
	</section>

	<section class="testimonial-block">
		<div class="testimonial-container">
			<div class="quote">"The quality of the questions here is
				unmatched. It truly helped me identify my weak spots before my
				certification exam. A must-have tool for serious learners."</div>
			<p class="author">— Dr. Emily C., Senior Data Scientist at
				TechCorp</p>
		</div>
	</section>

	<section class="section certificate-section"
		style="background-color: var(--dark-bg);">
		<div class="container">
			<h2 style="text-align: center;">
				<i class="fas fa-certificate"></i> Certify Your Expertise
			</h2>
			<p
				style="text-align: center; max-width: 800px; margin: 0 auto 50px; color: var(--subtle-gray);">Earn
				official, verifiable certification upon mastering any specialized
				learning path. Showcase your skills to employers and on professional
				networks.</p>

			<div class="certificate-content-grid">

				<div class="certificate-info">
					<p>
						<strong>Verifiable Credentials:</strong>
					</p>
					<ul>
						<li>Globally recognized proof of knowledge.</li>
						<li>Unique verification ID for employers.</li>
						<li>Shareable directly to LinkedIn.</li>
						<li>High-resolution printable PDF.</li>
					</ul>
					<a href="login.jsp" class="cta-button" style="margin-top: 20px;">View
						All Certifications</a>
				</div>

				<div class="certificate-mockup">
					<img src="assets/certificate.png" alt="Certificate Example">
				</div>

			</div>
		</div>
	</section>

	<section class="final-cta section">
		<div class="container">
			<h2>Take Control of Your Career Growth.</h2>
			<p>Start your free 7-day trial and unlock the knowledge that
				drives industry leaders.</p>
			<a href="login.jsp" class="cta-button">Access Professional
				Quizzes Now</a>
		</div>
	</section>

	<footer class="footer">
		<div class="container">
			<p>
				&copy; 2025 QuizPro. All Rights Reserved. | <a href="#">Legal</a> |
				<a href="#">Support</a> | <a href="#">Careers</a>
			</p>
		</div>
	</footer>

</body>

</html>