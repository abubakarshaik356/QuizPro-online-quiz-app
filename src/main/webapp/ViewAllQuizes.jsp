<%@page import="java.util.ArrayList"%>
<%@page import="com.quizpro.dto.Quizzes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    ArrayList<Quizzes> quizes = (ArrayList<Quizzes>) request.getAttribute("quizes");

    String categoryName = request.getParameter("categoryName") != null 
                          ? request.getParameter("categoryName") 
                          : "Selected Category";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View All Quizzes</title>

<style>
    body {
        margin: 0;
        font-family: 'Arial', sans-serif;
        background: linear-gradient(135deg, #e3f2fd, #fce4ec);
        min-height: 100vh;
    }

    .navbar {
        background: #1976d2;
        color: white;
        padding: 14px 30px;
        font-size: 20px;
        font-weight: bold;
        display: flex;
        align-items: center;
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .navbar .logo {
        font-size: 24px;
        font-weight: 900;
        letter-spacing: 1px;
    }

    .navbar .logo span {
        color: #ffeb3b;
    }

    .container {
        width: 90%;
        max-width: 1100px;
        margin: 40px auto;
        background: #ffffffb5;
        backdrop-filter: blur(8px);
        padding: 30px;
        border-radius: 16px;
        box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15);
        animation: fadeIn 0.6s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .quiz-box {
        background: white;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 18px rgba(0,0,0,0.1);
        border-left: 6px solid #2196f3;
    }

    .quiz-title {
        font-size: 20px;
        font-weight: bold;
        color: #1a237e;
    }

    .quiz-details {
        font-size: 16px;
        color: #444;
        margin-top: 8px;
    }

    .view-btn {
        display: inline-block;
        background: #1976d2;
        color: white;
        padding: 8px 18px;
        border-radius: 8px;
        font-size: 14px;
        text-decoration: none;
        margin-top: 12px;
        transition: 0.2s;
    }

    .view-btn:hover {
        background: #115299;
        transform: translateY(-2px);
    }

    .back-btn {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 16px;
        background: #1976d2;
        color: white;
        border-radius: 8px;
        text-decoration: none;
        font-weight: bold;
        transition: 0.2s ease;
    }

    .back-btn:hover {
        background: #115299;
        transform: translateY(-2px);
    }

</style>
</head>
<body>

<div class="navbar">AdminPro</div>

<div class="container">
	
    <h2>Quizzes in: <%= categoryName %></h2>

    <% if (quizes != null && !quizes.isEmpty()) { 
        for (Quizzes q : quizes) { %>

        <div class="quiz-box">
            <div class="quiz-title"><%= q.getTitle() %></div>
            <p>Questions: <%= q.getQuestions() %> | Marks: <%= q.getMarks() %></p>

            <a class="view-btn" 
               href="ViewAllQuestions?quizId=<%= q.getUserId() %>&quizName=<%= q.getTitle() %>">
                View Questions
            </a>
        </div>

    <% }} else { %>

        <h3>No quizzes available.</h3>

    <% } %>

    <br>
    <a href="ContentManagement" class="view-btn">Back to Categories</a>

</div>

</body>
</html>