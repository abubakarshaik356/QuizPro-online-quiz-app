<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.support-banner {
	background-color: #1A1A1A;
	/* Very dark background for high contrast */
	color: white;
	padding: 10px 0;
	text-align: center;
	margin-bottom: 0;
}

.support-title {
	color: white;
	margin-bottom: 10px;
}

.support-subtitle {
	color: #A9A9A9;
	margin-bottom: 30px;
}

.support-form-container {
	max-width: 600px;
	margin: 0 auto;
	display: flex;
	gap: 20px;
	align-items: center;
	justify-content: center;
}

.support-input {
	padding: 14px 15px;
	border: none;
	border-radius: 8px;
	flex-grow: 1;
	font-size: 1em;
	min-width: 250px;
}

.support-button {
	/* Uses existing cta-button styles */
	background-color: var(--accent-color) !important;
	color: var(--light-text) !important;
	padding: 14px 25px !important;
	font-weight: 700;
	border-radius: 8px;
	text-decoration: none;
	transition: opacity 0.2s;
}

.support-button:hover {
	opacity: 0.9;
}

.support-links {
	margin-top: 25px;
	font-size: 0.95em;
}

.support-query-form {
	max-width: 600px;
	margin: 20px auto 0;
	display: flex;
	flex-direction:column;
	gap: 12px;
}

.support-textarea {
	height:60px;
	padding: 14px;
	border-radius: 8px;
	border: none;
	resize: vertical;
	font-size: 14px;
}

.support-button {
	background-color: var(--accent-color);
	color: var(--light-text);
	padding: 12px;
	font-weight: 700;
	border-radius: 8px;
	border: none;
	cursor: pointer;
}

.knowledge-base-link {
	color: var(--accent-color);
	text-decoration: none;
	font-weight: 600;
	transition: color 0.2s;
}

.knowledge-base-link:hover {
	color: #FFCF40;
	/* Lighter gold on hover */
}

.phone-number {
	color: #A9A9A9;
}

/* --- Footer Styling --- */
.footer {
	background-color: #0d0d1a;
	/* Slightly lighter dark color for distinction */
	color: #A9A9A9;
	margin-top: 0;
	padding: 20px 0;
	font-size: 0.9em;
	text-align: center;
	border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.footer-copyright a {
	color: #A9A9A9;
	margin: 0 10px;
	text-decoration: none;
	transition: color 0.2s;
}

.footer-copyright a:hover {
	color: var(--accent-color);
}

.empty {
	width: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
}
</style>
</head>
<body>

	<section class="support-banner section">
		<div class="container">
			<h2 class="support-title">
				<i class="fas fa-headset"></i> Need Help?
			</h2>

			<p class="support-links">
				<a href="#" class="knowledge-base-link">Visit our Knowledge Base</a>
				| <span class="phone-number"> Call us at: +91 <b>7569700589</b>
					| <b>quizpro.org@gmail.com</b>
				</span>
			</p>
		</div>
	</section>

	<footer class="footer">
		<div class="container">

			<%
			String userEmail = (String) session.getAttribute("email");
			String username = (String) session.getAttribute("name");
			Integer userId = (Integer) session.getAttribute("id");
			%>

			<form action="sendQuery" method="post" class="support-query-form">

				<textarea name="message" class="support-textarea"
					placeholder="Have a question or issue? Write to us..." required></textarea>


				<input type="hidden" name="userEmail" value="<%=userEmail%>">
				<input type="hidden" name="username" value="<%=username%>">
				<input type="hidden" name="userId" value="<%=userId%>"> <input
					type="hidden" name="redirectPage"
					value="<%=request.getRequestURI()%>">


				<button type="submit" class="support-button">Send Query</button>
			</form> 

			<p class="footer-copyright">&copy; 2025 QuizPro. All Rights
				Reserved.</p>
		</div>
	</footer>

	<%
	String status = request.getParameter("queryStatus");
	%>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<script>
		
	<%if ("sent".equals(status)) {%>
		Swal.fire({
			icon : 'success',
			title : 'Query Sent!',
			text : 'Your query has been sent successfully.',
			confirmButtonColor : '#FFB700'
		});
	<%} else if ("error".equals(status)) {%>
		Swal.fire({
			icon : 'error',
			title : 'Failed!',
			text : 'Failed to send your query. Please try again.',
			confirmButtonColor : '#FFB700'
		});
	<%} else if ("empty".equals(status)) {%>
		Swal.fire({
			icon : 'warning',
			title : 'Message Required',
			text : 'Please enter your query before sending.',
			confirmButtonColor : '#FFB700'
		});
	<%}%>
		
	</script>


</body>
</html>