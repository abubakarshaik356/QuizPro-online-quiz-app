<%@page import="java.util.ArrayList"%>
<%@page import="com.quizpro.dto.Questions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    ArrayList<Questions> questions = (ArrayList<Questions>) session.getAttribute("ListQuestions");
	String quizName="";
	String quizCategory="";
	if(session.getAttribute("QuizName")!=null){
    	quizName = (String) session.getAttribute("QuizName");
    	quizCategory = (String) session.getAttribute("QuizCategory");
	}
	else{
		quizName=(String)request.getAttribute("quizName");
		quizCategory=(String)request.getAttribute("quizCategory");
	}
	request.setAttribute("quizName", quizName);
	request.setAttribute("quizCategory", quizCategory);
    int totalQuestions = (questions != null) ? questions.size() : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Questions</title>

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

    .quiz-info-box {
        background: white;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 3px 15px rgba(0,0,0,0.12);
        margin-bottom: 25px;
        border-left: 6px solid #2196f3;
    }

    .quiz-info-box h2 {
        margin: 0 0 10px;
        color: #1a237e;
    }

    .quiz-info-box p {
        margin: 5px 0;
        font-size: 16px;
        color: #333;
    }

    .back-btn {
        display: inline-block;
        margin-top: 15px;
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

    .question-card {
        background: white;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 18px rgba(0,0,0,0.1);
        border-left: 6px solid #2196f3;
        transition: 0.2s ease;
    }

    .question-title {
        font-size: 20px;
        font-weight: bold;
        color: #1a237e;
    }

    .options-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 8px 18px;
        margin: 12px 0 0 10px;
        font-size: 16px;
        color: #333;
    }

    .answer {
        margin-top: 12px;
        padding: 10px;
        background: #e8f5e9;
        color: #2e7d32;
        font-weight: bold;
        border-radius: 8px;
        display: inline-block;
    }

    .edit-btn {
        display: inline-block;
        background: #ff9800;
        color: white;
        padding: 8px 15px;
        border-radius: 8px;
        font-size: 14px;
        text-decoration: none;
        float: right;
        transition: 0.2s;
        margin-top: -40px;
    }

    .edit-btn:hover {
        background: #fb8c00;
        transform: scale(1.05);
    }

    .quiztitle {
        display: flex;
        flex-direction: column;
    }

    .subquiztitle {
        display: flex;
        justify-content: space-between;
        padding-bottom: 20px;
    }
</style>
</head>

<body>

<div class="navbar">
    <div class="logo">Admin<span>Pro</span></div>
</div>

<div class="container">

    <div class="quiztitle">
        <center><h2><%= quizName %></h2></center>
        <div class="subquiztitle">
            <p><strong>Category:</strong> <%= quizCategory %></p>
            <p><strong>Total Questions:</strong> <%= totalQuestions %></p>
        </div>
    </div>

    <% 
        if (questions != null && !questions.isEmpty()) { 
            int qNo = 1;
            for (Questions q : questions) { 
    %>

        <div class="question-card">

            <div class="question-title">
                Q<%= qNo++ %>. <%= q.getQuestion() %>
            </div>

            <% 
                if (q.getOptionType().equalsIgnoreCase("mcq") || 
                    q.getOptionType().equalsIgnoreCase("multi-select")) {
            %>

                <div class="options-grid">
                    <div>A) <%= q.getOption1() %></div>
                    <div>B) <%= q.getOption2() %></div>
                    <div>C) <%= q.getOption3() %></div>
                    <div>D) <%= q.getOption4() %></div>
                </div>

            <% 
                } else { 
            %>

                <div class="options-grid">
                    <div>A) <%= q.getOption1() %></div>
                    <div>B) <%= q.getOption2() %></div>
                </div>

            <% } %>

            <div class="answer">Correct Answer: <%= q.getAnswer() %></div>

            <a class="edit-btn" href="EditQuestion?id=<%= q.getId() %>&quizName=<%=quizName%>&quizCategory=<%=quizCategory%>">Edit</a>
        </div>

    <% 
            } 
        } else { 
    %>

        <h3 style="text-align:center; color:#555;">No questions found.</h3>

    <% } %>

    <a href="ContentManagement" class="back-btn">Save and Back to Category Management</a>

</div>

</body>
</html>
